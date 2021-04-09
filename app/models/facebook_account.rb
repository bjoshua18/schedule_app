class FacebookAccount
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name, type: String
  field :email, type: String
  field :image, type: String
  field :token, type: String
  field :token_expires_at, type: Time

  belongs_to :user
  has_many :facebook_pages, dependent: :destroy

  validates :email, uniqueness: true

  def client
    Koala::Facebook::API.new(token)
  end

  def pages
    self.client.get_object("me/accounts")
  end

  def set_pages
    self.pages.each do |page|
      facebook_page = self.facebook_pages.where(page_id: page["id"]).first_or_initialize
      facebook_page.update({
        page_id: page["id"],
        name: page["name"],
        token: page["access_token"],
        category: page["category"]
      })
    end
  end
end
