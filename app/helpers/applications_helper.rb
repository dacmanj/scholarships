module ApplicationsHelper
	def format_field(type,value)
      display = ""
	  case  type
	  when :boolean
	  	display = t value
	  when :text
	  	display = "<div class='well'>" + value.html_safe + "</div>"
	  	display = display.html_safe
	  when :string
	  	display = value.html_safe unless value.blank?
	  when :date
	    display = l value
	  when :datetime
	  	display = l value
	  when :transcript
		display = (link_to "Open Transcript in New Window", @application.transcript.url, :target => "_BLANK").html_safe
	  when :reference
		display = (link_to "Open Reference in New Window", reference_path(value), :target => "_BLANK").html_safe unless value.blank?
	  else
	  	display = value
      end

    display
	end

end
