module UsersHelper
  def dropbox_delete(user_id)
    user = User.find(user_id)
    client = DropboxApi::Client.new(ENV["DROPBOX_TOKEN"])
    files = client.list_folder("")
    entries = files.entries
    entries.each do |entr|
      if entr.name == "#{user.email.split('@').first}_#{user.id}"
        @tmp = true
      end
    end
    client.delete "/#{user.email.split('@').first}_#{user.id}" if @tmp
  end
end
