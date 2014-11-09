class Schedule
  include Mongoid::Document

  field :name,        type:String
  field :classroom,   type:String
  field :techer,      type:String
  field :bname,       type:String
  field :bid,         type:String
  field :week,        type:String
  field :weeknum,     type:String

  has_and_belongs_to_many :persons
end