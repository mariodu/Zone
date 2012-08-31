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

  validates :name,
    :presence   => { :message => I18n.t('user.validation_name_presence') },
    :length     => { :message => I18n.t('user.validation_name_length'), :in => 2..4}
  validates :email,
    :presence   => { :message => I18n.t('user.validation_email_presence') },
    :uniqueness => { :case_sensitive => false }
  validates :password, :password_confirmation, :presence => true, :on => :create
  validates :password, :length => {:minimum => 6, :allow_nil => true}

  def self.find_for_renren_oauth(auth, signed_in_resource = nil)
    binding.pry
    user = Authentication.find_by_provider_and_uid(auth.provider, auth.uid).try(:user)
    return user if user

    password = Devise.friendly_token[0,20]
    create!(
      :name     => auth.info.name,
      :email    => "#{auth.uid}@#{auth.provider}.zone",
      :password => password,
      :password_confirmation => password,
      :authentications_attributes => [
      Authentication.new(
        provider: auth.provider,
        uid:      auth.uid).attributes])
  end

  def admin?
    false
  end
end
