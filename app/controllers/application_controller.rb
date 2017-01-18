require './config/environment'
require 'rack-flash'

class ApplicationController < Sinatra::Base

  configure do
  	set :public_folder, 'public'
  	set :views, 'app/views'
  	enable :sessions
  	set :session_secret, 'riserobotsrise'
  end

  after do
	ActiveRecord::Base.connection.close
  end

  use Rack::Flash

  helpers Helpers

	get '/' do
		redirect '/login'
	end

	get '/about' do
		markdown :about, :layout_engine => :erb
	end

  get '/login' do
  	if logged_in?
  		flash[:message] = "already logged in"
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
  		if !@user
  			flash[:message] = "unknown username"
  		else
  			flash[:message] = "incorrect password"
  		end
  		redirect '/login'
  	end
  end

  get '/logout' do
  	if logged_in?
  		session.clear
  	else
  		flash[:message] = "already logged out"	
  	end
		redirect '/login'
  end

  get '/signup' do
  	if logged_in?
  		flash[:message] = "already logged in"
  		redirect '/crudapps'
  	else
	  	erb :'users/signup'
	  end
  end

  post '/signup' do
  	@user = User.new(params)
  	if @user.save
	  	session[:user_id] = @user.id
	  	redirect '/crudapps'
	  else
	  	flash[:message] = @user.errors.full_messages.join(" | ")
	  	redirect '/signup'
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
  		flash[:message] = "please log in to create an app"
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
  		flash[:message] = "please log in to create an app"
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
  		flash[:message] = "please log in to edit an app"
			redirect "/login"
		end
	end

	post "/crudapps/:id" do
		if logged_in?
			@crudapp = Crudapp.find(params[:id])
			if current_user.id == @crudapp.user_id
				if !params[:crudapp]
					flash[:message] = "edit functionality is down!"
				else
					@crudapp.update(params[:crudapp])
					params[:columns].each do |params_column|
		        column = Column.find_or_create_by(id: params_column[1][:id].to_i)
						column.update(params_column[1])
					end
					@crudapp.zipper
				end
				redirect "/crudapps/#{@crudapp.id}"
			else
	  		flash[:message] = "you must be the app's creator to edit"
				redirect "/crudapps"
			end
		else
  		flash[:message] = "please log in to edit an app"
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
				crudapp.columns.each {|column| column.destroy }
				crudapp.destroy
				redirect "/crudapps"
			else
	  		flash[:message] = "you must be the app's creator to delete"
				redirect "/crudapps/#{crudapp.id}"
			end
		else
  		flash[:message] = "please log in to delete an app"
			redirect "/login"
		end
	end

end
