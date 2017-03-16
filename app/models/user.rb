class User < ActiveRecord::Base
  has_many :to_dos

  validates :name,:password, presence: true
  validates :name, uniqueness: {case_sensitive: false}

end
