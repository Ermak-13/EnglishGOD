module ApplicationHelper
  def flash_html()
    converter = {
      alert: 'alert-danger',
      notice: 'alert-success'
    }

    flash_html = ''
    flash.each do |key, msg|
      html_class = converter[key] or 'alert-info'
      flash_html += %Q(<div class="alert #{html_class}">#{msg}</div>)
    end

    flash_html.html_safe
  end
end
