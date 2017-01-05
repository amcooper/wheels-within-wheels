class AddDescriptionAndModelToCrudapp < ActiveRecord::Migration[5.0]
  def change
  	add_column :crudapps, :description, :string
  	add_column :crudapps, :model, :string
  end
end
