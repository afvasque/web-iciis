class AddGmapsToStudySite < ActiveRecord::Migration
  def change
    add_column :study_sites, :gmaps, :boolean
  end
end
