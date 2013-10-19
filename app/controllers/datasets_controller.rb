# Author: Abhiroop Bhatnagar

class DatasetsController < ApplicationController
  def retrieve_from_terms
    headers['Access-Control-Allow-Origin'] = "*" 
    @datasets=Hash.new(0)
    @terms=Array.new()
    terms_related_to=Hash.new

    requested_terms=params[:terms].split(/[ -,.:;+]/)
    requested_terms.each do |requested_term|
      terms_related_to[requested_term]=Array.new()
      Term.find(:all, :conditions => ["lower(term) = ?", requested_term.downcase]).each do |term|
        term.term_items.each do |term_item|
          @datasets[term_item.dataset] += 1
          term_item.dataset.term_items.each do |ds_term|
            term_value=ds_term.term.term
            if !(terms_related_to[requested_term].include?(term_value) || terms_related_to[requested_term].include?(term_value.pluralize))
              terms_related_to[requested_term].push(term_value)
            end
          end
        end
      end  
      if(@terms.empty?)
        @terms += terms_related_to[requested_term]
      else
        @terms &= terms_related_to[requested_term]
      end
    end

    #Select top 25 datasets according to frequency of terms
    @datasets=@datasets.sort_by {|key,value| value}.reverse.first(25)

    terms_similar_to_requested_terms =  requested_terms
    terms_similar_to_requested_terms += requested_terms.map  {|requested_term| requested_term.capitalize}
    terms_similar_to_requested_terms += terms_similar_to_requested_terms.map  {|term| term.singularize}
    terms_similar_to_requested_terms += terms_similar_to_requested_terms.map  {|term| term.pluralize}

    terms_similar_to_requested_terms += requested_terms.map  {|requested_term| requested_term.upcase}
    terms_similar_to_requested_terms.uniq!    

    @terms -= terms_similar_to_requested_terms
    
    @terms = @terms.sort_by{ |m| m }
  end
end