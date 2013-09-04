class HelloController < ApplicationController
	
	@json = User.all.to_gmaps4rails do |user, marker|
  marker.infowindow render_to_string(:partial => "/users/my_template", :locals => { :object => user})
  marker.picture({
                  :picture => "http://www.blankdots.com/img/github-32x32.png",
                  :width   => 32,
                  :height  => 32
                 })
  marker.title   "i'm the title"
  marker.sidebar "i'm the sidebar"
  marker.json({ :id => user.id, :foo => "bar" })
end
	
	def world
	
	end

	def steve

	end
end
