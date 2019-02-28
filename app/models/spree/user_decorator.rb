Spree::User.class_eval do
	has_many :user_appointments, class_name: 'Spree::UserAppointment'
  has_many :appointments, through: :user_appointments, class_name: 'Spree::Appointment'
end
