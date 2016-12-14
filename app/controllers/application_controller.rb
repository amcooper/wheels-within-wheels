require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
  	set :public_folder, 'public'
  	set :views, 'app/views'
  	enable :sessions
  	set :session_secret, 'riserobotsrise'
  end

	get '/' do
	  "<h3>Hello, traveler. Head to <a href='/attachment'>'/attachment'</a> or <a href='/thebigfile'>'/thebigfile'</a>.</h3>"
	end

	# get '/thefile' do
	#   send_file 'thefile.txt'
	# end

	# get '/thebigfile' do
	# 	send_file 'the_big_file.txt.gz'
	# end

	# get '/attachment' do
	# 	attachment 'the_big_file.txt.gz'
	# end

end
