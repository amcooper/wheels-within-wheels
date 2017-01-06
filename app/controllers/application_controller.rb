require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
  	set :public_folder, 'public'
  	set :views, 'app/views'
  	enable :sessions
  	set :session_secret, 'riserobotsrise'
  end

  helpers Helpers, FindAndReplace

	get '/' do
		redirect '/login'
	end

  get '/login' do
  	if logged_in?
  		redirect '/crudapps'
  	else
  	  erb :'users/login'
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

  get '/logout' do
  	if logged_in?
  		session.clear
  	end
		redirect '/login'
  end

  get '/signup' do
  	if logged_in?
  		redirect '/crudapps'
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
		@crudapps = Crudapp.all
		erb :'crudapps/index'
	end

	get '/crudapps/new' do
		if logged_in?
			erb :'crudapps/new'
		else
			redirect '/login'
		end
	end

	post '/crudapps' do
		if logged_in?
			@crudapp = Crudapp.new(params[:crudapp])
			@crudapp.user_id = current_user.id
			@crudapp.save
			params[:columns].each do |column|
				@crudapp.columns << Column.create(column)
			end
			@crudapp.zipper
			redirect "/crudapps/#{@crudapp.id}"
		else
			redirect "/login"
		end
	end

	get '/crudapps/:id' do
		@crudapp = Crudapp.find(params[:id])
		erb :'crudapps/show'
	end

	get '/crudapps/:id/edit' do
		if logged_in?
			@crudapp = Crudapp.find(params[:id])
			erb :'crudapps/edit'
		else
			redirect "/login"
		end
	end

	patch '/crudapps' do
		if logged_in? && params[:crudapp[:user_id]] == current_user.id
			@crudapp = Crudapp.find(params[:id])
			@crudapp.update(params[:crudapp])
			params[:columns].each do |params_column|
        column = Column.find(params_column[:id])
				@crudapp.columns << @column.update(params_column)
			end
			redirect "/crudapps/#{@crudapp.id}"
		else
			redirect "/login"
		end
	end

	get '/crudapps/:id/zipdl' do
		crudapp = Crudapp.find(params[:id])
		send_file "assets/creations/#{crudapp.title}.zip"
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

#######################
#
# This method, culled from Stack Overflow,
# works. To expand, maybe I put all the 
# substitution targets and replacements into 
# session[:app] and iterate over them and run
# #file_edit on them.
#
			file_edit(File.join(session[:app],"public","index.html"), /xTITLEx/, session[:app])

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
		send_file "assets/creations/#{session[:app]}.zip"

		# This redirect isn't working. How do I 
		# redirect after the download?
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
