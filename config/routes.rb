Fluid::Application.routes.draw do
	root "dashboard#index"

	get "dashboard/index", as: :dashboard_index
	get "widget/index"

	get "admin" => "admin#index", as: :admin_index
	get "api/language" => "admin#list_languages", as: :list_languages
	post "api/language" => "admin#create_language", as: :create_language, defaults: { format: :json }
	get "api/language/:language_id" => "admin#get_language", as: :get_language

	get "api/language/:language_id/skills" => "admin#list_skills", as: :list_skills
	post "api/skill" => "admin#create_skill", as: :create_skill

	get "api/skill/:skill_id/lessons" => "admin#list_lessons", as: :list_lessons
	post "api/lesson" => "admin#create_lesson", as: :create_lesson

	get "api/lesson/:lesson_id/sentences" => "admin#list_sentences", as: :list_sentences
	post "api/sentence" => "admin#create_sentence", as: :create_sentence

	get "api/sentence/:sentence_id/translations" => "admin#list_translations", as: :list_translations
	post "api/translation" => "admin#create_translation", as: :create_translation
	post "api/translation/:translation_id" => "admin#update_translation", as: :update_translation

	get "user/login" => "user#login", as: :user_login
	post "user/login" => "user#authenticate", as: :user_auth

	get "user/register" => "user#register", as: :user_register_path
	post "user/register" => "user#submit_registration"

	get "play" => "play#index"

	get "practice" => "practice#index"

#	get		"auth/:provider/callback" => "sessions#create"
#	post	"auth/:provider/callback" => "sessions#create"

	match 'auth/:provider/callback', to: 'sessions#create', via: [:get, :post]
	match 'auth/failure', to: redirect('/'), via: [:get, :post]
	match 'signout', to: 'sessions#destroy', as: 'signout', via: [:get, :post]

#	get		"auth/failure" => "sessions#destroy"
#	post	"auth/failure" => "sessions#destroy"

#	get		"signout" => "sessions#destroy", as: :signout
#	post	"signout" => "sessions#destroy" 

#	get		"user/register" => "user#register", as: :user_register
#	post	"user/register" => "user#create_user", as: :user_create

	get "language/index", as: :language_index
	get "language/new" => "language#new", as: :language_new
	post "language/new" => "language#create", as: :language_create

#	get		"skill/:language_code" => "skill#index", as: :skill_index
#	get		"skill/:language_code/new" => "skill#new", as: :skill_new
#	post	"skill/:language_code/new" => "skill#create", as: :skill_create

#	get		"lesson/:language_code/:skill_code" => "lesson#index", as: :lesson_index
#	get		"lesson/:language_code/:skill_code/new" => "lesson#new", as: :lesson_new
#	post	"lesson/:language_code/:skill_code/new" => "lesson#create", as: :lesson_create

#	get		"sentence/:language_code/:skill_code/:lesson_code" => "sentence#index", as: :sentence_index
#	get		"sentence/:language_code/:skill_code/:lesson_code/new" => "sentence#new", as: :sentence_new
#	post	"sentence/:language_code/:skill_code/:lesson_code/new" => "sentence#create", as: :sentence_create

#	get		"reference/:sentence_id" => "sentence#references", as: :sentence_reference_index
#	post	"reference/:sentence_id" => "sentence#save_references", as: :sentence_reference_update

#	get		"translation/:sentence_id" => "translation#index", as: :translation_index
#	get		"translation/:sentence_id/new" => "translation#new", as: :translation_new
#	post	"translation/:sentence_id/new" => "translation#create", as: :translation_create

#	get		"learn/:language_code/:skill_code/:lesson_code" => "learn#learn", as: :learn_lesson
#	post	"learn/:language_code/:skill_code/:lesson_code" => "learn#evaluate", as: :learn_eval
#	get		"learn/:language_code/:skill_code/:lesson_code/next" => "learn#next", as: :learn_next


  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
