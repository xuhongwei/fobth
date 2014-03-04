module ApplicationHelper

  # home and product controller use their own js files
  def javascript(*files)
    content_for(:javascripts) { javascript_include_tag(*files) }
  end

  #render nested comments
  def nested_comments(comments)
    comments_html = ""
    comments.each do |comment|
      if comment.has_children?
        comments_html << (render(comment) + content_tag(:ul, nested_comments(comment.children), :class => "children"))
      else
        comments_html << render(comment)
      end
    end
    return comments_html.html_safe
  end

  # get user's avatar_url
  def avatar_url(user)
    gravatar_id = Digest::MD5::hexdigest(user.email).downcase
    "http://gravatar.com/avatar/#{gravatar_id}.png"
  end

  #render left_menu
  def left_menu(categories)
    menu_html = ""
    pages = {
      "Home" => root_path,
      "Products" => products_path,
      "About Us" => news_index_path,
      "Contact Us" => contact_index_path
    }
    pages.map do |key, value|
      classnames = get_class_names(value)
      # products render sub_menu
      if key == "Products"
        menu_html << "<li#{classnames}>#{link_to(key, value)}#{sub_menu(categories)}</li>"
      else
        menu_html << "<li#{classnames}>#{link_to(key, value)}</li>"
      end
    end
    menu_html.html_safe
  end

  def sub_menu(categories)
    sub_menu_html = ""
    if !categories.blank?
      sub_menu_html = "<ul class=\"sub-menu\">"
      for category in categories
        classnames = get_class_names(category_products_path(category))
        sub_menu_html << "<li#{classnames}>#{link_to(category.name, category_products_path(category))}</li>"
      end
      sub_menu_html << "</ul>"
    end
    sub_menu_html
  end

  private
  def get_class_names(url)
    classnames = %( class="menu-item")
    classnames = %( class="menu-item current-menu-item") if current_page?(url)
  end
end
