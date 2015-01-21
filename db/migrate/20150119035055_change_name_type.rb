class ChangeNameType < ActiveRecord::Migration

  def change
    rename_column :types_of_classes, :type, :type_of_class

  end
end
