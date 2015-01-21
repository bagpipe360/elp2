class CreateLanguages < ActiveRecord::Migration
  def change
    create_table :languages do |t|
      t.string :language
      t.string :location

      t.timestamps
    end
  end
end
