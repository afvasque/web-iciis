class AddResearcherIdToProject < ActiveRecord::Migration
  def change
    add_column :projects, :researcher_id, :integer
  end
end
