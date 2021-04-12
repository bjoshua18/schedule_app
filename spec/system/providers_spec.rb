require 'rails_helper'

RSpec.describe "Providers", type: :system do

  let(:user) { create :user }
  
  before do
    driven_by :selenium, using: :chrome, options: { args: ["headless", "no-sandbox", "disable-dev-shm-usage"] }
    login_as user
    visit new_post_path
  end

  it 'should render Provider select in React component' do
    expect(page).to have_select('provider');
  end

  it 'should render Twitter User select in React component' do
    select('Twitter', from:'provider')
    expect(page).to have_select('post_publisher_id')
  end

  it 'should render Facebook User select in React component' do
    select('Facebook', from:'provider')
    expect(page).to have_select('facebook_account')
  end

  it 'should not render Twitter or Facebook User select in React component' do
    select('Select a provider', from:'provider')
    expect(page).to_not have_select('facebook_account')
    expect(page).to_not have_select('post_publisher_id')
  end

  it 'should not render Facebook User Page select in React component' do
    select('Facebook', from:'provider')
    select('Select an user', from:'facebook_account')
    expect(page).to_not have_select('post_publisher_id')
  end

end