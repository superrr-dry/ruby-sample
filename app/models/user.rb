class User < ApplicationRecord
    has_many :tests
    validates :name, presence: true, length: { maximum: 10 }, format: { with: /\A[a-zA-Z]+\z/ }
end
