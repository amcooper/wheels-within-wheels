class CreateColumns < ActiveRecord::Migration[5.0]
  def change
  	create_table :columns do |t|
  		t.string :key_name
  		t.string :data_type
  		t.integer :crudapp_id
  	end
  end
end
