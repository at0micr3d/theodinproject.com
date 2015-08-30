class Book
	def title=(new_title)
		string = new_title.split(' ').map {|i| cap_excl_conjunctions(i)}.join(' ').to_s
		@title = string.slice(0,1).capitalize + string.slice(1..-1)
	end
	def title()
		@title
	end
	def cap_excl_conjunctions(string)
		conjunctions = ['and','but','or','nor','for','yet','so']
		prepositions = ['in','the','of']
		articles = ['a','an','the']
		incl_conj = conjunctions.include?(string.downcase)
		incl_prep = prepositions.include?(string.downcase)
		incl_art = articles.include?(string.downcase)
		if incl_conj or incl_prep or incl_art then 
			return string
		end
		if string == "i" then 
			return string.upcase
		end
		if string.to_i.to_s == string then 
			return string
		end
		return string.capitalize!
	end
end
