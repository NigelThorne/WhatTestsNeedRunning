Given /^there is no work to do$/ do
  # nothing to do here
end

When /^I request a list of work$/ do
	visit "/pending"
end

Then /^the list is empty$/ do
  response_body.should have_selector("tests") do |items|
  	items.should_not have_selector("test")
  end
end

Given /^the following work items exist:$/ do |table|
  # table is a Cucumber::Ast::Table
  table.hashes.each do |hash|
  	  visit "/tests", :post, hash	
  end
end

Then /^the list shows the work items:$/ do |table|
  # table is a Cucumber::Ast::Table
  response_body.should have_selector("tests") do |items|
  	table.hashes.each do |hash|
  		items.should have_selector("test[id='#{hash[:id]}']") do |item|
  			item.should contain(hash[:name])
  		end
  	end
  end
end
