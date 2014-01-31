module ApplicationsHelper
	def format_field(type,value)
      display = ""
	  case  type
	  when :boolean
	  	display = t value
	  when :text
	  	display = "<div class='well'>" + (value || "") + "</div>"
	  	display = display.html_safe
	  when :string
	  	display = value.html_safe unless value.blank?
	  when :date
	    display = l value
	  when :datetime
	  	display = l value
	  when :transcript
		display = (link_to "Open Transcript", @application.transcript.url, :target => "_BLANK").html_safe
	  else
	  	display = value
      end

    display
	end

end
