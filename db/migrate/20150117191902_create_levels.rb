class CreateLevels < ActiveRecord::Migration
  def change
    create_table :levels do |t|
      t.string :level
      t.string :description

      t.timestamps
    end
  end
end
