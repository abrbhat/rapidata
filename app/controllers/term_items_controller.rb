class TermItemsController < ApplicationController
  def build
    #@noun_phrases_array=Array.new
    Dataset.all.each do |dataset|
      tagger= EngTagger.new

      text=[dataset.title,dataset.description,dataset.department,dataset.sector].join(' ')
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
          if(refined_noun =~ /\w{2,}/)
            term=Term.find_or_create_by_term(refined_noun)
            term_item=TermItem.find_or_create_by_term_id_and_dataset_id(term.id,dataset.id)
          end
        end
      end
    end        
  end 
end
