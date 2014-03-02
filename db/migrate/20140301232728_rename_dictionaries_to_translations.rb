class RenameDictionariesToTranslations < ActiveRecord::Migration
  def change
    rename_table :dictionaries, :translations

    rename_column :translations, :word, :text
    rename_column :translations, :translation, :value
  end
end
