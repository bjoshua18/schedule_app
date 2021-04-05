require 'rails_helper'

RSpec.describe "Providers", type: :system do

  let(:user) { create :user }
  
  before do
    driven_by :selenium, using: :chrome, options: { args: ["headless", "no-sandbox", "disable-dev-shm-usage"] }
    login_as user
    visit new_post_path
  end

  it 'should render Provider select in React component' do
    expect(page).to have_select('Provider');
  end

  it 'should render Twitter User select in React component' do
    select('Twitter', from:'Provider')
    expect(page).to have_select('Twitter User')
  end

  it 'should render Facebook User select in React component' do
    select('Facebook', from:'Provider')
    expect(page).to have_select('Facebook User')
  end

  it 'should not render Twitter or Facebook User select in React component' do
    select('Select a provider', from:'Provider')
    expect(page).to_not have_select('Facebook User')
    expect(page).to_not have_select('Twitter User')
  end

  it 'should not render Facebook User Page select in React component' do
    select('Facebook', from:'Provider')
    select('Select an user', from:'Facebook User')
    expect(page).to_not have_select('Facebook User Page')
  end

end