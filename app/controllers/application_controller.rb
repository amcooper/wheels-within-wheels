require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
  	set :public_folder, 'public'
  	set :views, 'app/views'
  	enable :sessions
  	set :session_secret, 'riserobotsrise'
  end

	get '/' do
	  "<h3>Hello, traveler. Welcome to Wheels Within Wheels.</h3>"
	end

	get '/login' do
		erb :'users/login'
	end

	post '/login' do
		user = User.find_by(username: params[:username])
	end

	get '/signup' do
		erb :'users/signup'
	end

	post '/signup' do
		User.create(params)
		redirect '/crudapps'
	end

	get '/crudapps' do
		erb :'crudapps/index'
	end

  ##############################################
  #
  # These test routes work. They create the file 
  # in the application root directory.
  #
	get '/testing' do
		erb :test
	end

	post '/testing' do
		open('testing.txt', 'w') {|f|
		  f.puts "We are testing the greatest app."
		}
		redirect '/testshow'
	end

	get '/testshow' do
		@filename = 'testingfile'
		erb :show
	end

	get '/testdl' do
		send_file 'testing.txt'
	end
	#
	#################################################

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
