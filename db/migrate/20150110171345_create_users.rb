class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.string :role
      t.date :created_at
      t.string :description
      t.binary :profile_picture
      t.boolean :verified_terms_and_service

      t.timestamps
    end
  end
end
