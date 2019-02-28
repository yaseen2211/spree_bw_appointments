module Spree
  module Admin
    class AppointmentsController < ResourceController

		def index
			@appointments = current_spree_vendor.present? && current_spree_vendor.appointments.present? ? current_spree_vendor.appointments.where(start: params[:start]..params[:end]) : []

			respond_to do |format|
				format.html
			    format.json { 
			    	render json: @appointments
			  	}
			end
		end

		def create
			@appointment = Spree::Appointment.new(appointment_params)

			if (current_spree_vendor.present?) && (current_spree_vendor.is_appointable)
				@appointment.vendor = current_spree_vendor 
				@appointment.save

			elsif (current_spree_vendor.present?) && (current_spree_vendor.is_appointable == false)
				raise Exception.new('Permission denied. Can not create appointment due to appointable check false.')
			else
				raise Exception.new('Vendor must be present?')
			end
		end

		def update
			@appointment.update(appointment_params)
		end

		def destroy
    		@appointment.destroy
  		end

		private
		
		def appointment_params
		  params.require(:appointment).permit(:title,:start, :end, :color,:state)
		end
    end
  end
end
