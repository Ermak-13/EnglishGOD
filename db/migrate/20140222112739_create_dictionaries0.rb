class CreateDictionaries0 < ActiveRecord::Migration
  def change
    create_table :dictionaries do |t|
      t.string :word
      t.text :translation
      t.timestamps
    end
  end
end
