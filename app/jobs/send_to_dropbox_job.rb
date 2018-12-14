class SendToDropboxJob < ApplicationJob
  queue_as :low_priority

  def perform(id, task_id)
    puts "-------------------------|||||||||||-----------------------------------"
    client = DropboxApi::Client.new("wf9D-O0OWuAAAAAAAAAASt0sZwocWVpB3FCm903NkPOApJdhpZAV9AViT_ErtJy1")
    user = User.find(id)
    answer = StudentAnswer.where(task_id: task_id)
    answer = answer.find_by_user_id(id)
    text = RestClient.get "https://api.judge0.com/submissions/#{Answer.find(answer.answer_id).content}?
                           #{judge_params}"

    file = client.upload("/#{user.email.split('@').first}_#{user.id}/task#{task_id}_#{answer.updated_at}.txt", "#{text}") # => Dropbox::FileMetadata
    puts "::Answer was sent to Dropbox"
  end
end