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
		FileUtils.mkdir 'assets/creations/ziptest'
		FileUtils.cp_r 'assets/raw_material/.', 'assets/creations/ziptest'
		Zip::Archive.open('assets/creations/ziptest.zip', Zip::CREATE) do |archive|
			archive.add_dir('ziptest')
			Dir.glob('assets/creations/ziptest/**/*').each do |path|
				if File.directory?(path)
					archive.add_dir(path)
				else
					archive.add_file(path, path)
				end
			end
		end
		redirect '/dlziptest'
	end

	get '/dlziptest' do
		send_file 'assets/creations/ziptest.zip'
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

# Zip::Archive.open('filename.zip', Zip::CREATE) do |ar|
#   ar.add_dir('dir')

#   Dir.glob('dir/**/*').each do |path|
#     if File.directory?(path)
#       ar.add_dir(path)
#     else
#       ar.add_file(path, path) # add_file(<entry name>, <source path>)
#     end
#   end
# end


# creating zip archive
# require 'zipruby'

# bar_txt =  open('bar.txt')

# Zip::Archive.open('filename.zip', Zip::CREATE) do |ar|
#   # if overwrite: ..., Zip::CREATE | Zip::TRUNC) do |ar|
#   # specifies compression level: ..., Zip::CREATE, Zip::BEST_SPEED) do |ar|

#     ar.add_file('foo.txt') # add file to zip archive

#   # add file to zip archive from File object
#   ar << bar_txt # or ar.add_io(bar_txt)

#   # add file to zip archive from buffer
#   ar.add_buffer('zoo.txt', 'Hello, world!')
# end

# bar_txt.rewind

# # include directory in zip archive
# Zip::Archive.open('filename.zip') do |ar|
#   ar.add_dir('dirname')
#   ar.add_file('dirname/foo.txt', 'foo.txt')
#       # args: <entry name>     ,  <source>

#   ar.add_io('dirname/bar.txt', bar_txt)
#     # args: <entry name>     , <source>

#   ar.add_buffer('dirname/zoo.txt', 'Hello, world!')
#         # args: <entry name>     , <source>
# end

# bar_txt.close # close file after archive closed

# # add huge file
# source = %w(London Bridge is falling down)

# Zip::Archive.open('filename.zip') do |ar|
#   # lb.txt => 'LondonBridgeisfallingdown'
#   ar.add('lb.txt') do # add(<filename>, <mtime>)
#     source.shift # end of stream is nil
#   end
# end
