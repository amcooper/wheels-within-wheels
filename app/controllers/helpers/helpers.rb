module Helpers

	def current_user
		@current_user ||= User.find(session[:user_id]) unless session[:user_id].nil?
	end

	def logged_in?
		!!current_user
	end

	def slug(string)
	  string.strip.downcase.gsub(/(&|&amp;)/, ' and ').gsub(/[\s\.\/\\]/, '-').gsub(/[^\w-]/, '').gsub(/[-_]{2,}/, '-').gsub(/^[-_]/, '').gsub(/[-_]$/, '')			
	end
end
