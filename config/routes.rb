Spree::Core::Engine.add_routes do
  namespace :admin do
    resources :appointments
  end

  get '/g_redirect', to: 'calender_oauth#redirect', as: 'g_redirect'
  get '/g_callback', to: 'calender_oauth#callback', as: 'g_callback'
end
