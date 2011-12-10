def path_to(page_name)
  case page_name

  when /^the home\s?page$/
    '/'
  when /^the sign\s?in page$/
    new_user_session_path
  when /^the goal page for "([^"]*)"$/
    goal_path(Goal.find_by_title $1)
  else
    raise "Can't find mapping from \"#{page_name}\" to a path.\n" +
      "Now, go and add a mapping in #{__FILE__}"
  end
end

When /^(?:|I )go to (.+)$/ do |page_name|
  visit path_to(page_name)
end

Given /^(?:|I )am on (.+)$/ do |page_name|
  visit path_to(page_name)
end

Then /^(?:|I )should be on (.+)$/ do |page_name|
  current_path = URI.parse(current_url).path
  if current_path.respond_to? :should
    current_path.should == path_to(page_name)
  else
    assert_equal path_to(page_name), current_path
  end
end

When /^(?:|I )press "([^"]*)"$/ do |button|
  click_button(button)
end

When /^(?:|I )follow "([^"]*)"$/ do |link|
  click_link(link)
end

Then /^(?:|I )should see "([^"]*)"$/ do |text|
  if page.respond_to? :should
    page.should have_content(text)
  else
    assert page.has_content?(text)
  end
end

When /^(?:|I )fill in "([^"]*)" with "([^"]*)"$/ do |field, value|
  fill_in(field, :with => value)
end

When /^(?:|I )fill in "([^"]*)" for "([^"]*)"$/ do |value, field|
  fill_in(field, :with => value)
end

When /^I click "([^"]*)"$/ do |link|
  click_link(link)
end

Then /^I should see the error message "([^"]*)"$/ do |error_message|
  page.should have_css("#error_explanation", text: error_message)
end

Then /^(?:|I )should not see "([^"]*)"$/ do |text|
  if page.respond_to? :should
    page.should have_no_content(text)
  else
    assert page.has_no_content?(text)
  end
end

Then /^show me the page$/ do
  save_and_open_page
end

Then /^(?:|I )should see the following list:$/ do |table|
  table.raw.each_with_index do |content, row|
    page.should have_xpath("//ul/li[#{row+1}][contains(normalize-space(.), '#{content[0]}')]")
  end
end

Then /^(?:|I )should see the following:$/ do |table|
  table.raw.each_with_index do |content, row|
    page.should have_content(content[0])
  end
end
