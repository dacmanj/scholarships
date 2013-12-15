#app/inputs/collection_check_boxes_input.rb
class CollectionCheckBoxesInput < SimpleForm::Inputs::CollectionCheckBoxesInput
  def input_html
	super.push("checkbox-inline")
  end
end
