class LessonController < ApplicationController

	def index
		@language = Language.where(code: params[:language_code]).take
		@skill = Skill.where(code: params[:skill_code], language_id: @language.id).take
		@lessons = @skill.lessons
	end

	def new
	end

	def create
		@language = Language.where(code: params[:language_code]).take
		@skill = Skill.where(code: params[:skill_code], language_id: @language.id).take
		@lessons = @skill.lessons

		@lesson = Lesson.new(lesson_params)
		@lesson.skill = @skill
		@lesson.save

		redirect_to :lesson_index
	end

private

	def lesson_params
		params.require(:lesson).permit(:name, :code)
	end
end
