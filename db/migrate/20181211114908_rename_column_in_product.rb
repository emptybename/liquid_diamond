class RenameColumnInProduct < ActiveRecord::Migration[5.0]
  def change
  	rename_column :products, :interna_storage, :internal_storage
  end
end
