class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :login_id
      t.string :password
      t.string :icon_filename
      t.string :name
      t.string :mail_address

      t.timestamps
    end
  end
end
