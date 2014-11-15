class Person
  include Mongoid::Document

  field :name,        type:String
  field :sex,         type:String
  field :school_num,  type:String
  field :wechat,      type:String
  field :ucmid,       type:String
  field :image,       type:String
  field :contract,    type:String

  field :class_num,   type:String
  field :academy,     type:String
  field :profession,  type:String
  field :period,      type:String
  field :begin_time,  type:String
  field :grade,       type:String
  field :no_grade,    type:String
  field :no_grade_recode, type:String
  field :last_login,  type:DateTime


  validates :name,          presence: true
  validates :school_num,    presence: true
  validates :sex,           presence: true
  validates :ucmid,         presence: true
  validates :class_num,     presence: true

  validates_uniqueness_of :school_num

  embeds_many :next_schedules
  has_and_belongs_to_many :schedules

end