class SendToDropboxJob < ApplicationJob
  queue_as :low_priority

  def perform(id, task_id)
    puts "-------------------------|||||||||||-----------------------------------"
    @APP_KEY =  'mpevvugos9qdluz'
    @APP_SECRET = 'qfvev9j7yccr3q3'
    @ACCESS_TOKEN = 'wf9D-O0OWuAAAAAAAAAASt0sZwocWVpB3FCm903NkPOApJdhpZAV9AViT_ErtJy1'
    client = DropboxApi::Client.new("wf9D-O0OWuAAAAAAAAAASt0sZwocWVpB3FCm903NkPOApJdhpZAV9AViT_ErtJy1")

    user = User.find(id)
    answer = Studentanswer.where(task_id: task_id)
    answer = answer.find_by_user_id(id)
    text = RestClient.get  "https://api.judge0.com/submissions/#{Answer.find(answer.answer_id).content}?
                               base64_encoded=false&fields=status,language,time&page=4&per_page=2"

    file = client.upload("/#{user.email.split('@').first}/task#{task_id}_#{answer.updated_at}.txt", "#{text}") # => Dropbox::FileMetadata
    puts "::Answer was sent to Dropbox"
  end
end