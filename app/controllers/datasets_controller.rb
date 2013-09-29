class DatasetsController < ApplicationController
  def retrieve_from_terms
    headers['Access-Control-Allow-Origin'] = "*" 
    @datasets=Hash.new(0)
    @terms=Hash.new(0)
    requested_terms=params[:terms].split(/[ -]/)
    requested_terms.each do |requested_term|
      Term.find_all_by_term(requested_term).each do |term|
        term.term_items.each do |term_item|
          @datasets[term_item.dataset] += 1
          term_item.dataset.term_items.each do |ds_term|
            @terms[ds_term.term.term] += 1
          end
        end
      end  
    end

    #Select top 25 datasets according to frequency of terms
    @datasets=@datasets.sort_by {|key,value| value}.reverse.first(25)
    @terms=@terms.sort_by {|key,value| value}.reverse.first(28)
  end
end