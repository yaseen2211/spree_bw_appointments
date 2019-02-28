module Spree
  class Appointment < Spree::Base
    attr_accessor :date_range

    enum state: [:created,:booked,:confirmed,:active,:complete]

  	validates :title, presence: true
    # after_save :sync_with_google_calender
    belongs_to :vendor
    has_many :user_appointments, class_name: 'Spree::UserAppointment'
    has_many :users, through: :user_appointments, class_name: 'Spree::User'

    state_machine :state, :initial => :created do

      # POSSIBLE_STATES = Spree::Appointment.states.keys.map{|s|s.to_sym}

      event :set_created do
        transition :created => :created
      end

      event :set_booked do
        transition :created => :booked
      end

      event :set_confirmed do
        transition :booked => :confirmed
      end

      event :set_active do
        transition :confirmed => :active
      end

      event :set_completed do
        transition :active => :completed
      end

      
    end

  	def all_day_event?
    	self.start == self.start.midnight && self.end == self.end.midnight ? true : false
  	end

  	def as_json(options={})
  		date_format = all_day_event? ? '%Y-%m-%d' : '%Y-%m-%dT%H:%M:%S'

  		{
  			id: id,
  			title: title,
  			start: self.start.strftime(date_format),
  			end: self.end.strftime(date_format),
  			allDay: all_day_event?,
  			update_url: Spree::Core::Engine.routes.url_helpers.admin_appointment_path(self),
  			edit_url: Spree::Core::Engine.routes.url_helpers.edit_admin_appointment_path(self)
  		}
  	end

    def sync_with_google_calender
      if saved_change_to_start? || saved_change_to_end?
        event = Google::Apis::CalendarV3::Event.new({
          start: Google::Apis::CalendarV3::EventDateTime.new(date_time: self.start.strftime('%FT%T'), time_zone: "Asia/Karachi"),
          end: Google::Apis::CalendarV3::EventDateTime.new(date_time: self.end.strftime('%FT%T'), time_zone: "Asia/Karachi"),
          summary: self.title
        })

        if self.g_event_id.blank?
          ev = GoogleCalenderClient.instance.client.insert_event('omsolutionpk@gmail.com', event)
          self.g_event_id = ev.id
          self.save!
        else
          GoogleCalenderClient.instance.client.update_event('omsolutionpk@gmail.com',g_event_id, event)
        end
      end
      
    end

  end
end
