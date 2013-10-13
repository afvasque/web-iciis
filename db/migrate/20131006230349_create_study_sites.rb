class CreateStudySites < ActiveRecord::Migration
  def change
    create_table :study_sites do |t|
      t.date :start_date
      t.date :end_date
      t.string :data_collection_method
      t.string :name
      t.string :description
      t.float :latitude
      t.float :longitude
      t.string :location

      t.timestamps
    end
  end
end
