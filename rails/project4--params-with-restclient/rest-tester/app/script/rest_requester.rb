require 'rest-client'

url = "http://localhost:3000/users/"
puts RestClient.get(url)

url = "http://localhost:3000/users/new"
puts RestClient.get(url)

url = "http://localhost:3000/users/1/edit"
puts RestClient.get(url)

url = "http://localhost:3000/users/1"
puts RestClient.get(url)

url = "http://localhost:3000/users"
puts RestClient.post(url, "")