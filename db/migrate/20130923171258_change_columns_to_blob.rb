class ChangeColumnsToBlob < ActiveRecord::Migration
  def self.up
    change_column :datasets, :description, :binary
    change_column :datasets, :link, :binary

  end
  def self.down
    raise ActiveRecord::IrreversibleMigration
  end
end
