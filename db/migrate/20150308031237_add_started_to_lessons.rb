class AddStartedToLessons < ActiveRecord::Migration
  def change
    add_column :lessons, :started, :boolean
  end
end
