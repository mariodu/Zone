#ecoding: utf-8
module ApplicationHelper
  def display_notice_and_alert
    return send(flash[:special]) if flash[:special]
    msg = ''
    msg << (content_tag :div, notice, :class => "notice") if notice
    msg << (content_tag :div, alert, :class => "alert alert-block alert-error fade in") if alert
    sanitize msg
  end

  def flash_consummate_info
    contents_tag :div, :class => "alert alert-success" do |c|
      c << content_tag(:button, 'X', :class => 'close', 'data-dismiss' => "alert")
      c << content_tag(:h4, t('user.renren_authentication_success'), :class => 'alert-heading')
      c << content_tag(:p, t('user.consummate_info'))
      c << contents_tag(:p) do |pc|
        pc << link_to(t('do_right_now'),'#', :class => 'btn btn-primary')
      end
    end
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
