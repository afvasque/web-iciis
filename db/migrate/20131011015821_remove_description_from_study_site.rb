class RemoveDescriptionFromStudySite < ActiveRecord::Migration
  def change
    remove_column :study_sites, :description, :string
  end
end
