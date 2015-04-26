class AddRateToLessons < ActiveRecord::Migration
  def change
    add_column :lessons, :rate, :float
    create_table :lesson_problems do |t|
      t.text :problem
      t.integer :lesson_id
      t.timestamps
    end

  end
end
