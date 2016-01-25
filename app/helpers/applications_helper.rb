module ApplicationsHelper
	def format_field(type,value)
      display = "No Response"
	  case  type
	  when :boolean
	  	display = t(value.to_s) unless value.nil?
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

	def reset_database
		Application.all.each{|a| a.destroy}
		Reference.all.each{|r| r.destroy }
		Score.all.each{|s| s.destroy }
		User.with_role(:student).each{|u| u.destroy }
		puts "Done. Don't forget to update the application date ENV['DEADLINE']"
	end

end
