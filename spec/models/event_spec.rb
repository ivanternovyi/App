require 'rails_helper'

describe Event do

  it "validates title and makes sure it`s not empty" do
    event = Event.new(title: '')
    event.valid?
    expect(event.errors[:title]).not_to eql "empty"
  end

  it "ensures not all day event" do
    time = Time.new(2018, 2, 19, 12, 35, 0)
    event = Event.new(title: 'Test', start: time, end: time.change(day:4))
    expect(event.all_day_event?).not_to eq true
  end

end
