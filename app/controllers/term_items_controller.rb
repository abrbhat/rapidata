class TermItemsController < ApplicationController
  def build
    Dataset.all.each do |dataset|
      tagger= EngTagger.new

      text=[dataset.title,dataset.description,dataset.department].join(' ')
      tagged=tagger.add_tags(text.gsub(/(\.)/,'. '))
      nouns=tagger.get_nouns(tagged)

      text.scan(/\d+/).each do |numbers|
        nouns[numbers]+=1
      end
      
      nouns.each do |noun,frequency|
        noun.split(/[-\\\/]/).each do |refined_noun|
          refined_noun.delete!(",.;:")
          if(refined_noun =~ /^[a-z0-9]*$/)
            refined_noun.capitalize!
          end
          if(first_character_is_not_zero(refined_noun) and word_is_not_an_acronym_and_not_less_than_5_character(refined_noun) and word_is_not_in_camelcase(refined_noun))
            term=Term.find_or_create_by_term(refined_noun)
            term_item=TermItem.find_or_create_by_term_id_and_dataset_id(term.id,dataset.id)
          end
        end
      end
    end        
  end
  private 
  def first_character_is_not_zero(string)
    string =~ /^[1-9a-zA-Z]\w{1,}/
  end  
  def word_is_not_an_acronym_and_not_less_than_5_character(string)
    return (  not(string =~ /^[A-Z][a-z0-9]{1,4}$/) or word_is_a_month(string)  )
  end
  def word_is_a_month(string)
    string.in?(["June","July","May"])
  end
  def word_is_not_in_camelcase(string)
    not(string =~ /^[A-Z][a-z0-9]+([A-Z][a-z0-9]*)+$/)
  end
end

