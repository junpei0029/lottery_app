class Lottery < ApplicationRecord

  enum status: { wanted: 10, ongoing: 20, finished: 30 }

  has_many :participants, :dependent => :destroy
  accepts_nested_attributes_for :participants, allow_destroy: true

  validates :name, :winning_number, :status, presence: true
  validates :winning_number, numericality: {greater_than_or_equal_to: 1, less_than_or_equal_to: 5}

  scope :my_lotteries, -> (session_id){
    s = order("updated_at desc")
    s = s.where(user_session: session_id)
    s
  }

end
