class AddLatestTokenToUsers < ActiveRecord::Migration
  def change
    add_column :users, :latest_token, :string
  end
end
