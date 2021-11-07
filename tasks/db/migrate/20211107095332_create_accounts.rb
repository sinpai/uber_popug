class CreateAccounts < ActiveRecord::Migration[6.1]
  def change
    enable_extension 'pgcrypto'

    drop_table :accounts
    
    create_table :accounts do |t|
      ## Database authenticatable
      t.string :email,              null: false, default: ""

      t.uuid :public_id, default: "gen_random_uuid()", null: false

      ## Account information
      t.string   :full_name
      t.string   :position

      t.timestamps null: false
      t.datetime :disabled_at
    end

    add_index :accounts, :email,                unique: true
  end
end
