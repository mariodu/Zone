class Topic < ActiveRecord::Base
  attr_accessible :title, :content, :tag_string

  belongs_to :fonder, :class_name => "User"
  has_many :replies, :dependent => :restrict

  has_and_belongs_to_many :tags

  validates :title, :content, :fonder, :presence => true

  def tag_string=(string)
    tag_array = []
    tags_names = string.to_s.split(/[,\s]+/).uniq
    tags_names.each do |name|
      tag = Tag.find_by_name(name) || Tag.create!({:name => name})
      tag_array << tag
    end

    self.tags = tag_array
  end

  def tag_string
    names = self.tags.map {|tag| tag.name}
    names.join(', ')
  end

  def set_edited_at
    self.edited_at = Time.now.utc
  end

  def edited?
    self.edited_at.present?
  end
end