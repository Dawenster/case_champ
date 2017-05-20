class AddDetailsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :program, :string
    add_column :users, :majors, :string
    add_column :users, :image_url, :string
    add_column :users, :class_year, :integer
  end
end
