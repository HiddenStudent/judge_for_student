class ReqFromJudgeJob < ApplicationJob
  queue_as :default

  def perform(id)
    puts "=============FIRST STAGE"
    @answer = Answer.where(id: id)
      puts "============= REQUESTING TO API"
      res =  RestClient.get "https://api.judge0.com/submissions/
                            #{@answer.content}?
                            base64_encoded=false&fields=stdout,stderr,
                            status_id,language_id,time,compile_output"
      puts "============= HAVE RESULTS FROM API"
      #res = JSON.parse(res)    #  Parsing JSON file
      puts "============= FINISH"
  end
end
