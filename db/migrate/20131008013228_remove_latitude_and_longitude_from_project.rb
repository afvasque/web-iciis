class RemoveLatitudeAndLongitudeFromProject < ActiveRecord::Migration
  def change
    remove_column :projects, :latitude
    remove_column :projects, :longitude
  end
end
