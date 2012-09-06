module FlashHelper
  def flash_complete_info
    contents_tag :div, :class => "alert alert-success" do |c|
      c << content_tag(:button, 'X', :class => 'close', 'data-dismiss' => "alert")
      c << content_tag(:h4, t('user.renren_authentication_success'), :class => 'alert-heading')
      c << content_tag(:p, t('user.complete_info_description'))
      c << contents_tag(:p) do |pc|
        pc << link_to(t('do_right_now'), users_complete_info_path, :class => 'btn btn-primary')
      end
    end
  end
end