class AnswController < ApplicationController
  def new

  end

  def edit

  end

  def index

  end

  def show

  end

  def update

  end

  def destroy

  end




  def self.do_it
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


   # authenticator = DropboxApi::Authenticator.new(@APP_KEY, @APP_SECRET)

  #  puts "url: " + authenticator.authorize_url

   # print "write the authorization code: "
  #  code = gets.strip

   # auth_bearer = authenticator.get_token(code)
  #  token = auth_bearer.token
  #  puts "token = " + token

    #client = DropboxApi::Client.new(ENV['wf9D-O0OWuAAAAAAAAAASbK3jEgLrB_vnBuiYqgUlWa8n7reoDEuRm5ugifZm9hB'])
    client = DropboxApi::Client.new("wf9D-O0OWuAAAAAAAAAASt0sZwocWVpB3FCm903NkPOApJdhpZAV9AViT_ErtJy1")
   # client = DropboxApi::Client.new(token)
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




  def create_answ

    #redirect_to url_with_protocol("google.com")
    #AnswController.do_it

    #SendToDropboxJob.set(wait: 5.seconds).perform_later(1)

    CreateAnswerJob.set(wait: 5.seconds).perform_later(1)

   # @users = User.where(activated: true).paginate(page: params[:page])
    @test = Answer.find_by_user_id(current_user.id)


    unless params[:answ][:content].blank?

   #   CreateAnswerJob.set(wait: 5.seconds).perform_later(@test,params[:answ][:content])

      if @test.nil?
        @answer = Answer.new(content:params[:answ][:content],user_id:current_user.id,
                             task_id:current_user.task_id, sending:false )

        if @answer.save
          flash[:success] = " Ur answer was creating"
        end

      else

        @test.content = params[:answ][:content]
        @test.sending = false

        if @test.save
          flash[:success] = " Answer was updating"
          end
        end
     # Answer.delay.create_answ(@test,params[:answ][:content])

       redirect_to root_path
     # redirect_to url_with_protocol("google.com")
    else
      flash[:danger] = 'Field can\'t be blank '
      render 'new'
    end
    end
end





#  res = RestClient.get 'https://api.judge0.com/languages'
#  puts "--------------------------------------------------------------------------------------------------------------------------------------------------------------"
#  puts res
#  puts "--------------------------------------------------------------------------------------------------------------------------------------------------------------"

#include <stdio.h>\n\nint main(void) {\n  char name[10];\n  scanf(\"%s\", name);\n  printf(\"hello, %s\n\", name);\n  return 0;\n}