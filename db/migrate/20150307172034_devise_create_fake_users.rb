class DeviseCreateFakeUsers < ActiveRecord::Migration
  def change
    add_index :identities, :email,                unique: true
    add_index :identities, :reset_password_token, unique: true
    add_index :identities, :confirmation_token,   unique: true
    add_index :identities, :unlock_token,         unique: true
  end
end
