class Participant < ApplicationRecord

  enum result: { none: 10, winning: 20 }, _prefix: :part

  belongs_to :lottery
  validates :user_name, :result, presence: true
  validates :user_name, uniqueness: true
  #scope :order_desc, lambda {
  #  order("updated_at desc")
  #}
end
