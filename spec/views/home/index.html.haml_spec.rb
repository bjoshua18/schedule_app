require 'rails_helper'

RSpec.describe "home/index.html.haml", type: :view do
  it 'has a correct title' do
    assign(:home, HomeController.new)
    render
    
    expect(rendered).to match /Welcome to Schedule Post App/
  end
end
