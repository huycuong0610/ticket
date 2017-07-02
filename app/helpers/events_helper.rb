module EventsHelper
  def header_background_image_url
   image_path('color-me-run.jpg')
  end

  def edit_button(event)
    if can_edit?(event)
      link_to('Edit', edit_event_path(event), class: 'btn btn-primary btn-lg btn-block')
    end
  end

  def can_edit?(event)
    authenticated? && event.admins.ids.include?(current_user.id)
  end
end
