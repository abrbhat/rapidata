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
			end
		end
	end
	xml.terms() do
		@terms.each do |term,priority|
			xml.term(term)
		end
	end
end