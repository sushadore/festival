class Stage < ActiveRecord::Base
  has_many :performances

  has_many :artists, through: :performances
  before_save :capitalize_name
  validates :name, {:presence => true, :uniqueness => {case_sensitive: false}}

private
  def capitalize_name
    self.name=(name.split(/(\W)/).map(&:capitalize).join)
  end
end
