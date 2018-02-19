require 'rails_helper'

describe RecurringEvent do

  it "validates anchor and makes sure it`s not empty" do
    event = RecurringEvent.new(anchor: '', frequency: 1)
    expect(event.errors[:anchor]).not_to eq true
  end

  it "validates frequency and makes sure it`s not empty" do
    event = RecurringEvent.new(anchor: '2018', frequency: '')
    expect(event.errors[:anchor]).not_to eq true
  end

  it "checks recurring event schedule" do
    event = RecurringEvent.new(anchor: Date.parse('3rd Feb 2015'), frequency: 4)
    expect(event.schedule.occurs_on?(Date.parse("3rd Feb 2005"))).to eq false
  end

  it "checks if schedule occurs between two dates" do
    event_schedule = RecurringEvent.new(anchor: Date.parse('5th Feb 2015'),
                                        frequency: 0)
    start_date = Date.parse('3rd Feb 2015')
    end_date = Date.parse('7th Feb 2015')
    expect(event_schedule.events(start_date, end_date).empty?).to eq false
  end

end
