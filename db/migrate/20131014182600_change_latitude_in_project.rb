class ChangeLatitudeInProject < ActiveRecord::Migration
  def change
  	    change_column :study_sites, :latitude, :real
  	    change_column :study_sites, :longitude, :real
  end
end
