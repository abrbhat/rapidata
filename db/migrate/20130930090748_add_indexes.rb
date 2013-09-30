class AddIndexes < ActiveRecord::Migration
  def self.up
    add_index :terms, :term
    add_index :term_items, :dataset_id
    add_index :term_items, :term_id

  end

  def self.down
    remove_index :terms, :term
    remove_index :term_items, :dataset_id
    remove_index :term_items, :term_id
  end
end