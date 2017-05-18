require "spec_helper"

describe('attendees can create an account', {:type => :feature}) do
  it('allows festival attendees to signup for an account') do
    visit('/')
    fill_in("name", :with => "sowmya")
    fill_in("username", :with => "sowmya1")
    fill_in("password", :with => "sowmya2")
    click_button('Add User')
    expect(page).to have_content("Hello Sowmya!")
  end
end

describe('attendee logs in to the account after signing up', {:type => :feature}) do
  it('allows an attendee to add an artist') do
    @attendee = Attendee.create(name: "Steven", username: "steventest", password: "123456t", id: 1)
    visit('/attendee/1')
    expect(page).to have_content("There are no artists to add right now. Check back later!")
  end
end
