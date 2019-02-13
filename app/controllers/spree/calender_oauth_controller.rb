class Spree::CalenderOauthController < ApplicationController
	def redirect
	    client = ::Signet::OAuth2::Client.new(client_options)
	    redirect_to client.authorization_uri.to_s
  	end

  	def callback
	    client = Signet::OAuth2::Client.new(client_options)
	    client.code = params[:code]

	    response = client.fetch_access_token!
	    spree_current_user.google_client = response
	    spree_current_user.save!(:validate => false)
	    redirect_to admin_appointments_url
  	end

	private

	def client_options
		::GoogleCalenderClient.instance.client_options
	end
end
