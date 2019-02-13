class AddGEventIdToEvents < ActiveRecord::Migration[5.2]
  def change
    add_column :spree_appointments, :g_event_id, :string
  end
end
