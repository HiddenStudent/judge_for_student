class CreateAnswerJob < ApplicationJob
  queue_as :low_priority

  def perform(t)
    sleep 10
    @answers = Answer.all
    @answers.each do |answer|
      student_answer = Studentanswer.find_by_answer_id(answer.id)
      next if student_answer.sending == true
      unless answer.content.nil?
        res =  RestClient.post 'https://api.judge0.com/submissions/?base64_encoded=false&wait=false/',
                             {language_id: '4', source_code: "#{answer.content}"}
        res = JSON.parse(res)    #  Parsing JSON file
        answer.content = res["token"]
        student_answer.sending = true
        student_answer.save
        answer.save
        puts "::Answer updated"
      end
    end
  end

  handle_asynchronously :perform

end
