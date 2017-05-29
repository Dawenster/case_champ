module ApplicationHelper

  def icon_for_file(filename)
    file_format = filename.split(".").last.downcase
    file_icon = case file_format
    when "ppt", "pptx"
      "<i class='file-icon fa fa-file-powerpoint-o'></i>"
    when "xls", "xlsx"
      "<i class='file-icon fa fa-file-excel-o'></i>"
    when "doc", "docx"
      "<i class='file-icon fa fa-file-word-o'></i>"
    when "pdf"
      "<i class='file-icon fa fa-file-pdf-o'></i>"
    else
      "<i class='file-icon fa fa-file-o'></i>"
    end
    file_icon.html_safe
  end

end
