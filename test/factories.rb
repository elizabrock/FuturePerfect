Factory.sequence :email do |n|
  "person#{n}@example.com"
end

Factory.sequence :description do |n|
  "Verb modifier noun"
end

Factory.define :user do |u|
  u.email { Factory.next :email }
  u.password "test_password"
  u.password_confirmation {|a| a.password}
  u.confirmed_at 2.days.ago
end


Factory.define :goal do |g|
  g.description { Factory.next :description }
  g.association :user, :factory => :user
end

Factory.define :child_goal, :parent => :goal do |g|
  g.association :parent_goal, :factory => :goal
  #TODO: get the user from the parent_goal
end
