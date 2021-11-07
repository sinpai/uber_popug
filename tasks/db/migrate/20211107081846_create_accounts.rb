class CreateAccounts < ActiveRecord::Migration
  def change
    enable_extension 'pgcrypto'

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
