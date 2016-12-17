class User < ActiveRecord::Base

  include Slugify::Slugger
  extend Slugify::Slugfinder

	has_secure_password
	has_many :crudapps

end