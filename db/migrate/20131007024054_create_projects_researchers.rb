class CreateProjectsResearchers < ActiveRecord::Migration
  def change
    create_table :projects_researchers, :id => false do |t|
        t.references :project
        t.references :researcher
    end
  end
end
