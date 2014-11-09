class NextSchedules
  include Mongoid::Document

  field :name,        type:String
  field :code,        type:String

  has_and_belongs_to_many :persons
end