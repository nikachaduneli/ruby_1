class AddEmailToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :email, :text
  end
end
