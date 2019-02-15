module Spree
  module Admin
    class AppointmentsController < ResourceController

		def index
			@appointments = Spree::Appointment.where(start: params[:start]..params[:end])

			respond_to do |format|
				format.html
			    format.json { 
			    	render json: @appointments
			  	}
			end
		end

		def create
			@appointment = Spree::Appointment.new(appointment_params)
			@appointment.save
		end

		def update
			@appointment.update(appointment_params)
		end

		def destroy
    		@appointment.destroy
  		end

		private
		
		def appointment_params
		  params.require(:appointment).permit(:title, :date_range, :start, :end, :color)
		end
    end
  end
end
