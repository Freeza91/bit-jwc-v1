class Person
  include Mongoid::Document

  field :name,        type:String
  field :sex,         type:String
  field :school_num,  type:String
  field :wechat,      type:String
  field :ucmid,       type:String
  field :image,       type:String
  field :password,    type:String

  field :class_num,   type:String
  field :acdemy,      type:String
  field :profession,  type:String
  field :period,      type:String
  field :begin_time,  type:String
  field :grade,       type:String
  field :no_grade,    type:String

  field :last_login,  type:DateTime


  has_and_belongs_to_many :schedules

end