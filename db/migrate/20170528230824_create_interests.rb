class CreateInterests < ActiveRecord::Migration
  def change
    create_table :interests do |t|
      t.integer :event_id
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
