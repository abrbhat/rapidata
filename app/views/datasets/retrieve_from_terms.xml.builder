xml.instruct!
xml.rapidata do
	xml.datasets() do
		@datasets.each do |dataset,priority|
			xml.dataset do
				xml.title(dataset.title)
				xml.description(dataset.description)
				xml.link(dataset.link)
				xml.department(dataset.department)
				xml.sector(dataset.sector)
				xml.priority(priority)
				xml.terms do
					dataset.term_items.each do |term_item|
						xml.term(term_item.term.term)
					end
				end
				
			end
		end
	end
	xml.list_terms() do
		@terms.each do |term,priority|
			xml.list_term(term)
		end
	end
end