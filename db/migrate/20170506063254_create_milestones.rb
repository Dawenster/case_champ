class CreateMilestones < ActiveRecord::Migration
  def change
    create_table :milestones do |t|
      t.datetime :deadline_at
      t.string :description
      t.integer :event_id

      t.timestamps null: false
    end
  end
end
