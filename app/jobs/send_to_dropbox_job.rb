class SendToDropboxJob < ApplicationJob
  queue_as :low_priority



  def perform(a)

    puts "-------------------------|||||||||||-----------------------------------"

    @APP_KEY =  'mpevvugos9qdluz'
    @APP_SECRET = 'qfvev9j7yccr3q3'
    @ACCESS_TOKEN = 'wf9D-O0OWuAAAAAAAAAAD4bUEnBwQwGqoeY95p-Y7Sc6yQD0v9vrBYARrHmkD9bt'
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
=begin
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
=end
    authenticator = DropboxApi::Authenticator.new(@APP_KEY, @APP_SECRET)

    puts "url: " + authenticator.authorize_url

    print "write the authorization code: "
    code = gets.strip

    auth_bearer = authenticator.get_token(code)
    token = auth_bearer.token
    puts "token = " + token

    client = DropboxApi::Client.new(token)
    puts "CLIENT WAS CREATED!"
    #folder = client.create_folder('/myfolder2') # => Dropbox::FolderMetadata
    #puts folder.id # id : 13124512
    #puts folder.name #myfolder
    #puts folder.path_lower # /myfolder

    puts "OK , LETS UPLOAD A FILE..."

    #result = client.list_folder "/sample_folder"
    #result.entries
    # result.has_more?
    file = client.upload('/myfolder/file2.txt', 'file body') # => Dropbox::FileMetadata
    puts file.size # => 9
    puts file.rev # => a1c10ce0dd78
    puts "FILE WAS UPLOADED!"


    puts "------------------------------------------------------------"
    #  @session = DropboxSession.new(@APP_KEY,@APP_SECRET)
    # @client = DropboxClient.new(@session,)


    # App key = 5y63yn7q0asdsb5
    # App secret = yxieb3fct08yh9o

  end
end