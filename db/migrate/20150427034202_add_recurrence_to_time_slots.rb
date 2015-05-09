class AddRecurrenceToTimeSlots < ActiveRecord::Migration
  def change
    add_column :time_slots, :recurrence_pattern, :string
  end
end
