module Spree
	class UserAppointment < Spree::Base
	  belongs_to :user
	  belongs_to :appointment
	end
end