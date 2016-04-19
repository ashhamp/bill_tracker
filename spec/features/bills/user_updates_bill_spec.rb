require 'rails_helper'

feature "authenticated user updates a bill", js: true do
  let!(:user1) { FactoryGirl.create(:user) }
  let!(:user2) { FactoryGirl.create(:user) }
  let!(:bill1) { FactoryGirl.create(:bill, user: user1) }

  scenario "authenticated user updates a bill successfully" do
    new_name = "I'm a New Name"
    new_start_date = Date.parse("2016/10/31")
    new_next_due = Date.parse("2016/12/01")
    new_recurring = "204.50"
    new_web = "https://wwww.amazon.com"

    sign_in(user1)
    click_link bill1.nickname

    click_on "Update"

    fill_in "Nickname", with: new_name
    page.execute_script("$('#datepicker').val('2016/10/31')")
    page.execute_script("$('#datepicker2').val('2016/12/01')")
    fill_in "Recurring Amount", with: new_recurring
    fill_in "Url", with: new_web

    click_on "Submit"

    expect(page).to have_content new_name
    expect(page).to have_content new_start_date.strftime('%D')
    expect(page).to have_content new_next_due.strftime('%D')
    expect(page).to have_content new_recurring
    expect(page).to have_content new_web
    expect(page).to have_content "Bill updated successfully!"

    expect(page).to_not have_content bill1.nickname
    expect(page).to_not have_content bill1.start_due_date.strftime('%D')
    expect(page).to_not have_content bill1.next_due_date.strftime('%D')
    expect(page).to_not have_content bill1.url
  end

  # scenario "user cannot edit different user's bookstore" do
  #   visit root_path
  #   sign_in(user2)
  #   click_link bookstore1.name
  #
  #   expect(page).to_not have_button "Edit Bookstore"
  # end

end
