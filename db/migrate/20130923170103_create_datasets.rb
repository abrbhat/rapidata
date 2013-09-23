class CreateDatasets < ActiveRecord::Migration
  def change
    create_table :datasets do |t|
      t.string :title
      t.string :description
      t.string :department
      t.string :sector
      t.string :link

      t.timestamps
    end
  end
end
