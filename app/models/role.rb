# Grants access to specific actions 
class Role < ActiveRecord::Base

	has_and_belongs_to_many :users

	# Verifies if the provided role_name equals to the name of this role
	def matches?(role_name)
		name.to_sym == role_name.to_sym
	end

end
