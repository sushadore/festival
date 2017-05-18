require "spec_helper"

describe('producers create an account', {:type => :feature}) do
  it('allows producers to signup for an account') do
    visit('/producer/signup')
    fill_in("producer[name]", :with => "susha")
    fill_in("producer[username]", :with => "susha1")
    fill_in("producer[password]", :with => "susha2")
    click_button('Add User')
    expect(page).to have_content("Susha")
  end
end

describe('producer logs in to the account after signing up', {:type => :feature}) do
  it('allows a producer to add a stage') do
    visit('/producer/1')
    click_link('Add a Stage')
    expect(page).to have_content("There are no stages yet!")
  end
end

describe('producer can add stages', {:type => :feature}) do
  it('allows a producer to add a stage') do
    visit('/producer/1/stage/add')
    fill_in("stage_name", :with => "blue stage")
    click_button('Create Stage')
    expect(page).to have_content("Blue Stage")
  end
end

describe('producer can update stages', {:type => :feature}) do
  it('allows producers to update a stage') do
    visit('/producer/1/stage/1')
    fill_in("name", :with => "red stage")
    click_button('Update Stage')
    expect(page).to have_content("Red Stage")
  end
end
