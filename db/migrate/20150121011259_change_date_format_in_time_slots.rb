class ChangeDateFormatInTimeSlots < ActiveRecord::Migration
  def change
    change_column :time_slots, :start_time, :datetime
    change_column :time_slots, :end_time, :datetime
  end
end
