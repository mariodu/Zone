class Reply < ActiveRecord::Base
  attr_accessible :content, :user, :topic
  belongs_to :user
  belongs_to :topic

  validates :content,
    :presence     => { :message => I18n.t('user.validation_name_presence') }

  def anchor
    "reply-#{self.id}"
  end

  def edited?
    updated_at > created_at
  end
end
