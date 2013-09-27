json.dataset do
	json.array!(@datasets) do |json,dataset|
		json.title(dataset[0].title)
		json.description(dataset[0].description)
		json.link(dataset[0].link)
		json.department(dataset[0].department)
		json.sector(dataset[0].sector)
		json.priority(dataset[1])
		json.terms do
			json.array!(dataset[0].term_items) do 		|json,term_item|
					json.term(term_item.term.term)
			end
		end
	end
end