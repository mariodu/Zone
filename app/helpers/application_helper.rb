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
end
