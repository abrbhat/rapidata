class RemovePriorityFromTermItemsAndRemoveSectorFromDatasets < ActiveRecord::Migration
  def up
    remove_column :datasets, :sector
    remove_column :term_items, :priority
  end

  def down
    add_column :datasets, :sector
    add_column :term_items, :priority
  end
end
