class CreateSentences < ActiveRecord::Migration
	def change
		create_table :sentences do |t|
			t.text :text
			t.text :default_translation

			t.references :lesson

			t.timestamps
		end

		create_table :sentence_references do |t|
			t.integer :sentence_id
			t.integer :reference_id
			t.timestamps
		end
	end
end
