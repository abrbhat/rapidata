class AddColumnToTermItem < ActiveRecord::Migration
  def change
    add_column :term_items, :priority, :integer
  end
end
