require 'linkedin'

# get your api keys at https://www.linkedin.com/secure/developer
client = LinkedIn::Client.new('75t6gwdv4jlm49', 'PAmjg4ziJRSN0TLi')

  # If you want to use one of the scopes from linkedin you have to pass it in at this point
  # You can learn more about it here: http://developer.linkedin.com/documents/authentication
  request_token = client.request_token({}, :scope => "r_fullprofile,r_network")

rtoken = request_token.token
rsecret = request_token.secret

# to test from your desktop, open the following url in your browser
# and record the pin it gives you
puts request_token.authorize_url


#puts "Access this URL get the PIN and paste it here:"
#pin = gets.strip
# then fetch your access keys
#puts client.authorize_from_request(rtoken, rsecret, pin)

client.authorize_from_access("a0348766-6ed4-4aab-abce-5670545591d7", "b14f3830-6203-41b1-9360-af4a72c65a02")


# you're now free to move about the cabin, call any API method

# get the profile for the authenticated user
c = client.profile(:url => 'http://www.linkedin.com/in/cartolano', :fields => %w(first_name last_name headline positions summary educations courses patents certifications specialties public_profile_url))
puts c
puts c.first_name
puts c.last_name
puts c.headline
puts c.positions
puts c.summary
puts c.educations
puts c.courses
puts c.patents
puts c.certifications
puts c.specialties
puts c.public_profile_url