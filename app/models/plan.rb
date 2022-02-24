class Plan < ApplicationRecord

  with_options presence: true do
    validates :title
    validates :start_date
    validates :end_date
  end

  validate :end_date_after_today
  validate :end_date_after_start_date

  def end_date_after_today
    unless end_date == nil || start_date == nil
      errors.add(:end_date, "は今日以降の日付にしてください") unless
      end_date >= Date.current
    end
  end

  def end_date_after_start_date
    unless end_date == nil || start_date == nil
      errors.add(:end_date, "を開始日より前にすることはできません") unless
      end_date >= start_date
    end
  end

end
