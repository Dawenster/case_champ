class CreatePrizes < ActiveRecord::Migration
  def change
    create_table :prizes do |t|
      t.integer :rank
      t.integer :amount_in_dollars
      t.string :description
      t.integer :event_id

      t.timestamps null: false
    end
  end
end
