class CreateDictionaries < ActiveRecord::Migration
  def change
    create_table :dictionaries do |t|
        t.integer :user_id
    end

    add_column :knowledges, :dictionary_id, :integer
  end
end
