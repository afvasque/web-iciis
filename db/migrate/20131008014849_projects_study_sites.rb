class ProjectsStudySites < ActiveRecord::Migration
  def change
  	create_table :projects_study_sites, :id => false do |t|
        t.references :project
        t.references :study_site
    end
  end
end
