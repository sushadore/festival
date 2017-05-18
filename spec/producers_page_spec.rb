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

describe('producer can add artists', {:type => :feature}) do
  it('allows a producer to add a stage') do
    visit('/producer/1/add-artists')
    artist = Artist.create(name: "Katy Perry", bio: "She is so cool")
    artist.save
    fill_in("artist[name]", :with => "Katy perry")
    fill_in("artist[bio]", :with => "She is so cool")
    click_button('Add Artist')
    expect(page).to have_content(Artist)
  end
end

describe('producer can delete stages', {:type => :feature}) do
  it('allows producers to delete stages') do
    visit('/producer/1/stage/add')
    fill_in("stage_name", :with => "blue stage")
    click_button('Create Stage')
    visit('/producer/1')
    all("input[type='checkbox']").each{|box| box.set('true')}
    click_button('DELETE STAGE(S)')
    expect(page).to have_no_content("Blue Stage")
  end
end
