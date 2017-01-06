class AddGithubAndWebToCrudapp < ActiveRecord::Migration[5.0]
  def change
  	add_column :crudapps, :github, :string
  	add_column :crudapps, :web, :string
  end
end
