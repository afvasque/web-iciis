class AddDescriptionToProject < ActiveRecord::Migration
  def change
    add_column :projects, :summary, :string
  end
end
