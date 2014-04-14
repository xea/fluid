class Lesson < ActiveRecord::Base

	belongs_to :skill

	has_many :sentences
end
