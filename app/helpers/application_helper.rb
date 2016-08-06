module ApplicationHelper
  def auth_token
    "<input type='hidden'
            name='authenticity_token'
            value='#{form_authenticity_token}'>".html_safe
  end

  def short(string)
    return string if string.length < 20
    "#{string[0..17]}...".html_safe
  end

  def valid_view?

  end
end
