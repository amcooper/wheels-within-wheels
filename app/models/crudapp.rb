class Crudapp < ActiveRecord::Base

  include Slugify::Slugger
  extend Slugify::Slugfinder

	has_many :columns
	belongs_to :user

end