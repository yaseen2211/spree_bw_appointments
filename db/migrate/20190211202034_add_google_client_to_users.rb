class AddGoogleClientToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :spree_users, :google_client, :jsonb
  end
end
