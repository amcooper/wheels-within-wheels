class CreateCrudapps < ActiveRecord::Migration[5.0]
  def change
  	create_table :crudapps do |t|
  		t.string :title
  		t.integer :user_id
  	end
  end
end
