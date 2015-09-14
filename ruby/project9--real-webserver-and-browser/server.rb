require 'socket'   
require 'json'
require 'erb'


def respond_to_get(path, client)
	begin
		f = File.new("."+path)
		content = f.read	
	rescue
		client.puts "HTTP/1.0 404 Not Found\r\n\r\nfile not found"
	end
	client.puts "HTTP/1.0 200 OK\r\n\r\n" + content
end

class LayoutRenderer	
end

def respond_to_post(path, body, client)
	begin
		f = File.new("."+path)
		content_file = f.read
	rescue
		client.puts "HTTP/1.0 404 Not Found\r\n\r\nfile not found"
	end
	params = {}
	p params = JSON.parse(body)
	erb = ERB.new(content_file)
	erb.def_method(LayoutRenderer, 'render')
	
	result = LayoutRenderer.new.render do 
		key, val = params.first
		"<li>Name: #{val["name"]}</li><li>Email: #{val["email"]}</li>"
	end

	client.puts "HTTP/1.0 200 OK\r\n\r\n" + result
end

def read_client(client)
	response = ""
	while line = client.gets
    response = response + line
    break if line =~ /^\s*$/   #breaks on the \r\n\r\n line
  end
  if response.match(/Content-length: \d*/) #if there is a body, i.e. if there is a header that specifies the length
  	body_length = response.match(/Content-length: \d*/).to_s[16..-1].to_i - 1
   	response = response + client.gets(body_length)
 	end
  return response
end

server = TCPServer.open(2000)  # Socket to listen on port 2000
loop do                        # Servers run forever
  client = server.accept       # Wait for a client to connect
  
  response = read_client(client)
  
  init_line, body = response.split("\r\n\r\n", 2)
  
  case init_line.split(' ')[0]
  when "GET"	
  	respond_to_get(init_line.split(' ')[1], client)
  when "HEAD"
  	puts ""
  when "POST"
  	respond_to_post(init_line.split(' ')[1], body, client)
  end

  client.close                 # Disconnect from the client
end

