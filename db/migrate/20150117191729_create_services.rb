class CreateServices < ActiveRecord::Migration
  def change
    create_table :services do |t|
      t.integer :types_of_class_id
      t.integer :level_id
      t.integer :language_id

      t.timestamps
    end
  end
end
