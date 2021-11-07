class CreateTasks < ActiveRecord::Migration[6.1]
  def change
    enable_extension 'pgcrypto'

    drop_table :tasks

    create_table :tasks do |t|
      t.uuid :public_id, default: "gen_random_uuid()", null: false

      ## Tasks information
      t.string   :description
      t.string   :status

      t.timestamps null: false
    end
  end
end
