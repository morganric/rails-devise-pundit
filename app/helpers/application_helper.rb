module ApplicationHelper

  def display_base_errors resource
    return '' if (resource.errors.empty?) or (resource.errors[:base].empty?)
    messages = resource.errors[:base].map { |msg| content_tag(:p, msg) }.join
    html = <<-HTML
    <div class="alert alert-error alert-block">
      <button type="button" class="close" data-dismiss="alert">&#215;</button>
      #{messages}
    </div>
    HTML
    html.html_safe
  end


    def meta_keywords(tags = nil)
      if tags.present?
        content_for :meta_keywords, tags
      else
        content_for?(:meta_keywords) ? [content_for(:meta_keywords), ENV['meta_keywords']].join(', ') : ENV['meta_keywords']
      end
    end

    def meta_description(desc = nil)
      if desc.present?
        content_for :meta_description, desc
      else
        content_for?(:meta_description) ? content_for(:meta_description) : ENV['meta_description']
      end
    end
end
