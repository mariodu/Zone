class Authentication < ActiveRecord::Base
  belongs_to :user
  attr_accessible :provider, :uid, :user_id, :created_at, :updated_at

  validates :provider, :presence => true, :uniqueness => {:scope => :user_id}
  validates :uid,      :presence => true, :uniqueness => {:scope => :provider}
end
