module ApplicationHelper
  # icons!
  def zurb_icon name, tooltip=""
    # manage special cases: we map standard names to specific icons
    # others are managed literally
    icon_name = case name
                when 'Show'      then "fi-eye"
                when 'Duplicate' then "fi-camera"
                when 'Edit'      then "fi-pencil"
                when 'Destroy'   then "fi-x"
                else name
                end
    icon_tooltip = tooltip != "" ? tooltip : name

    "<i id='#{name}' data-tooltip data-options='disable_for_touch:true' title='#{icon_tooltip}' class='#{icon_name}'></i>".html_safe
  end
end
