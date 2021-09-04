module ApplicationHelper
  def gravatar_for(user, options = {size: 80})
    email_address = user.email.downcase
    hash = Digest::MD5.hexdigest(email_address)
    size = options[:size]
    gravatar_url = "https://www.gravatar.com/avatar/#{hash}?s=#{size}"
    image_tag(gravatar_url, alt: user.username, class: "rounded shadow mx-auto d-block")
  end

  def page_navigation_links(pages, param_name=:page)
    will_paginate(pages, :params => {:anchor => ".search-top"}, :class => 'pagination', :inner_window => 2, :outer_window => 0, :renderer => BootstrapHelper::LinkRenderer, 
    :previous_label => '&larr;'.html_safe, :next_label => '&rarr;'.html_safe, :param_name => param_name)
  end
end
