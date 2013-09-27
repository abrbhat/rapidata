class CreateTermItems < ActiveRecord::Migration
  def change
    create_table :term_items do |t|
      t.integer :dataset_id
      t.integer :term_id
      t.integer :priority

      t.timestamps
    end
  end
end
