class DatasetsController < ApplicationController
  def retrieve_from_terms
    headers['Access-Control-Allow-Origin'] = "*" 
    @datasets=Hash.new(0)
    @terms=Array.new()
    @terms_related_to_requested_term=Hash.new

    @requested_terms=params[:terms].split(/[ -,.:;+]/)
    @requested_terms.each do |requested_term|
      @terms_related_to_requested_term[requested_term]=Array.new()
      Term.find(:all, :conditions => ["lower(term) = ?", requested_term.downcase]).each do |term|
        term.term_items.each do |term_item|
          @datasets[term_item.dataset] += 1
          term_item.dataset.term_items.each do |ds_term|
            @terms_related_to_requested_term[requested_term] << ds_term.term.term
          end
        end
      end  
      if(@terms.empty?)
        @terms += @terms_related_to_requested_term[requested_term]
      else
        @terms = @terms & @terms_related_to_requested_term[requested_term]
      end
    end

    #Select top 25 datasets according to frequency of terms
    @datasets=@datasets.sort_by {|key,value| value}.reverse.first(25)
    @terms=@terms.first(33)
  end
end