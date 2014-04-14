class LearnController < ApplicationController

	QUESTION_TYPES = [ :forward_translation, :reverse_translation ]

	def learn
		fetch_headers
	end

	def evaluate
		type = params[:type].to_sym
		user_input = params[:value]
		sentence = Sentence.find(params[:sentence_id])

		if type == :forward_translation
			score = sentence.rate_forward user_input
		elsif type == :reverse_translation
			score = sentence.rate_reverse user_input
		end

		render :json => { score: score, accepted_translations: sentence.accepted_translations }
	end

	def next
		fetch_next
		render json: @next
	end

	def fetch_headers
		@language = Language.where(code: params[:language_code]).take
		@skill = Skill.where(code: params[:skill_code], language_id: @language.id).take
		@lesson = Lesson.where(code: params[:lesson_code], skill_id: @skill.id).take

		@sentences = @lesson.sentences
	end

	def fetch_next
		fetch_headers

		type = QUESTION_TYPES[(Random.rand QUESTION_TYPES.length)]
		sentence = @sentences[(Random.rand @sentences.length)] 

		@next = { type: type, sentence: sentence }

		case type
		when :forward_translation
			available_sentences = sentence.references.collect { |r| r.text} << sentence.text
			@next[:display_sentence] = available_sentences[(Random.rand available_sentences.length)]
		when :reverse_translation
			@next[:display_sentence] = sentence.accepted_translations[(Random.rand sentence.accepted_translations.length)]
		end

	end
end
