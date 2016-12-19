module Helpers
	def current_user
		User.find(session[:user_id])
	end

	def logged_in?
		!!session[:user_id]
	end
end

module FindAndReplace

	require 'tempfile'

	def file_edit(filename, regexp, replacement)
	  Tempfile.open(".#{File.basename(filename)}", File.dirname(filename)) do |tempfile|
	    File.open(filename).each do |line|
	      tempfile.puts line.gsub(regexp, replacement)
	    end
	    tempfile.fdatasync
	    tempfile.close
	    stat = File.stat(filename)
	    FileUtils.chown stat.uid, stat.gid, tempfile.path
	    FileUtils.chmod stat.mode, tempfile.path
	    FileUtils.mv tempfile.path, filename
	  end
	end

end