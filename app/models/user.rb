class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable
  devise :database_authenticatable,   :registerable,
  :recoverable, :rememberable, :trackable,
  :validatable, :omniauthable

  has_many :authentications
  accepts_nested_attributes_for :authentications

  attr_accessible :email, :password, :password_confirmation, :remember_me, :name, :authentications_attributes

  def self.find_for_renren_oauth(auth, signed_in_resource = nil)
    Authentication.find_by_provider_and_uid(auth.provider, auth.uid).try(:user) ||
    create!(
      :name     => auth.info.name,
      :email    => "#{auth.uid}@#{auth.provider}.zone",
      :password => Devise.friendly_token[0,20],
      :authentications_attributes => [
      Authentication.new(
         :provider => auth.provider,
         :uid => auth.uid
         ).attributes])
  end

  def admin?
    false
  end
end
