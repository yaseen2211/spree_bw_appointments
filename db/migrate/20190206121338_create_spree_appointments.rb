class CreateSpreeAppointments < ActiveRecord::Migration[5.2]
  def up
    create_table :spree_appointments do |t|
      t.string :status
      t.datetime :start
      t.datetime :end
      t.string :color
      t.string :title
      t.timestamps
    end
  end

  def down
    drop_table :spree_appointments
  end
end
