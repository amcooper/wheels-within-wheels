class User < ActiveRecord::Base

  validates :username, :email, :password, presence: true
  validates :username, :email, uniqueness: true
  
  include Slugify::Slugger
  extend Slugify::Slugfinder

	has_secure_password
	has_many :crudapps

end