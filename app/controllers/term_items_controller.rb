class TermItemsController < ApplicationController
  def build
    #@noun_phrases_array=Array.new
    Dataset.all.each do |dataset|
      tagger= EngTagger.new

      text=[dataset.title,dataset.description,dataset.department,dataset.sector].join(' ')
      tagged=tagger.add_tags(text.gsub(/(\.)/,'. '))
      nouns=tagger.get_nouns(tagged.downcase)

      text.scan(/\d+/).each do |numbers|
        nouns[numbers]+=1
      end
      
      nouns.each do |noun,frequency|
        noun.split('-').each do |refined_noun|
          refined_noun.gsub(/(\.)/,'')
          term=Term.find_or_create_by_term(refined_noun)
          term_item=dataset.term_items.build(:term => term,:priority => frequency)
          if term_item.save
            @message="Arey!Yeh to chap gaya!!"
          else
            @message="Kuch gadbad lagti hai mamu"
          end
        end
      end
    end        
  end 
end
