class CreateAnswerJob < ApplicationJob
  queue_as :low_priority

  def perform(t)
    # Do something later
    sleep 10
    puts "=============FIRST STAGE"
    @answers = Answer.all
   #puts "============ #{@answers.first.id}"

    @answers.each do |answer|
      next if answer.sending == true
      puts "============= REQUESTING TO API"
      res =  RestClient.post 'https://api.judge0.com/submissions/?base64_encoded=false&wait=false/',
                             {language_id: '4', source_code: "#{answer.content}"}

      puts "============= HAVE RESULTS FROM API"
      res = JSON.parse(res)    #  Parsing JSON file
      puts "============= ADDED"
      answer.content = res
      answer.sending = true
      answer.save



    end

   # delay.(run_at: Proc.new{ 10.seconds.from_now }).perform("qwe")
  end
  handle_asynchronously :perform
end
