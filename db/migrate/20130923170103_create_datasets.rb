class CreateDatasets < ActiveRecord::Migration
  def change
    create_table :datasets do |t|
      t.string :title
      t.binary :description
      t.binary :department
      t.binary :sector
      t.binary :link

      t.timestamps
    end
  end
end
