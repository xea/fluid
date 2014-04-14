require "pry"

class SkillController < ApplicationController

	def index
		@language = Language.where(code: params[:language_code]).first

		@skills = @language.skills
	end

	def new
	end

	def create
		@language = Language.where(code: params[:language_code]).first
		@skill = Skill.new(skill_params)
		@skill.language = @language
		@skill.save

		redirect_to :skill_index
	end

private

	def skill_params
		params.require(:skill).permit(:name, :code)
	end
end
