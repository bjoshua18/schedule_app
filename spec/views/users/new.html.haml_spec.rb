require 'rails_helper'

RSpec.describe "users/new.html.haml", type: :view do
  let(:user) { User.new }
  it 'render registration form' do
    @user = user
    render
    expect(response).to render_template 'users/new'
    expect(response.body).to include 'simple_form new_user'
  end
end
