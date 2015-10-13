module ApplicationHelper

  #Page titles
  def tab_title( page_title = '' )
    if page_title.empty?
      Rails.application.config.blog_title
    else
      page_title + " | " + Rails.application.config.blog_title
    end
  end

end
