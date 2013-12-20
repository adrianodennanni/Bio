ThinkingSphinx::Index.define :User, :with => :active_record do
  indexes username
end