class CreateTranslations < ActiveRecord::Migration
	def change
		create_table :translations do |t|
			t.text :text, null: false
			t.boolean :good, null: false, default: false
			t.text :invalid_reason
			t.integer :points

			t.references :sentence
			t.timestamps
		end
	end
end
