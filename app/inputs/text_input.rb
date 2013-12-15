class TextInput < SimpleForm::Inputs::TextInput

  def input
  	input_html_options[:rows] = input_html_options[:rows] || 4
  	input_html_options[:cols] = input_html_options[:cols] || 20
    @builder.text_area(attribute_name, input_html_options)
  end
end
