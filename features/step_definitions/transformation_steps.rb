Transform /^table:.*user email.*$/ do |table|
  table.tap do |t|
    t.map_column!('user email'){ |user_email|
      if user_email.is_a? String
        User.where(email: user_email).first
      else
        User.find(user_email)
      end
    }
    t.map_headers!('user email' => 'user')
  end
end
