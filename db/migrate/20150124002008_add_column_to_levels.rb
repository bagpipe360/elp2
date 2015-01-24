class AddColumnToLevels < ActiveRecord::Migration
  def change
    add_column :levels, :rank, :integer
  end
end
