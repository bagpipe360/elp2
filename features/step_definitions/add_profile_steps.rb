Given(/^I'm a new user$/) do                                                              end                                                                                                                                 
def add_user(verified)
  visit(root_path)
  click_link("New User")
  fill_in("First name", with:"Ben")
  if verified
    check("Verified terms and service")
  else
    uncheck("Verified terms and service")
  end
  click_button("Create User")
end

When(/^I fill in my profile$/) do                                                             
  add_user(true)
end                                                                                                                                 
                                                                                                                             
                                                                                                                                    
When(/^I view my profile$/) do                                                                
  visit(users_path)                                       
end                                                                                                                                 
                                                                                                                                    
Then(/^I should see my information$/) do                                                     
  assert page.has_content?(/Ben/i)                                       
end                                                                                                                                 
