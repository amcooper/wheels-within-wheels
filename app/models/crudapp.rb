# require '../controllers/helpers/helpers'

class Crudapp < ActiveRecord::Base

  include Slugify::Slugger
  extend Slugify::Slugfinder

  validates :title, presence: true

	require 'tempfile'

	has_many :columns
	belongs_to :user

	SUBSTITUTIONS = [
	  { file: ["app","models","item.js"],
	  	findString: "attr0",
	  	replacement: { 
	  		isArray: true, 
	  		first_attr: "columns",
				index: 0,
				second_attr: "key_name"
		  }
	  },
	  { file: ["app","models","item.js"],
	  	findString: "attr1",
	  	replacement: { 
	  		isArray: true, 
	  		first_attr: "columns",
				index: 1,
				second_attr: "key_name"
		  }
	  },
	  { file: ["app","models","item.js"],
	  	findString: "attr2",
	  	replacement: { 
	  		isArray: true, 
	  		first_attr: "columns",
				index: 2,
				second_attr: "key_name"
		  }
	  },
	  { file: ["app","models","item.js"],
	  	findString: "DataType0",
	  	replacement: { 
	  		isArray: true, 
	  		first_attr: "columns",
				index: 0,
				second_attr: "data_type" 
			} 
		},
	  { file: ["app","models","item.js"],
	  	findString: "DataType1",
	  	replacement: { 
	  		isArray: true, 
	  		first_attr: "columns",
				index: 1,
				second_attr: "data_type" 
			} 
		},
	  { file: ["app","models","item.js"],
	  	findString: "DataType2",
	  	replacement: { 
	  		isArray: true, 
	  		first_attr: "columns",
				index: 2,
				second_attr: "data_type" 
			} 
		},
	  { file: ["app","routes.js"],
	  	findString: "attr0",
	  	replacement: { 
	  		isArray: true, 
	  		first_attr: "columns",
				index: 0,
				second_attr: "key_name"
		  }
	  },
	  { file: ["app","routes.js"],
	  	findString: "attr1",
	  	replacement: { 
	  		isArray: true, 
	  		first_attr: "columns",
				index: 1,
				second_attr: "key_name"
		  }
	  },
	  { file: ["app","routes.js"],
	  	findString: "attr2",
	  	replacement: { 
	  		isArray: true, 
	  		first_attr: "columns",
				index: 2,
				second_attr: "key_name"
		  }
	  },
	  { file: ["config","database.js"],
	    findString: "appName",
	    replacement: { 
	    	isArray: false, 
	    	first_attr: "title" 
	    } 
	  },
	  { file: ["public","js","app.js"],
	    findString: "nodeWheels",
	    replacement: { 
	    	isArray: false, 
	    	first_attr: "title" } },
	  { file: ["public","js","controllers.js"],
	    findString: "nodeWheels",
	    replacement: { 
	    	isArray: false, 
	    	first_attr: "title" } },	  
    { file: ["public","js","services.js"],
	    findString: "nodeWheels",
	    replacement: { 
	    	isArray: false, 
	    	first_attr: "title" } },
	  { file: ["public","partials","_form.html"],
	  	findString: "attr0",
	  	replacement: { 
	  		isArray: true, 
	  		first_attr: "columns",
				index: 0,
				second_attr: "key_name"
		  }
	  },
	  { file: ["public","partials","_form.html"],
	  	findString: "attr1",
	  	replacement: { 
	  		isArray: true, 
	  		first_attr: "columns",
				index: 1,
				second_attr: "key_name"
		  }
	  },
	  { file: ["public","partials","_form.html"],
	  	findString: "attr2",
	  	replacement: { 
	  		isArray: true, 
	  		first_attr: "columns",
				index: 2,
				second_attr: "key_name"
		  }
	  },
	  { file: ["public","partials","item-view.html"],
	  	findString: "attr0",
	  	replacement: { 
	  		isArray: true, 
	  		first_attr: "columns",
				index: 0,
				second_attr: "key_name"
		  }
	  },
	  { file: ["public","partials","item-view.html"],
	  	findString: "attr1",
	  	replacement: { 
	  		isArray: true, 
	  		first_attr: "columns",
				index: 1,
				second_attr: "key_name"
		  }
	  },
	  { file: ["public","partials","item-view.html"],
	  	findString: "attr2",
	  	replacement: { 
	  		isArray: true, 
	  		first_attr: "columns",
				index: 2,
				second_attr: "key_name"
		  }
	  },
	  { file: ["public","partials","items.html"],
	  	findString: "attr0",
	  	replacement: { 
	  		isArray: true, 
	  		first_attr: "columns",
				index: 0,
				second_attr: "key_name"
		  }
	  },
	  { file: ["public","partials","items.html"],
	  	findString: "ItemItem",  
	  	replacement: { 
	  		isArray: false, 
	  		first_attr: "model" } 
	  },
    { file: ["public","index.html"],
	    findString: "nodeWheels",
	    replacement: { 
	    	isArray: false, 
	    	first_attr: "title" 
	    } 
  	},
    { file: ["package.json"],
	    findString: "nodeWheels",
	    replacement: { 
	    	isArray: false, 
	    	first_attr: "title" 
	    } 
  	},
	  { file: ["public", "package.json"],
	  	findString: "nodeWheels",
	    replacement: {
	    	isArray: false,
	    	first_attr: "title"
    	}
    }
  ]

	def file_edit(filename, regexp, replacement)
	  Tempfile.open(".#{File.basename(filename)}", File.dirname(filename)) do |tempfile|
	    File.open(filename).each do |line|
	      tempfile.puts line.gsub(regexp, replacement)
	    end
	    tempfile.fdatasync
	    tempfile.close
	    stat = File.stat(filename)
	    FileUtils.chown stat.uid, stat.gid, tempfile.path
	    FileUtils.chmod stat.mode, tempfile.path
	    FileUtils.mv tempfile.path, filename
	  end
	end

	def zipper
	  titleslug = self.slugmaker(:title)
		FileUtils.cd('assets/creations') do
			FileUtils.mkdir titleslug

			FileUtils.cp_r '../raw_material/.', titleslug

      SUBSTITUTIONS.each do |substitution|
      	replacementHash = substitution[:replacement]
      	replacement = replacementHash[:isArray] ? (self.send(replacementHash[:first_attr])[replacementHash[:index]]).send(replacementHash[:second_attr]) : self.send(replacementHash[:first_attr])
				file_edit(File.join(titleslug, substitution[:file]), substitution[:findString], replacement)
			end

      if File.exist? "#{titleslug}.zip"

      	FileUtils.mv "#{titleslug}.zip", "#{titleslug}.zip.bak"
      end

			Zip::Archive.open("#{titleslug}.zip", Zip::CREATE) do |archive|
				archive.add_dir(titleslug)
				Dir.glob("#{titleslug}/**/*").each do |path|
					if File.directory?(path)
						archive.add_dir(path)
					else
						archive.add_file(path, path)
					end
				end
			end

			FileUtils.remove_entry_secure(titleslug)
			FileUtils.remove_entry_secure("#{titleslug}.zip.bak")
		end

		File.join('assets','creations',"#{titleslug}.zip")
	end

end