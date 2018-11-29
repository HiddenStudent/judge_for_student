class Answer < ApplicationRecord
  belongs_to :users, optional: true



  def self.create_answ(test, content)
=begin
    res =  RestClient.post 'https://api.judge0.com/submissions/?base64_encoded=false&wait=false/',
                           {language_id: '4', source_code: "#{content}"}


    res = JSON.parse(res)    #  Parsing JSON file

    if test.nil?
      @answer = Answer.new(content:res['token'],user_id:current_user.id,task_id:current_user.task_id )

      if @answer.save
       puts " ==================== Ur answer was creating"
      end

    else

      test.content = res['token']

      if test.save
        puts " =================== Answer was updating"
      end
    end

    puts "======== token: #{res['token']}"
=end
puts "=======qqqqqqqqqq"
  end



end



