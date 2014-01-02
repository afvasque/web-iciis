class AddResearchFieldToProject < ActiveRecord::Migration
  def change
    add_column :projects, :research_field, :string
  end
end
