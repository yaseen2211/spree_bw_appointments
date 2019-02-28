class CreateSpreeUserAppointments < ActiveRecord::Migration[5.2]
  def change
    create_table :spree_user_appointments do |t|
      t.integer :user_id
      t.integer :appointment_id
      t.timestamps
    end
  end
end
