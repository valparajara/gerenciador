class Question < ActiveRecord::Base

  validates :code, :enunciation, :template, presence: true

  has_many :alternatives, dependent: :destroy
  accepts_nested_attributes_for :alternatives, limit: 5

end
