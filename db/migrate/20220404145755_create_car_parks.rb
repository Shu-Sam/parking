class CreateCarParks < ActiveRecord::Migration[7.0]
  def change
    create_table :car_parks do |t|
      t.belongs_to :user, null: false, foreign_key: true
      t.string :title, null: false, unique: true
      t.string :address, null: false
      t.integer :parking_type, null: false, default: 0
      t.decimal :usage_fee, null: false
      t.integer :discount, null: false
      t.integer :spaces, null: false

      t.timestamps
    end
  end
end
