class Teacher < ApplicationRecord

   has_many :curricular_components, foreign_key: 'responsible_id'
end
