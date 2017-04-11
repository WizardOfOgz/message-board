require "rails_helper"

describe "the signin process", :type => :feature do
  before :each do
    ::FactoryGirl.create(:user, email: "fred@example.com", password: 'password')
  end

  it "signs me in" do
    visit '/users/sign_in'
    fill_in 'user[email]', with: 'fred@example.com'
    fill_in 'user[password]', with: 'password'
    click_button 'Log in'
    expect(page).to have_content 'Signed in successfully'
  end
end
