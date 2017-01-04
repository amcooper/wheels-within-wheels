class Crudapp < ActiveRecord::Base

  include Slugify::Slugger
  extend Slugify::Slugfinder

	has_many :columns
	belongs_to :user

	def zipper
		FileUtils.cd('assets/creations') do 
			FileUtils.mkdir "#{@title}"
			FileUtils.cp_r '../raw_material/.', "#{@title}"

#######################
#
# This method, culled from Stack Overflow,
# works. To expand, maybe I put all the 
# substitution targets and replacements into 
# session[:app] and iterate over them and run
# #file_edit on them.
#
			file_edit(File.join(@title,"public","index.html"), /xTITLEx/, @title)

			Zip::Archive.open("#{@title}.zip", Zip::CREATE) do |archive|
				archive.add_dir("#{@title}")
				Dir.glob("#{@title}/**/*").each do |path|
					if File.directory?(path)
						archive.add_dir(path)
					else
						archive.add_file(path, path)
					end
				end
			end
		end
	end

end