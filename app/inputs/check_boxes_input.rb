#app/inputs/check_boxes_input.rb
class CheckBoxesInput < SimpleForm::Inputs::CheckBoxesInput
  def item_wrapper_class
    "checkbox-inline"
  end
end
