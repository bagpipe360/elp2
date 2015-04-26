class ChangeTypesForPostGres < ActiveRecord::Migration
  def  change
    change_column :lessons, :session_id, :text
    change_column :lessons, :token, :text
  end
end
