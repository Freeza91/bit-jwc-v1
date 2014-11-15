class Schedule
  include Mongoid::Document

  field :name,          type:String
  field :classroom,     type:String
  field :teacher,       type:String
  field :bname,         type:String
  field :bid,           type:String
  field :week,          type:String
  field :weeknum,       type:String
  field :start_at_num,  type:String
  field :start_at_time, type:String

  validates :name,          presence: true
  validates :classroom,     presence: true
  validates :weeknum,       presence: true
  validates :teacher,       presence: true
  validates :bid,           presence: true
  validates :bname,         presence: true
  validates :start_at_num,  presence: true
  validates :week,          presence: true

  has_and_belongs_to_many :persons

  index({ name:1, bname:1, bid:1, start_at_num: 1, weeknum: 1, classroom: 1,
          teacher: 1, week: 1, start_at_time: 1},
        { unique: true, background: true })
end