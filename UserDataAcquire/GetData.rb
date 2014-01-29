require 'google/api_client'
require 'google/api_client/client_secrets'
require 'google/api_client/auth/installed_app'
require 'linkedin-scraper'


# Initialize the client.
client = Google::APIClient.new(
:application_name => 'BioBR',
:application_version => '1.0.0'
)

# Setting what API of Google we're using
search = client.discovered_api('customsearch')

# Custom Search API don't need authorization
client.authorization = nil

puts "Digite o nome de quem deseja pesquisar:"
STDOUT.flush  
query = gets.chomp

puts "\n"
puts "Pesquisando..."
puts "\n"

# Searching on Linkedin
result = client.execute(
  search.cse.list, 'key'=> 'AIzaSyDobwnlFqHozJuxjnyGOTH7yt0B06H0lXU', 'cx' => '015946578298538871421:gfvaptlgeas', 'alt' => 'json' , 'q' => query, 'siteSearch' => 'linkedin.com'
)

linkLinkedin = result.data.items[0].link


#Linkedin Data
profile = Linkedin::Profile.get_profile(linkLinkedin)

puts "Primeiro Nome: #{profile.first_name}"             # First name
puts "Ultimo Nome: #{profile.last_name}"                # The last name of the contact
puts "Nome Completo: #{profile.name}"                   # The full name of the profile
puts "Trabalho: #{profile.title}"                       # The job title
puts "Sumario: #{profile.summary}"                      # The summary of the profile
puts "Localizacao: #{profile.location}"                 # The location of the contact
puts "Pais: #{profile.country}"                         # The country of the contact
puts "Dominio pertencente: #{profile.industry}"         # The domain for which the contact belongs
puts "Link da Imagem de Perfil: #{profile.picture}"     # The profile picture link of profile
puts "Skills: #{profile.skills}"                        # Array of skills of the profile
puts "Organizacoes: #{profile.organizations}"           # Array organizations of the profile
puts "Educacao:"                   # Array of hashes for education

id=0
profile.education.each do
  profile.education[id].each do |key, value|
    print "|#{key}: #{value}| "
  end
  puts "\n"
  id+=1
end

puts "Websites: #{profile.websites}"                    # Array of websites
puts "Grupos: #{profile.groups}"                        # Array of groups
puts "Linguas: #{profile.languages}"                    # Array of languages
puts "Certificacoes: #{profile.certifications}"         # Array of certifications
puts "Onde Trabalha:"      #Where is working
id=0
profile.current_companies.each do
  profile.current_companies[id].each do |key, value|
    print "|#{key}: #{value}| "
  end
  puts "\n"
  id+=1
end

puts "Onde Trabalhou:"        #Where worked
id=0
profile.past_companies.each do
  profile.past_companies[id].each do |key, value|
    print "|#{key}: #{value}| "
  end
  puts "\n"
  id+=1
end
