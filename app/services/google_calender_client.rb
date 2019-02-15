class GoogleCalenderClient
  include Singleton

	def client
		existing_token = Current.user.google_client
		@client = nil

		if existing_token.present? 
			c = Signet::OAuth2::Client.new client_options
			c.update!(existing_token)

			if c.issued_at > 1.hour.ago
				response = c.refresh!
				new_token = existing_token.merge(response)
				u = Current.user
				u.google_client = new_token
				u.save!
			end

			@client ||= Google::Apis::CalendarV3::CalendarService.new
			@client.authorization = c
		end

		@client

	end

	def client_options
		{
		  client_id: '714634608490-9r51p0rhv64ivps3aot6ac1bpvbemeic.apps.googleusercontent.com',
		  client_secret: '6u7sDpt_J3pwhVCflrSsTMo6',
		  authorization_uri: 'https://accounts.google.com/o/oauth2/auth',
		  token_credential_uri: 'https://accounts.google.com/o/oauth2/token',
		  scope: ::Google::Apis::CalendarV3::AUTH_CALENDAR,
		  redirect_uri: Spree::Core::Engine.routes.url_helpers.g_callback_url(host:'http://localhost:3000')
		}
	end
end