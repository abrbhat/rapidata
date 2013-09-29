class AddLinkToDownloadColumn < ActiveRecord::Migration
  def up
    add_column :datasets, :link_to_download, :binary, :limit => 50.kilobyte
  end

  def down
    remove_column :datasets, :link_to_download
  end
end
