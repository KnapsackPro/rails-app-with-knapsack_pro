Given /^I visit welcome page$/ do
  visit root_path
end

When /^I click on calculator link$/ do
  click_link 'Calculator'
end

When /^I should be on calculator page$/ do
  # flaky test for cucumber config:
  # --retry 5 --no-strict-flaky]
  #expect([1,2].sample).to eq 1

  expect(current_path).to eq calculator_index_path
end
