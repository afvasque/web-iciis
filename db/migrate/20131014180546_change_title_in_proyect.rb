class ChangeTitleInProyect < ActiveRecord::Migration
  def change
  	change_column :projects, :title, :text
  	change_column :projects, :methodology, :text
    change_column :study_sites, :name, :text
    change_column :projects, :summary, :text
    change_column :projects, :publication, :text
    change_column :study_sites, :location, :text
    change_column :researchers, :name, :text
    change_column :researchers, :email, :text
    change_column :researchers, :website, :text
  end
end
