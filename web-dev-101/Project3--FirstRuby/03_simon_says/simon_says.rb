def echo(msg)
	msg
end

def shout(msg)
	msg.upcase
end

def repeat(msg, n = 2)
	totalmsg = ''
	n.times do
		totalmsg = totalmsg + msg + ' '
	end
	return totalmsg[0..-2]
end

def start_of_word(msg, nr_char)
	return msg[0..nr_char-1]
end

def first_word(fw)
	return fw.split(" ")[0]
end

def titleize(msg)
	stop_words = %w{a over an and the or for of nor} #there is no such thing as a definite list of stop words, so you may edit it according to your needs.
  	msg.split.each_with_index.map{|word, index| stop_words.include?(word) && index > 0 ? word : word.capitalize }.join(" ")
end
