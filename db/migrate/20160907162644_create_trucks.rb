class CreateTrucks < ActiveRecord::Migration[5.0]
  def change
    create_table :trucks do |t|
      t.string :name
      t.string :location
      t.float :latitude
      t.float :longitude

      t.timestamps
    end
  end
end
