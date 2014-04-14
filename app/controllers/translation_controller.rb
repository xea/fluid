class TranslationController < ApplicationController


	def index
		@sentence = Sentence.find(params[:sentence_id])
		@translations = @sentence.translations
	end

	def new
	end

	def create
		@sentence = Sentence.find(params[:sentence_id])
		@translation = Translation.new(translation_params)

		@translation.sentence = @sentence
		@translation.save

		redirect_to :translation_index
	end

private

	def translation_params
		params.require(:translation).permit(:text)
	end

end
