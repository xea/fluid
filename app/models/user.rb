require "digest"

# A user account 
class User < ActiveRecord::Base

	has_and_belongs_to_many :roles

	validates :email, uniqueness: true
	validates :email, confirmation: true
	validates :password, confirmation: true
	validates :password, presence: true

	# Attempts to create or update a User object based from the external (eg. facebook)
	# provider
	def self.from_omniauth(auth)
		user_count = User.count
		where(auth.slice(:provider, :uid)).first_or_initialize.tap do |user|
			user.provider = auth.provider
			user.uid = auth.uid
			user.name = auth.info.name
			user.oauth_token = auth.credentials.token
			user.oauth_expires_at = Time.at(auth.credentials.expires_at)

			if (user_count == 0)
				role = Role.new
				role.name = "global_admin"
				role.description = "Global Administrator"
				role.save
				user.roles << role
			end
			user.save!
		end
	end

	# Verifies if this user has any roles with the name of role_name
	def has_role?(role_name)
		roles.find_all { |r| r.matches? role_name }.any? or id == 1
	end

	# Returns a hash based on the given input which can be used to verify
	# user logins or other permission related actions
	def self.hash_password(input)
		Digest::SHA2.hexdigest input.to_s
	end
end
