class ApplicationJob < ActiveJob::Base
  def judge_params
    params_judge = 'base64_encoded=false&fields=status,language,time&page=4&per_page=2'
  end
end
