class AddNameAndTypeToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :name, :string, null: false, default: ''
    add_column :users, :role, :string, null: false, default: 'driver'
    add_index :users, :role
  end
end
