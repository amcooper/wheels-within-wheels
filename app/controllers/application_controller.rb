require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
  	set :public_folder, 'public'
  	set :views, 'app/views'
  	enable :sessions
  	set :session_secret, 'riserobotsrise'
  end

  helpers Helpers

	get '/' do
	  "<h3>Hello, traveler. Welcome to Wheels Within Wheels.</h3>"
	end

  get '/login' do
  	if logged_in?
  		redirect '/tweets'
  	else
  	  erb :'users/login'
  	end
  end

  get '/logout' do
  	if logged_in?
  		session.clear
  		redirect '/login'
  	else
	  	redirect '/'
	  end
  end

  post '/login' do
  	@user = User.find_by(username: params[:username])
  	if @user && @user.authenticate(params[:password])
  		session[:user_id] = @user.id
  		redirect '/crudapps'
  	else
  		redirect '/login'
  	end
  end

  get '/signup' do
  	if logged_in?
  		redirect '/tweets'
  	else
	  	erb :'users/signup'
	  end
  end

  post '/signup' do
  	if params[:username] == "" || params[:email] == "" || params[:password] == ""
  		redirect '/signup'
  	else
	  	@user = User.create(params)
	  	session[:user_id] = @user.id
	  	redirect '/crudapps'
	  end
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

	get '/ziptest' do
		erb :ziptest
	end

	post '/ziptest' do
		session[:app] = params[:subtest]
		FileUtils.cd('assets/creations') do 
			FileUtils.mkdir "#{session[:app]}"
			FileUtils.cp_r '../raw_material/.', "#{session[:app]}"
			Zip::Archive.open("#{session[:app]}.zip", Zip::CREATE) do |archive|
				archive.add_dir("#{session[:app]}")
				Dir.glob("#{session[:app]}/**/*").each do |path|
					if File.directory?(path)
						archive.add_dir(path)
					else
						archive.add_file(path, path)
					end
				end
			end
		end
		redirect '/dlziptest'
	end

	get '/dlziptest' do
		puts "session[:app]: #{session[:app]}"
		send_file "assets/creations/#{session[:app]}.zip"
		redirect '/'
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
