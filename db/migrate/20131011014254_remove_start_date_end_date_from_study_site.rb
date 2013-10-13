class RemoveStartDateEndDateFromStudySite < ActiveRecord::Migration
  def change
    remove_column :study_sites, :start_date
    remove_column :study_sites, :end_date
    remove_column :study_sites, :data_collection_method
  end
end
