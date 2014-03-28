class CreateKnowledges < ActiveRecord::Migration
  def change
    create_table :knowledges do |t|
      t.integer :translation_id
      t.integer :user_id

      t.integer :rating
      t.integer :level

      t.timestamps
    end
  end
end
