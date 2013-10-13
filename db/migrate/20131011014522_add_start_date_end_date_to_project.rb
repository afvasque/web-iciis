class AddStartDateEndDateToProject < ActiveRecord::Migration
  def change
    add_column :projects, :start_date, :date
    add_column :projects, :end_date, :date
    add_column :projects, :methodology, :string
    add_column :projects, :publication, :string
  end
end
