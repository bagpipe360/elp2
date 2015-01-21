class CreateRememberedIps < ActiveRecord::Migration
  def change
    create_table :remembered_ips do |t|
      t.string :ip_address
      t.date :date_accessed
      t.boolean :blocked

      t.timestamps
    end
  end
end
