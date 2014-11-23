class TodaySchedule
  include Mongoid::Document

  field :start_at_num, type: Integer
  field :classroom,    type: String

  validates :start_at_num, presence: true
  validates :classroom,    presence: true
end