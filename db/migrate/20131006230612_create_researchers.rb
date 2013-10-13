class CreateResearchers < ActiveRecord::Migration
  def change
    create_table :researchers do |t|
      t.string :name
      t.string :email
      t.string :website

      t.timestamps
    end
  end
end
