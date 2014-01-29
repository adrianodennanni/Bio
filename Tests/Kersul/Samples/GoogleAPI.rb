require 'google/api_client'
require 'google/api_client/client_secrets'
require 'google/api_client/auth/installed_app'
require 'json'

# Initialize the client.
client = Google::APIClient.new(
:application_name => 'BioBR',
:application_version => '1.0.0'
)

# Setting what API of Google we're using
search = client.discovered_api('customsearch')

# Custom Search API don't need authorization
client.authorization = nil

puts "Qual pesquisa deseja fazer?"
STDOUT.flush  
query = gets.chomp


# Make an API call.
result = client.execute(
  search.cse.list, 'key'=> 'AIzaSyDobwnlFqHozJuxjnyGOTH7yt0B06H0lXU', 'cx' => '015946578298538871421:gfvaptlgeas', 'alt' => 'json' , 'q' => query 
)

puts result.data.items[0].link
