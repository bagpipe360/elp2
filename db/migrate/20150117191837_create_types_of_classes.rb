class CreateTypesOfClasses < ActiveRecord::Migration
  def change
    create_table :types_of_classes do |t|
      t.string :type
      t.string :description

      t.timestamps
    end
  end
end
