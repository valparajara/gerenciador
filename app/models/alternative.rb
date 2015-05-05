class Alternative < ActiveRecord::Base
  belongs_to :question

  validates :anwser, presence: true

end
