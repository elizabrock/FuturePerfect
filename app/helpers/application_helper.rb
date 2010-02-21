module ApplicationHelper
  
  def iphone_error_messages_for(f)
    message = f.error_messages :header_tag => 'span', :header_message => raw("<span class='header'>There was a problem:</span>"), :message => ''
    unless message.blank?
      contents = content_tag(:li, message, :class => 'textbox')
      content_tag(:ul, contents, :class => 'pageitem')
    end
  end
end
