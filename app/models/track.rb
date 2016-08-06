class Track < ActiveRecord::Base
  TRACK_TYPE = %w(Standard Bonus)
  #validations
  validates :name, :album_id, :ord, :track_type, presence: true
  validates :ord, uniqueness: {scope: :album_id}
  validates :track_type, inclusion: { in: TRACK_TYPE}
  #associations
  belongs_to :album

  has_one :band,
    through: :album,
    source: :band

  has_many :notes
end
