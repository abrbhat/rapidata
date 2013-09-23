class ChangeTitleToString < ActiveRecord::Migration
  def up
    change_column :datasets, :title, :string
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
