class AddAttributeNameToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :name, :string
    add_column :users, :temporary_password, :string
  end
end
