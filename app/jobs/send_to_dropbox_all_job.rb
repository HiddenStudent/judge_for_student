class SendToDropboxAllJob < ApplicationJob
  queue_as :default

  def perform(task_id)

    puts "-------------------------|||||||||||-----------------------------------"

    @APP_KEY =  'mpevvugos9qdluz'
    @APP_SECRET = 'qfvev9j7yccr3q3'
    @ACCESS_TOKEN = 'wf9D-O0OWuAAAAAAAAAASt0sZwocWVpB3FCm903NkPOApJdhpZAV9AViT_ErtJy1'


    client = DropboxApi::Client.new("wf9D-O0OWuAAAAAAAAAASt0sZwocWVpB3FCm903NkPOApJdhpZAV9AViT_ErtJy1")
    puts "CLIENT WAS CREATED!"

    puts "OK , LETS UPLOAD A FILE..."

    @answers = Answer.where(task_id: task_id)
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

    puts "------------------------------------------------------------"


  end
end
