class ChangeColumnsToBlob < ActiveRecord::Migration
  def up
    remove_column :datasets, :description
    remove_column :datasets, :link
    add_column :datasets, :description, :binary, :limit => 50.kilobyte
    add_column :datasets, :link, :binary, :limit => 50.kilobyte
  end

  def down
    remove_column :datasets, :description
    remove_column :datasets, :link
  end
end
