class Spaceship < ApplicationRecord
  include PgSearch::Model

  pg_search_scope :search,
    against: [ :name, :address, :description ],
    using: {
      tsearch: { prefix: true }
    }

  belongs_to :user
  has_many :bookings, dependent: :destroy
  has_many :reviews, dependent: :destroy

  has_one_attached :photo

  validates :name, :address, :description, :unit_price, :size,
            :max_speed, :capacity, presence: true
  validates :name, uniqueness: true, length: { minimum: 5 }
  validates :description, length: { minimum: 20 }

   def unavailable_dates
    bookings.pluck(:start_date, :end_date).map do |range|
      { from: range[0], to: range[1] }
    end
  end
end
