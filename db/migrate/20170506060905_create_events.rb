class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :name
      t.string :sponsor
      t.text :description
      t.string :city
      t.string :state_and_country
      t.integer :min_team_size
      t.integer :max_team_size
      t.string :num_kellogg_teams_allowed
      t.text :logistics
      t.text :application
      t.string :application_url
      t.string :contact_name
      t.string :position_and_organization
      t.string :contact_email
      t.string :contact_phone

      t.timestamps null: false
    end
  end
end
