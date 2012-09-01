class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable
  devise :database_authenticatable,   :registerable,
         :recoverable, :rememberable, :trackable,
         :omniauthable

  attr_accessible :email, :password, :password_confirmation,
                  :remember_me, :name, :authentications_attributes,
                  :public_email, :head_url, :university

  has_many :authentications
  accepts_nested_attributes_for :authentications

  validates :name,
    :presence   => { :message => I18n.t('user.validation_name_presence') },
    :length     => { :message => I18n.t('user.validation_name_length'), :in => 2..4}
  validates :email,
    :format => {:with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/},
    :presence   => { :message => I18n.t('user.validation_email_presence') },
    :uniqueness => { :case_sensitive => false }
  validates :password,
    :presence   => true,
    :length     => {:minimum => 6, :allow_nil => true},
    :confirmation => {:message => I18n.t('user.validation_user_password_confirmation')}
  validates :password_confirmation, :presence   => true

  def self.find_for_renren_oauth(auth, signed_in_resource = nil)
    user = Authentication.find_by_provider_and_uid(auth.provider, auth.uid).try(:user)
    return user if user

    fields = []
    fields << "uid"
    fields << "name"
    fields << "sex"
    fields << "headurl"
    fields << "work_history"
    fields << "university_history"

    #   [{"uid"=>335186815,
    # "tinyurl"=>
    #  "http://hdn.xnimg.cn/photos/hdn121/20110928/2030/tiny_g3r9_59243p019117.jpg",
    # "hometown_location"=>{"province"=>"", "city"=>""},
    # "sex"=>1,
    # "university_history"=>
    #  [{"department"=>"软件学院", "name"=>"吉林大学", "year"=>2010},
    #   {"department"=>"软件学院", "name"=>"吉林大学", "year"=>2010}],
    # "work_history"=>
    #  [{"end_date"=>"2012-08",
    #    "company_name"=>"宝雷杭软件公司",
    #    "description"=>"",
    #    "start_date"=>"2011-07"}],
    # "name"=>"秦鸿儒",
    # "mainurl"=>
    #  "http://hdn.xnimg.cn/photos/hdn121/20110928/2030/main_v71y_58924k019117.jpg",
    # "headurl"=>
    #  "http://hdn.xnimg.cn/photos/hdn121/20110928/2030/head_L0Zz_58924k019117.jpg"}]

    renren_base = Renren::Base.new(auth['credentials']['token'])
    user_info   = renren_base.call_method(:method => 'users.getInfo', :fields => fields.join(',')).first

    password = Devise.friendly_token[0,20]
    create!(
      :name     => user_info['name'],
      :email    => "#{auth.uid}@#{auth.provider}.zone",
      :password => password,
      :password_confirmation => password,
      :head_url   => user_info['headurl'],
      :university => user_info['university_history'].last['name'],
      :authentications_attributes => [
      Authentication.new(
        provider: auth.provider,
        uid:      auth.uid).attributes])
  end

  def admin?
    false
  end
end
