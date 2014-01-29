require 'linkedin-scraper'

profile = Linkedin::Profile.get_profile("http://br.linkedin.com/in/cartolano")

profile.first_name          # The first name of the contact

profile.last_name           # The last name of the contact

puts profile.name                # The full name of the profile

puts profile.title               # The job title

puts profile.summary             # The summary of the profile

puts profile.location            # The location of the contact

puts profile.country             # The country of the contact

puts profile.industry            # The domain for which the contact belongs

puts profile.picture             # The profile picture link of profile

puts profile.skills              # Array of skills of the profile

puts profile.organizations       # Array organizations of the profile

puts profile.education           # Array of hashes for education

puts profile.websites            # Array of websites

puts profile.groups              # Array of groups

puts profile.languages           # Array of languages

puts profile.certifications      # Array of certifications

puts profile.current_companies   #Where is working

puts profile.past_companies      #Where worked

#Pessoas que viram este perfil também viram...
puts profile.recommended_visitors
