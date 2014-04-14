class CreateLessons < ActiveRecord::Migration
	def change
		create_table :lessons do |t|

			t.string :name

			t.references :skill

			t.timestamps
		end
	end
end
