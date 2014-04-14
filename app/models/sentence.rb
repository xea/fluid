class Sentence < ActiveRecord::Base

	belongs_to :lesson
	has_many :translations
	has_and_belongs_to_many :references, class_name: "Sentence", join_table: :sentence_references, association_foreign_key: "reference_id"

	def matches(input)
		stripped_input = input.to_s.preprocess

		accepted_translations.find_all { |t| t.preprocess == stripped_input }.length > 0
	end

	def accepted_translations
		(translations.collect { |t| t.text.preprocess } << default_translation)
	end

	def rate_forward(user_input)
		if matches user_input
			return 10
		else
			return 0
		end
	end

	def rate_reverse(user_input)
		reverses = references.collect { |r| r.text } << text
		stripped_input = user_input.preprocess

		if reverses.find_all { |t| t.preprocess == stripped_input }.length > 0
			return 10
		else
			return 0
		end
	end

end

class String
	
	def preprocess
		mb_chars.downcase.strip.tr("-.:,!", "").gsub(/\s+/, " ").to_s
	end
end
