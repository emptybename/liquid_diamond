class CreateProducts < ActiveRecord::Migration[5.0]
  def change
    create_table :products do |t|
    	t.string :name
    	t.string :model
    	t.integer :brand_id
    	t.integer :ram
    	t.integer :year
    	t.integer :external_storage
    	t.integer :interna_storage
    	t.integer :price
    	t.references :user, index: true
      t.timestamps
    end
  end
end
