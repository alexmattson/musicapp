class Band < ActiveRecord::Base
  #validations
  validates :name, presence: true, uniqueness: true
  #associations
  has_many :albums, dependent: :destroy


end
