require "rails_helper"

describe "posting a post", :type => :feature do
  let(:user) { ::FactoryGirl.create(:user) }

  before do
    Warden.test_reset!
    login_as(user, scope: :user)
  end

  it "creates a post" do
    Timecop.freeze do
      visit '/posts/new'
      fill_in 'post[title]', with: "My Post"
      fill_in 'post[body]', with: "Lorem ipsum"
      click_button 'Create Post'

      aggregate_failures do
        expect(page).to have_content 'My Post'
        expect(page).to have_content 'Lorem ipsum'
        expect(page).to have_content "Posted on #{ Date.current.strftime("%F") } by #{ user.name }"
      end
    end
  end
end
