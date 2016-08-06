class Album < ActiveRecord::Base
  RECORDING_TYPE = %w(Live Studio)

  #validaitons
  validates :band_id, :title, :recording_type, :year, presence: true
  validates :title, uniqueness: {scope: :band_id}
  validates :recording_type, inclusion: {in: RECORDING_TYPE}
  #associations
  belongs_to :band

  has_many :tracks, dependent: :destroy
end
