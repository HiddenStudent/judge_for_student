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

  def create_answ
   # @answer = Answer.new(content:params[:answ][:content])
  #  if @answer.save

      flash[:success] = "Answer was send"

      require 'open-uri'
      response = open('https://api.judge0.com/languages').read
      puts "--------------------------------------------------------------------------------------------------------------------------------------------------------------"
     puts response
      puts "--------------------------------------------------------------------------------------------------------------------------------------------------------------"





      require 'json'

      require "net/http"
      require "uri"

      uri = URI.parse("https://api.judge0.com/submissions/?base64_encoded=false&wait=false/")

# Shortcut
    #response = Net::HTTP.post_form(uri, {"q" => "My query", "per_page" => "50"})

# Full control
    http = Net::HTTP.new(uri.host, uri.port)

    request = Net::HTTP::Post.new(uri.request_uri)
    request.set_form_data({"language_id" => "4","source_code" => "#include <stdio.h>\n\nint main(void) {\n  char name[10];\n  scanf(\"%s\", name);\n
     #                                                       printf(\"hello, %s\n\", name);\n  return 0;\n)"})

    response = http.request(request)


    #  @urlstring_to_post = 'https://api.judge0.com/submissions/?base64_encoded=false&wait=false/'
     # @result = HTTParty.post(@urlstring_to_post.to_str,
     #                         :body => { "source_code": '#include <stdio.h>\n\nint main(void) {\n  char name[10];\n  scanf(\"%s\", name);\n
     #                                                       printf(\"hello, %s\n\", name);\n  return 0;\n}',
      #                                   "language_id": 4,
#
      #                        }.to_json)



      puts "--------------------------------------------------------------------------------------------------------------------------------------------------------------"

      puts response

      puts "--------------------------------------------------------------------------------------------------------------------------------------------------------------"



      redirect_to root_path
      #debugger
    #else

      #flash.now[:danger] = 'Invalid combination'
      #render 'new'
  #  end
  end
end
