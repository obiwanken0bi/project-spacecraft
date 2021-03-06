class Booking < ApplicationRecord
  belongs_to :spaceship
  belongs_to :user

  validates :spaceship, :user, :total_price, presence: true

  validates :start_date, :end_date, presence: true, availability: true
  validate :end_date_after_start_date

  private

  def end_date_after_start_date
    return if end_date.blank? || start_date.blank?

    if end_date < start_date
      errors.add(:end_date, "must be after the start date")
    end
 end
end
