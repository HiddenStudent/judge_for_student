class SendToDropboxJob < ApplicationJob
  queue_as :low_priority

  def perform(id, task_id)
    puts '-----------------------Sending to Dropbox----------------------------'
    client = DropboxApi::Client.new(ENV["DROPBOX_TOKEN"])
    user = User.find(id)
    answer = user.u_answers(id, task_id)
    text = RestClient.get "https://api.judge0.com/submissions/#{answer.content}?
                           #{judge_params}"

    file = client.upload("/#{user.email.split('@').first}_#{user.id}/task#{task_id}_#{answer.updated_at}.txt", "#{text}")
    puts '::Answer was sent to Dropbox'
  end
end