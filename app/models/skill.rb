class Skill < ActiveRecord::Base

	belongs_to :language
	has_many :lessons
end
