module FormHelper
  def form_text_field(form, field_name, options = {})
    label_text   = options[:label_text] || t("#{form.object.model_type}.#{field_name}")
    helper_block = options[:helper_block]
    input_class  = options[:input_class]
    placeholder  = options[:placeholder] || field_name.to_s.titleize

    contents_tag :div, :class => 'control-group' do |c|
      c <<  form.label(field_name, label_text, :class => 'control-label')
      c <<  contents_tag(:div, :class => 'controls') do |c2|
        c2 << form.text_field(field_name, :placeholder => placeholder, :class => input_class)
        c2 << content_tag(:span, helper_block, :class => 'help-block') if helper_block
      end
    end
  end

  def form_uneditable_text_field(form, field_name, options = {})
    label_text   = options[:label_text] || t("#{form.object.model_type}.#{field_name}")

    contents_tag :div, :class => 'control-group' do |c|
      c <<  form.label(field_name, label_text, :class => 'control-label')
      c <<  contents_tag(:div, :class => 'controls') do |c2|
        c2 << content_tag(:span, form.object.send(field_name), :class => 'input-xlarge uneditable-input')
      end
    end
  end

  def form_check_box(form, field_name, options = {})
    label_text   = options[:label_text] || t("#{form.object.model_type}.#{field_name}")

    contents_tag :div, :class => 'control-group' do |c|
      c <<  form.label(field_name, label_text, :class => 'control-label')
      c <<  contents_tag(:div, :class => 'controls') do |c2|
        c2 << form.check_box(field_name)
      end
    end
  end

  def form_select(form, field_name, options = {})
    label_text     = options[:label_text] || t("#{form.object.model_type}.#{field_name}")
    select_options = options[:select_options]
    include_blank  = options[:include_blank] || false
    contents_tag :div, :class => 'control-group' do |c|
      c <<  form.label(field_name, label_text, :class => 'control-label')
      c <<  contents_tag(:div, :class => 'controls') do |c2|
        c2 << form.select(field_name, select_options, {:include_blank => include_blank})
      end
    end
  end

  def form_password_field(form, field_name, options = {})
    label_text   = options[:label_text] || t("#{form.object.model_type}.#{field_name}")
    helper_block = options[:helper_block]
    input_class  = options[:input_class]
    placeholder  = options[:placeholder] || field_name.to_s.titleize

    contents_tag :div, :class => 'control-group' do |c|
      c <<  form.label(field_name, label_text, :class => 'control-label')
      c <<  contents_tag(:div, :class => 'controls') do |c2|
        c2 << form.password_field(field_name, :placeholder => placeholder, :class => input_class)
        c2 << content_tag(:span, helper_block, :class => 'help-block') if helper_block
      end
    end
  end

  def form_submit(form, text)
    contents_tag :div, :class => 'form-actions' do |c|
      c <<  form.submit(text, :class => 'btn btn-primary')
    end
  end
end