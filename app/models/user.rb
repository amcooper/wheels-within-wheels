class User < ActiveRecord::Base

  validates :username, :email, presence: true
  validates :username, :email, uniqueness: true
  # {message: "username and/or email already taken"}

  include Slugify::Slugger
  extend Slugify::Slugfinder

	has_secure_password
	has_many :crudapps

end