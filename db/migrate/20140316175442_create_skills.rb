class CreateSkills < ActiveRecord::Migration
	def change
		create_table :skills do |t|

			t.string :name
			t.text :description

			t.references :language

			t.timestamps
		end
	end
end
