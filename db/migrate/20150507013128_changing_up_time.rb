class ChangingUpTime < ActiveRecord::Migration
  def change
	create_table :temp_time_slot_alterations do |t|
      t.datetime :scheduled_start
      t.datetime :scheduled_end
      t.integer :user_id

      t.timestamps
    end 
    
    change_column :time_slots, :start_time, :time
    change_column :time_slots, :end_time, :time
  end
end