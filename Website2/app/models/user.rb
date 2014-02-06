class User < ActiveRecord::Base
  self.table_name = 'User'
end

def self.search(search)
  if search
    find(:all, :conditions => ['name LIKE ?', "%#{search}%"])
  else
    find(:all)
  end
end