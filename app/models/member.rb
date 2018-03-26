class Member < ActiveRecord::Base
  belongs_to :team
  belongs_to :dietary_restriction

  validates :first_name, presence: true, length: { maximum: 255 }
  validates :last_name, presence: true, length: { maximum: 255 }
  validates :team, presence: true
  validates :dietary_restriction, presence: true
end
