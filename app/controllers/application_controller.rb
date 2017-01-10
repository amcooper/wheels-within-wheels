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
  	# if params[:username] == "" || params[:email] == "" || params[:password] == ""
  	# 	redirect '/signup'
  	# else
	  	@user = User.create(params)
	  	session[:user_id] = @user.id
	  	redirect '/crudapps'
	  # end
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
				column[:key_name] = slug(column[:key_name])
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

	#patch - Not working. Hm.
	post "/crudapps/:id" do
	# patch "/crudapps/:id" do
		binding.pry
		if logged_in?
			@crudapp = Crudapp.find(params[:id])
			if current_user.id == @crudapp.user_id
				@crudapp.update(params[:crudapp])
				params[:columns].each do |params_column|
	        column = Column.find_or_create_by(id: params_column[:id])
					@crudapp.columns << @column.update(params_column)
				end
				redirect "/crudapps/#{@crudapp.id}"
			else
				redirect "/crudapps"
			end
		else
			redirect "/login"
		end
	end

	get '/crudapps/:id/zipdl' do
		crudapp = Crudapp.find(params[:id])
		send_file "assets/creations/#{crudapp.title}.zip"
	end

	delete '/crudapps/:id' do
		if logged_in?
			crudapp = Crudapp.find(params[:id])
			if current_user.id == crudapp.user_id
				FileUtils.cd('assets/creations') do
					FileUtils.remove_entry_secure("#{slug(crudapp.title)}.zip")
				end
				crudapp.destroy
				redirect "/crudapps"
			else
				redirect "/crudapps/#{crudapp.id}"
			end
		else
			redirect "/login"
		end
	end

end
