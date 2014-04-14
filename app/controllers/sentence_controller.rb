class SentenceController < ApplicationController

	def index
		@language = Language.where(code: params[:language_code]).take
		@skill = Skill.where(code: params[:skill_code], language_id: @language.id).take
		@lesson = Lesson.where(code: params[:lesson_code], skill_id: @skill.id).take
		@sentences = @lesson.sentences
	end

	def new
	end

	def create
		@language = Language.where(code: params[:language_code]).take
		@skill = Skill.where(code: params[:skill_code], language_id: @language.id).take
		@lesson = Lesson.where(code: params[:lesson_code], skill_id: @skill.id).take

		@sentence = Sentence.new(sentence_params)
		@sentence.lesson = @lesson
		@sentence.save

		redirect_to :sentence_index
	end

	def references
		@sentence = Sentence.find(params[:sentence_id])
		@lesson = @sentence.lesson
		@sentences = @lesson.sentences
		@skill = @lesson.skill
		@language = @skill.language
	end

	def save_references
		selected_ids = params[:relation].find_all { |a, b| b == "1" && a =~ /^check_/ }.collect { |e| e[0] }.collect { |e| e.split(/_/)[1].to_i }
		selected = Sentence.find(selected_ids)

		@sentence = Sentence.find(params[:sentence_id])
		@sentence.references = selected
		@sentence.save

		@lesson = @sentence.lesson
		@sentences = @lesson.sentences
		@skill = @lesson.skill
		@language = @skill.language
		redirect_to sentence_index_path(@language.code, @skill.code, @lesson.code)
	end

private

	def sentence_params
		params.require(:sentence).permit(:text, :default_translation)
	end
end
