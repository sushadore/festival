require "spec_helper"

describe('producers can create an account', {:type => :feature}) do
  it('allows producers to signup for an account') do
    visit('/producer/signup')
    fill_in("producer[name]", :with => "susha")
    fill_in("producer[username]", :with => "susha1")
    fill_in("producer[password]", :with => "susha2")
    click_button('Add User')
    expect(page).to have_content("Susha")
  end
end
