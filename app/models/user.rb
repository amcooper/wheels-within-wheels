class User < ActiveRecord::Base

  validates :username, :email, :password, presence: {message: "all fields are required"}
  validates :username, :email, uniqueness: {message: "username and/or email already taken"}

  include Slugify::Slugger
  extend Slugify::Slugfinder

	has_secure_password
	has_many :crudapps

end