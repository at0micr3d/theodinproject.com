require 'socket'
require 'json'

# host = 'www.tutorialspoint.com'     # The web server
# port = 80                           # Default HTTP port
# path = "/ruby/ruby_socket_programming.htm"                 # The file we want 


# host = 'www.wolfslaar.com'     # The web server
# port = 80                           # Default HTTP port
# path = "/bijeenkomsten/zakelijk"                 # The file we want 

# host = 'www.coolenschilders.nl'     # The web server
# port = 80                           # Default HTTP port
# path = "/bedrijf.html"                 # The file we want 
class Connection
	def initialize(host, port)
		@host = host
		@port = port
	end

	def GET(path)
		# This is the HTTP request we send to fetch a file
		request = "GET #{path} HTTP/1.0\r\n\r\n"
		response = send_request(request)
		
	end

	def POST(path, post_input)
		request = "POST #{path} HTTP/1.0\r\nContent-length: #{post_input.to_s.length}\r\n\r\n#{post_input.to_json}"
		response = send_request(request)
		
	end

	private

	def send_request(request)
		socket = TCPSocket.open(@host,@port)  # Connect to server
		socket.print(request)               # Send request
		response = socket.read					# Read complete response
		socket.close
		headers,body = response.split("\r\n\r\n", 2)
		
		return "could not interpret message:\n" + headers if succes?(headers) == -1
		return body if succes?(headers)
		return "404. Could not be found." if not succes?(headers)
		
	end

	def succes?(headers)
		case 
		when !headers.scan(/200/).empty?
			ret =  true
		when !headers.scan(/404/).empty?
			ret = false
		else
			ret = -1
		end
		return ret
	end
end

host = 'localhost'     # The web server
port = 2000                           # Default HTTP port

con = Connection.new(host, port)

puts "Which kind of request do you want to send?"
puts "GET or POST"
input = gets.chomp

case input.downcase
when "get"
	path = "/index.html" 
	puts con.GET(path)
when "post"
	path = "/thanks.html"  
	puts "Viking name?"
	name = gets.chomp
	puts "Viking email?"
	email = gets.chomp
	hash_input = {}
	hash_input[:viking] = {:name => name, :email => email}
	puts con.POST(path, hash_input)
end


