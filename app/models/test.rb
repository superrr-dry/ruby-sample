class Test < ApplicationRecord
    belongs_to :user
    validates :content, presence: true, length: { maximum: 20 }
end
