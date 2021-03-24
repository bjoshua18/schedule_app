require 'rails_helper'

RSpec.describe "posts/edit.html.haml", type: :view do
  let(:post) { create :post }
  it 'render edit post form' do
    @post = post
    render

    expect(response).to render_template 'posts/edit'
    expect(response).to render_template 'posts/_form'
  end  
end
