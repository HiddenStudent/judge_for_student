class SendToDropboxJob < ApplicationJob
  queue_as :low_priority



  def perform(id)

    puts "-------------------------|||||||||||-----------------------------------"

    @APP_KEY =  'mpevvugos9qdluz'
    @APP_SECRET = 'qfvev9j7yccr3q3'
    @ACCESS_TOKEN = 'wf9D-O0OWuAAAAAAAAAASt0sZwocWVpB3FCm903NkPOApJdhpZAV9AViT_ErtJy1'
=begin
    require 'dropbox_sdk'
    puts "FIRST"
    flow = DropboxOAuth2FlowNoRedirect.new(@APP_KEY, @APP_SECRET)
    authorize_url = flow.start()
    # Have the user sign in and authorize this app
     puts '1. Go to: ' + authorize_url
     puts '2. Click "Allow" (you might have to log in first)'
     puts '3. Copy the authorization code'
     print 'Enter the authorization code here: '
    #puts "SECOND"
    code = gets.strip
    # This will fail if the user gave us an invalid authorization code
    puts "THIRD"
    access_token, user_id = flow.finish(code)
    puts "FORTH"
    client = DropboxClient.new(access_token)
    puts "FIFTH"
   # puts "linked account:", client.account_info().inspect
    puts "user_id: #{user_id}"

    flow = DropboxOAuth2FlowNoRedirect.new(APP_KEY, APP_SECRET)
    authorize_url = flow.start
    puts '1. Go to:' + authorize_url
    puts '2. Click "Allow" (you might have to log in first)'
    puts '3. Copy the authorize code'
    print 'Enter the authorize code here: '
    code = gets.strip
    access_token, user_id = flow.finish(code)
    client = DropboxClient.new(access_token)
    puts "linked account:", client.account_info().inspect



    # authenticator = DropboxApi::Authenticator.new(@APP_KEY, @APP_SECRET)

    #  puts "url: " + authenticator.authorize_url

    # print "write the authorization code: "
    #  code = gets.strip

    # auth_bearer = authenticator.get_token(code)
    #  token = auth_bearer.token
    #  puts "token = " + token

   #client = DropboxApi::Client.new(ENV['wf9D-O0OWuAAAAAAAAAASbK3jEgLrB_vnBuiYqgUlWa8n7reoDEuRm5ugifZm9hB'])
=end

    client = DropboxApi::Client.new("wf9D-O0OWuAAAAAAAAAASt0sZwocWVpB3FCm903NkPOApJdhpZAV9AViT_ErtJy1")

    puts "CLIENT WAS CREATED!"

    puts "OK , LETS UPLOAD A FILE..."

    user = User.find_by_id(id)
    answer = Answer.find_by_user_id(id)
    text = RestClient.get  "https://api.judge0.com/submissions/#{answer.content}?
  base64_encoded=false&fields=stdout,stderr,status_id,language_id,time,compile_output"
    file = client.upload("/#{user.email.split('@').first}/task#{user.task_id}_#{user.updated_at}.txt", "#{text}") # => Dropbox::FileMetadata
    #puts file.size # => 9
    #puts file.rev # => a1c10ce0dd78
    puts "FILE WAS UPLOADED!"


    puts "------------------------------------------------------------"


  end
end
