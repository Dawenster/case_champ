module ApplicationHelper

  def add_leading_spaces(string)
    "&nbsp;&nbsp;#{string}".html_safe
  end

end
