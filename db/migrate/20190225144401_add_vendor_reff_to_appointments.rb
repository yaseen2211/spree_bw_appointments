class AddVendorReffToAppointments < ActiveRecord::Migration[5.2]
  def change
  	add_reference :spree_appointments, :vendor, index: true
  end
end
