module Helpers

	def current_user
		@current_user ||= User.find_by(id: session[:user_id]) unless session[:user_id].nil?
	end

	def logged_in?
		!!current_user
	end

	def slug(string)
	  string.strip.downcase.gsub(/(&|&amp;)/, ' and ').gsub(/[\s\.\/\\]/, '_').gsub(/[^\w-]/, '').gsub(/[-_]{2,}/, '_').gsub(/^[-_]/, '').gsub(/[-_]$/, '')			
	end
end
