class AddSentenceSyllableWordCountsToDocuments < ActiveRecord::Migration
  def change
    add_column :documents, :sentence_count, :integer
    add_column :documents, :syllable_count, :integer
    add_column :documents, :word_count, :integer
  end
end
