require 'rails_helper'

RSpec.describe "posts/new.html.haml", type: :view do
  let(:post) { Post.new }
  it 'render new post form' do
    @post = post
    render

    expect(response).to render_template 'posts/new'
    expect(response).to render_template 'posts/_form'
  end  
end
