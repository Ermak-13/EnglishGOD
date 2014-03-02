class CreateTranslationsUsers < ActiveRecord::Migration
  def change
    create_table :translations_users, id: false do |t|
      t.integer :translation_id
      t.integer :user_id
    end
  end
end
