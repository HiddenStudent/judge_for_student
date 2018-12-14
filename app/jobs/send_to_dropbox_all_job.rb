class SendToDropboxAllJob < ApplicationJob
  queue_as :default

  def perform(task_id)
    puts "-------------------------|||||||||||-----------------------------------"
    client = DropboxApi::Client.new("wf9D-O0OWuAAAAAAAAAASt0sZwocWVpB3FCm903NkPOApJdhpZAV9AViT_ErtJy1")
    answers = StudentAnswer.where(task_id: task_id)
    arr = []
    answers.each do |answer|
      next unless answer.status == "complete"
      file = "task_#{Task.find(task_id).name}_user_#{answer.user_id}.text"
      filepath = "stuff_to_zip/#{file}"
      File.new(filepath, "w")
      arr += [file]
      print arr
      File.open(filepath, "w+") do |f|
        text = RestClient.get "https://api.judge0.com/submissions/#{Answer.find(answer.answer_id).content}?
                               #{judge_params}"
        f.write(text)
      end
    end


    require 'rubygems'
    require 'zip'
    folder = "#{Dir.pwd}/stuff_to_zip"
    input_filenames = arr
    zipfile_name = "#{Dir.pwd}/archives/archive_task#{task_id}_#{Random.new.rand(100)}.zip"
    Zip::File.open(zipfile_name, Zip::File::CREATE) do |zipfile|
      input_filenames.each do |filename|
        zipfile.add(filename, File.join(folder, filename))
      end
      zipfile.get_output_stream("myFile") { |f| f.write "myFile contains just this" }
    end

    File.open(zipfile_name) do |f|
      client.upload_by_chunks "/#{zipfile_name.split('/').last}", f
      puts "::All answer was sent to Dropbox"
    end
  end
end