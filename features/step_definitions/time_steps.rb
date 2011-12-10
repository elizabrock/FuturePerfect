Given 'the time is $time' do |time|
  parsed_time = DateTime.strptime time.gsub("\"",""), '%m/%d/%Y %H:%M %Z'
  Timecop.freeze parsed_time
end

Given /^two days have passed$/ do
  Timecop.travel(Time.now + 2.day)
end

When 'time stands still' do
  Timecop.freeze Time.now
end
