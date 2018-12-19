class CreateAnswerJob < ApplicationJob
  queue_as :low_priority

  def perform
    puts '----------------------------------------------'
    answers = Answer.all
    answers.each do |answer|
      next if answer.sending
      next unless answer.text
      next unless answer.status =='In process'
        res = RestClient.post 'https://api.judge0.com/submissions/?base64_encoded=false&wait=false/',
                              {language_id: '4', source_code: "#{answer.text}"}
        res = JSON.parse(res) #  Parsing JSON file
        answer.content = res["token"]
        answer.sending = true
        answer.save
        puts '::Answer updated'
    end
  end
  Delayed::Job.enqueue CreateAnswerJob.new, run_at: 40.seconds.from_now
end
