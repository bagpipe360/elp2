class AddColumnToLesson < ActiveRecord::Migration
  def change
    add_column :lessons, :service_id, :integer
  end
end
