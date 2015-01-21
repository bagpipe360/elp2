Given(/^I'm a teacher$/) do                                                                 
  @user = User.create(:role => 'teacher')                                          
end                                                                                                                                 
def new_time_slot() 
  click_link("New Time slot")
end

When(/^I am on my time slots page$/) do
  visit(time_slots_path)
end                                                                                                                                 

When(/^I fill in my information for a timeslot$/) do                                        new_time_slot()                                                
end     
   
When(/^I save the new timeslot$/) do                                                         click_button("Create Time slot")
end                                                                                                                                 
                                                                                                                                    
                                                                                                                            
                                                                                                                                    
Then(/^I should see my new time slot$/) do                                                      assert page.has_content?(/Time slot was successfully created./i)                                       
end                                                                                                                                 
                                                                                                                                    
