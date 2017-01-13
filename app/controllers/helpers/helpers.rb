module Helpers
	def current_user
		User.find(session[:user_id])
	end

	def logged_in?
		!!session[:user_id]
	end

	def slug(string)
	  string.strip.downcase.gsub(/(&|&amp;)/, ' and ').gsub(/[\s\.\/\\]/, '-').gsub(/[^\w-]/, '').gsub(/[-_]{2,}/, '-').gsub(/^[-_]/, '').gsub(/[-_]$/, '')			
	end
end
