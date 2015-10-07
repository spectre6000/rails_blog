module ApplicationHelper

  #Page titles
  def tab_title(page_title = '')
    blog_title = "Blognamehere"
    if page_title.empty?
      blog_title
    else
      page_title + " | " + blog_title
    end
  end

end
