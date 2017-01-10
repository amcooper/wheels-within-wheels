class Column < ActiveRecord::Base

  include Slugify::Slugger
  extend Slugify::Slugfinder

	belongs_to :crudapp
	
end