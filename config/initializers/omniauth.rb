Rails.application.config.middleware.use OmniAuth::Builder do
	#provider :facebook, ENV['FACEBOOK_KEY'], ENV['FACEBOOK_SECRET']
	provider :facebook, "453094124822586", "01a65e81ac11bdd27555dfccaf130300"
end
