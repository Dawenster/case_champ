class CreateEventFiles < ActiveRecord::Migration
  def change
    create_table :event_files do |t|
      t.string :original_filename
      t.string :public_id
      t.string :resource_type
      t.string :secure_url
      t.integer :event_id
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
