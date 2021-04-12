class Publisher
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name, type: String
  field :token, type: String

  has_many :posts, dependent: :destroy
end
