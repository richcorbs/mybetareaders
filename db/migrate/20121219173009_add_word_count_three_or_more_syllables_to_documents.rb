class AddWordCountThreeOrMoreSyllablesToDocuments < ActiveRecord::Migration
  def change
    add_column :documents, :word_count_three_or_more_syllables, :integer
  end
end
