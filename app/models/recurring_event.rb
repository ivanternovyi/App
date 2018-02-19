# == Schema Information
#
# Table name: recurring_events
#
#  id         :integer          not null, primary key
#  title      :string
#  anchor     :date
#  frequency  :integer          default(0)
#  color      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class RecurringEvent < ApplicationRecord
  enum frequency: { weekly: 0, biweekly: 1, every16weeks: 2, monthly: 3, annually: 4 }

  validates :anchor, presence: true
  validates :frequency, presence: true

  def schedule
    @schedule ||= begin
      schedule = IceCube::Schedule.new(now = anchor)
      case frequency
      when 'weekly'
        schedule.add_recurrence_rule IceCube::Rule.weekly(1)
      when 'biweekly'
        schedule.add_recurrence_rule IceCube::Rule.weekly(2)
      when 'every16weeks'
        schedule.add_recurrence_rule IceCube::Rule.weekly(16)
      when 'monthly'
        schedule.add_recurrence_rule IceCube::Rule.monthly(1)
      when 'annually'
        schedule.add_recurrence_rule IceCube::Rule.yearly(1)
      end
      schedule
    end
  end

  def events(start_date, end_date)
    start_frequency = start_date ? start_date.to_date : Date.today - 1.year
    end_frequency = end_date ? end_date.to_date : Date.today + 1.year
    schedule.occurrences_between(start_frequency, end_frequency)
  end

end
