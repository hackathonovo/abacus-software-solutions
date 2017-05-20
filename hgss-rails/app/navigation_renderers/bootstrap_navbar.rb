include ActionView::Helpers::TagHelper

class BootstrapNavbar < SimpleNavigation::Renderer::Base

  def render(item_container)
    is_subnavigation = options[:is_subnavigation]
    
    list_content = item_container.items.inject([]) do |list, item|
      includes_sub_navigation = include_sub_navigation?(item)

      items_content = link_tag_for(item, is_subnavigation)

      # Append to list contents the sub navigation items.
      items_content << render_sub_navigation_for(item) if includes_sub_navigation

      # If's rendering a subnavigation.
      if is_subnavigation
        list << items_content

      # In case it's not rendering a subnavigation output a li element.
      else
        content_tag_classes = ["nav-item"]

        content_tag_classes << "dropdown" if includes_sub_navigation

        content_tag_classes << "active" if item.selected?

        list << content_tag(:li, items_content, :class => content_tag_classes)
      end
    end.join

    if is_subnavigation
      content_tag(:div, list_content, :class => "dropdown-menu dropdown-menu-right")
    else
      content_tag(:ul, list_content, :class => "navbar-nav")
    end
  end

  def render_sub_navigation_for(item)
    item.sub_navigation.render(self.options.merge(:is_subnavigation => true))
  end

  protected

  def link_tag_for(item, is_subnavigation)
    is_static_text = item.url.nil?

    if is_static_text
      content_tag(:span, item.name, options_for_link_tag(item, is_subnavigation))
    else
      link_to(item.name, item.url, options_for_link_tag(item, is_subnavigation))
    end
  end

  def options_for_link_tag(item, is_subnavigation)
    includes_sub_navigation = include_sub_navigation?(item)
    
    options = {:class => classes_for_link_tag(item, is_subnavigation), :method => item.method}

    if includes_sub_navigation
      options[:"data-toggle"] = "dropdown"
    end

    options
  end

  def classes_for_link_tag(item, is_subnavigation)
    includes_sub_navigation = include_sub_navigation?(item)

    classes = [item.html_options[:class]] || []

    if is_subnavigation
      classes << "dropdown-item"

      classes << "active" if item.selected?
    else
      classes << ["nav-link"]
    end

    classes << "dropdown-toggle" if includes_sub_navigation

    classes.join " "
  end
end

SimpleNavigation.register_renderer my_renderer: BootstrapNavbar