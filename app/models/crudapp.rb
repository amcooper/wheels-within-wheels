class Crudapp < ActiveRecord::Base

  include Slugify::Slugger
  extend Slugify::Slugfinder

	has_many :columns
	belongs_to :user

	SUBSTITUTIONS = [
	  { file: ["app","models","item.js"],
	  	findString: "attr0",
	  	replaceString: "columns[0][key_name]" },
	  { file: ["app","models","item.js"],
	  	findString: "attr1",
	  	replaceString: "columns[1][key_name]" },
	  { file: ["app","models","item.js"],
	  	findString: "attr2",
	  	replaceString: "columns[2][key_name]" },
	  { file: ["app","models","item.js"],
	  	findString: "DataType0",
	  	replaceString: "columns[0][data_type]" },
	  { file: ["app","models","item.js"],
	  	findString: "DataType1",
	  	replaceString: "columns[1][data_type]" },
	  { file: ["app","models","item.js"],
	  	findString: "DataType2",
	  	replaceString: "columns[2][data_type]" },
	  { file: ["app","routes.js"],
	  	findString: "attr0",
	  	replaceString: "columns[0][key_name]" },
	  { file: ["app","routes.js"],
	  	findString: "attr1",
	  	replaceString: "columns[1][key_name]" },
	  { file: ["app","routes.js"],
	  	findString: "attr2",
	  	replaceString: "columns[2][key_name]" },
	  { file: ["config","database.js"],
	    findString: "appName",
	    replaceString: "title" },
	  { file: ["public","js","app.js"],
	    findString: "nodeWheels",
	    replaceString: "title" },
	  { file: ["public","js","controllers.js"],
	    findString: "nodeWheels",
	    replaceString: "title" },	  
    { file: ["public","js","services.js"],
	    findString: "nodeWheels",
	    replaceString: "title" },
	  { file: ["public","partials","_form.html"],
	  	findString: "attr0",
	  	replaceString: "columns[0][key_name]" },
	  { file: ["public","partials","_form.html"],
	  	findString: "attr1",
	  	replaceString: "columns[1][key_name]" },
	  { file: ["public","partials","_form.html"],
	  	findString: "attr2",
	  	replaceString: "columns[2][key_name]" },
	  { file: ["public","partials","item-view.html"],
	  	findString: "attr0",
	  	replaceString: "columns[0][key_name]" },
	  { file: ["public","partials","item-view.html"],
	  	findString: "attr1",
	  	replaceString: "columns[1][key_name]" },
	  { file: ["public","partials","item-view.html"],
	  	findString: "attr2",
	  	replaceString: "columns[2][key_name]" }
	  { file: ["public","partials","items.html"],
	  	findString: "attr0",
	  	replaceString: "columns[0][key_name]" },
	  { file: ["public","partials","items.html"],
	  	findString: "Item",
	  	replaceString: "model" },
    { file: ["public","index.html"],
	    findString: "nodeWheels",
	    replaceString: "title" },
    { file: ["package.json"],
	    findString: "nodeWheels",
	    replaceString: "title" }
  ]

	def zipper
		FileUtils.cd('assets/creations') do 
			FileUtils.mkdir "#{@title}"
			FileUtils.cp_r '../raw_material/.', "#{@title}"

      SUBSTITUTIONS.each do |substitution|
				file_edit(File.join(@title,substitution.file), substitution.findString, self.send(substitution.replaceString))
			end

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

		"#{@title}.zip"
	end

end