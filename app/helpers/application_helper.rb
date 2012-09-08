#ecoding: utf-8
module ApplicationHelper
  def display_notice_and_alert
    return send(flash[:special]) if flash[:special]
    msg = ''
    msg << (content_tag :div, notice, :class => "alert alert-block alert-success fade in") if notice
    msg << (content_tag :div, alert, :class => "alert alert-block alert-error fade in") if alert
    sanitize msg
  end

  def html_contents
    contents = []
    result = yield contents

    if contents.count > 0
      return contents.join(' ').html_safe
    end

    if result.respond_to?(:html_safe)
      return result.html_safe
    end
  end

  def contents_tag(tag_name, options = {}, &block)
    self.content_tag tag_name, options do
      self.html_contents(&block)
    end
  end

  def link_avatar_to_user(user, options = {})
    options[:size] ||= 48
    link_to image_tag(user.head_url), user
  end

  def link_to_user(user)
    link_to user.name, user
  end

  def format_time(time)
    timeago_tag time, :limit => 1.weeks.ago
  end

  def format_text(text, options = {})
    sanitize markdown(link_mentions(text.to_s, options[:mention_names]))
  end

  @@html_render  = Redcarpet::Render::HTML.new :hard_wrap => true, :no_styles => true
  @@markdown     = Redcarpet::Markdown.new @@html_render, :autolink => true, :no_intra_emphasis => true
  def markdown(text)
    @@markdown.render(text)
  end

  def link_mentions(text, mention_names)
    if mention_names && mention_names.any?
      text.gsub(/@(#{mention_names.join('|')})(?![.\w])/) do
        username = $1
        %Q[@<a href="/~#{username}">#{username}</a>]
      end
    else
      text
    end
  end
end
