class CurricularComponent < ApplicationRecord
  belongs_to :responsible, class_name: 'Teacher', foreign_key: 'responsible_id'
  serialize :curso, JSON
  validates :curso, presence: true


end
