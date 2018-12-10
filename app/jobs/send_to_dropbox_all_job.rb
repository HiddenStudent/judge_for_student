class SendToDropboxAllJob < ApplicationJob
  queue_as :default

  def perform(task_id)
    puts "-------------------------|||||||||||-----------------------------------"
    @APP_KEY =  'mpevvugos9qdluz'
    @APP_SECRET = 'qfvev9j7yccr3q3'
    @ACCESS_TOKEN = 'wf9D-O0OWuAAAAAAAAAASt0sZwocWVpB3FCm903NkPOApJdhpZAV9AViT_ErtJy1'
    client = DropboxApi::Client.new("wf9D-O0OWuAAAAAAAAAASt0sZwocWVpB3FCm903NkPOApJdhpZAV9AViT_ErtJy1")

    #@answers.each do |answer|
    #if User.find_by_id(answer.user_id).status == "complete"
    #puts "nil?   #{answer.nil?}, answer.id  #{answer.id},status = #{User.find_by_id(answer.user_id).status }"
    #file = client.upload("/task#{task_id}/user_id_#{answer.user_id}.txt", "#{answer.content}") # => Dropbox::FileMetadata
    answers = Studentanswer.where(task_id: task_id)
    arr = []
    puts "-------------I trying write to FILE"
    answers.each do |answer|
      if answer.status == "complete"
        puts "nil?   #{answer.nil?},status = #{answer.status }"
        file = "task_#{Atask.find(task_id).name}_user_#{answer.user_id}.text"
        filepath = "stuff_to_zip/#{file}"
        File.new(filepath, "w")
        arr += [file]
        print arr
        File.open(filepath, "w+") do |f|
          text = RestClient.get  "https://api.judge0.com/submissions/#{Answer.find(answer.answer_id).content}?
                               base64_encoded=false&fields=status,language,time&page=4&per_page=2"
          f.write(text)
        end
      end
      puts
    end

    #File.new("home/developer/stuff_to_zip/test_list.text", "w")
    #path = "home/developer/stuff_to_zip/test_list.text"
    #content = "data from the form"
    #File.open(path, "w+") do |f|
    # f.write(content)
    puts "-------------I trying write to FILE"



    puts "-------------I trying create ZIP"
    require 'rubygems'
    require 'zip'
    folder = "/home/developer/rails_project/student_app/stuff_to_zip"
    puts "1"
    input_filenames = arr
    puts "2"
    zipfile_name = "/home/developer/rails_project/student_app/archives/archive_task#{task_id}_#{Random.new.rand(100)}.zip"
    puts"3"
    Zip::File.open(zipfile_name, Zip::File::CREATE) do |zipfile|
      puts "4"
      input_filenames.each do |filename|
      puts "5"
        zipfile.add(filename, File.join(folder, filename))
        puts "6"
      end
      puts "7"
      zipfile.get_output_stream("myFile") { |f| f.write "myFile contains just this" }
      puts "8"
    end
    puts "-------------I tried create ZIP"


    File.open(zipfile_name) do |f|
      puts "eboy"
      client.upload_by_chunks "/task#{task_id}_#{Random.new.rand(100)}", f
      puts "nooo"
    end

    puts "CLIENT WAS CREATED!"
    puts "OK , LETS UPLOAD A FILE..."
    puts "------------------------------------------------------------"
  end
end
=begin
    puts "OK1"
    @answers.each do |answer|
      puts "OK2"
    if User.find_by_id(answer.user_id).status == "complete"
      puts "nil?   #{answer.nil?}, answer.id  #{answer.id},status = #{User.find_by_id(answer.user_id).status }"
     # puts   "answer.status = #{answer.status} , answer.id = #{answer.id}"

    # puts "status = #{User.find_by_id(answer.user_id).status }"
     # if answer.status == "complete"

      puts "OK3"
    file = client.upload("/task#{task_id}/user_id_#{answer.user_id}.txt", "#{answer.content}") # => Dropbox::FileMetadata
   # puts file.size # => 9
    #puts file.rev # => a1c10ce0dd78
    puts "FILE WAS UPLOADED!"
      else
       next
       end
    end
=end