class ChangeColumnsToBlob2 < ActiveRecord::Migration
  def self.up
    change_column :datasets, :department, :binary
    change_column :datasets, :title, :binary
    change_column :datasets, :sector, :binary

  end
  def self.down
    raise ActiveRecord::IrreversibleMigration
  end
end
