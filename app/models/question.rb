class Question < ActiveRecord::Base

  has_many :alternatives, dependent: :destroy
  accepts_nested_attributes_for :alternatives, limit: 5

  validates :code, :enunciation, :template, presence: true
end
