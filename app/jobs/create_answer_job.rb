class CreateAnswerJob < ApplicationJob
  queue_as :low_priority

  def perform(t)
    # Do something later
    sleep 10
    puts "=============FIRST STAGE"
    @answers = Answer.all
    #puts "============ #{@answers.first.id}"
    @answers.each do |answer|
      student_answer = Studentanswer.find_by_answer_id(answer.id)
      next if student_answer.sending == true
      unless answer.content.nil?
        puts "============= REQUESTING TO API"
        res =  RestClient.post 'https://api.judge0.com/submissions/?base64_encoded=false&wait=false/',
                             {language_id: '4', source_code: "#{answer.content}"}
        puts "============= HAVE RESULTS FROM API"
        res = JSON.parse(res)    #  Parsing JSON file
        puts "============= ADDED"
        answer.content = res["token"]
        puts "===== content final"
        student_answer.sending = true
        student_answer.save
        puts "===== sending final"
        answer.save
        puts "===== save final"
        puts "========== id : #{answer.id}, sending: #{student_answer.sending}"
      end
    end
    #delay.(run_at: Proc.new{ 10.seconds.from_now }).perform("qwe")
  end

  handle_asynchronously :perform

end
