module ApplicationsHelper
	def format_field(type,value)
      display = "No Response"
	  case  type
	  when :boolean
	  	display = t value unless value.blank?
	  when :text
	  	display = "<div class='well'>" + (value || "") + "</div>" unless value.blank?
	  	display = display.html_safe
	  when :string
	  	display = value.html_safe unless value.blank?
	  when :date
	    display = l value
	  when :datetime
	  	display = l value
	  when :transcript
		display = (link_to "Open Transcript", @application.transcript.url, :target => "_BLANK").html_safe unless value.blank?
	  else
	  	display = value
      end

    display
	end

end
