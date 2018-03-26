class Team < ActiveRecord::Base
  has_many :members
  validates :name, presence: true, length: { maximum: 255 }
end
