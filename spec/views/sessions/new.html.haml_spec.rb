require 'rails_helper'

RSpec.describe "sessions/new.html.haml", type: :view do
  it 'render login form' do
    render
    expect(response).to render_template 'sessions/new'
    expect(response.body).to include 'simple_form user'
  end
end
