# Written by Elisabeth Hendrickson, Quality Tree Software, Inc.
# Copyright (c) 2009 Quality Tree Software, Inc.
#
# This work is licensed under the 
# Creative Commons Attribution 3.0 United States License.
#
# To view a copy of this license, visit 
#      http://creativecommons.org/licenses/by/3.0/us/

class String

  def flesch_ease_scale
    206.835 - self.word_count.to_f / self.sentence_count.to_f * 1.015 - self.syllable_count.to_f / self.word_count.to_f * 84.6
  end

  def flesch_kincaid_grade_scale
    0.39 * self.word_count.to_f / self.sentence_count.to_f + 11.8 * self.syllable_count.to_f / self.word_count.to_f - 15.59
  end

  def fog_scale
    0.4 * ( (self.word_count.to_f / self.sentence_count.to_f) + 100.0 * (self.word_count_three_or_more_syllables.to_f / self.word_count.to_f) )
  end

  def sentence_count
    sentence_count = self.split(/\. |\? |! /).compact.size
  end

  def syllable_count
    consonants = "bcdfghjklmnpqrstvwxz"
    vowels = "aeiouy"
    processed = self.downcase
    suffix_bonus = 0
    #puts "*** 0 #{processed}"
    if processed.match(/ly$/)
      suffix_bonus = 1
      processed.gsub!(/ly$/, "")
    end
    if processed.match(/[a-z]ed$/)
      # Not counting "ed" as an extra symbol. 
      # So 'blessed' is assumed to be said as 'blest'
      suffix_bonus = 0 
      processed.gsub!(/ed$/, "")
    end
    #puts "*** 1 #{processed}"
    processed.gsub!(/iou|eau|ai|au|ay|ea|ee|ei|oa|oi|oo|ou|ui|oy/, "@") #vowel combos
    #puts "*** 2 #{processed}"
    processed.gsub!(/qu|ng|rt|[bcdfghjklmnpqrstvwxz]h/, "=") #consonant combos
    #puts "*** 3 #{processed}"
    processed.gsub!(/[aeiouy][bcdfghjklmnpqrstvwxz]e/, "@==") # remove silent e
    #puts "*** 4 #{processed}"
    processed.gsub!(/[aeiouy]/, "@") #all remaining vowels will be counted
    #puts "*** 5 #{processed}"
    return processed.count("@") + suffix_bonus
    #words = self.split
    #count = 0
    #words.each do |word|
    #  count += word_syllable_count(word)
    #end
    #return count
  end

  def word_count
    self.split.length
  end

  def word_syllable_count(word)
    word.downcase!
    return 1 if word.length <= 3
    word.sub!(/(?:[^laeiouy]es|ed|[^laeiouy]e)$/, '')
    word.sub!(/^y/, '')
    word.scan(/[aeiouy]{1,2}/).size
  end

  def word_count_three_or_more_syllables
    count = 0
    self.split.each do |word|
      count += 1 if word.syllable_count >= 3
    end
    count
  end
end
