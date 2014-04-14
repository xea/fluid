# This controller is responsible for the administration tasks, such as adding
# new users, languages or maintaining them. 
#
# All these actions require the user to hold administrative privileges.
#
class AdminController < ApplicationController

	before_action :require_admin_privileges

	# Displays the main administrative page
	def index
		@languages = Language.all
		@users = User.all
	end

	# Returns a JSON object containing every language
	def list_languages
		render json: Language.all.to_json
	end

	# Returns a JSON boject containing a specified language
	def get_language
		render json: Language.find(params[:language_id]).to_json
	end

	def create_language
		language = Language.new(language_params)

		if language.valid?
			language.save
			@languages = Language.all
			render json: { status: :ok }
		else
			redirect_to admin_index_path
		end
	end

	# Returns an array of skills that belong to a specified language
	def list_skills
		render json: Skill.where(language_id: params[:language_id]).to_json
	end

	def create_skill
		skill = Skill.new(skill_params)

		if skill.valid?
			skill.save
			render json: { status: :ok }
		else
			render json: { status: :error }
		end
	end

	def list_lessons
		render json: Lesson.where(skill_id: params[:skill_id]).to_json
	end

	def create_lesson
		lesson = Lesson.new(lesson_params)
		
		if lesson.valid?
			lesson.save
			render json: { status: :ok }
		else
			render json: { status: :error }
		end
	end

	def list_sentences
		render json: Sentence.where(lesson_id: params[:lesson_id]).to_json
	end

	def create_sentence
		sentence = Sentence.new(sentence_params)

		if sentence.valid?
			sentence.save
			render json: { status: :ok }
		else
			render json: { status: :error }
		end
	end

	def list_translations
		render json: Translation.where(sentence_id: params[:sentence_id]).to_json
	end

	def create_translation
		translation = Translation.new(translation_params)

		if translation.valid?
			translation.save
			render json: { status: :ok }
		else
			render json: { status: :error }
		end
	end

	def update_translation
		translation = Translation.find(params[:translation][:id])

		translation.text = params[:translation][:text]
		translation.save

		render json: { status: :ok }
	end

	def list_references
		render json: Sentence.where(params[:sentence_id]).first.references.to_json
	end

	def update_references
		render json: { status: :ok }
	end

private

	def language_params
		params.require(:language).permit(:name)
	end

	def skill_params
		params.require(:skill).permit(:language_id, :name)
	end

	def lesson_params
		params.require(:lesson).permit(:skill_id, :name)
	end

	def sentence_params
		params.require(:sentence).permit(:lesson_id, :text, :default_translation)
	end

	def translation_params
		params.require(:translation).permit(:sentence_id, :text)
	end

	# Checks if the user has roles that enable him/her to access administrative
	# functions
	def require_admin_privileges
		redirect_to root_path unless is_global_admin?
	end

	# Checks if the current user is a global administrator
	def is_global_admin?
		current_user.has_role? :global_admin unless current_user.nil?
	end

end
