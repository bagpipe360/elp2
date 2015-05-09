class ChangeStatuses < ActiveRecord::Migration
  def change
  	remove_column :lessons, :cancelled
  	add_column :lessons, :status, :string, default: 'scheduled'
  end
end
