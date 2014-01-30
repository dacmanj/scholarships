class ResizeEssayField < ActiveRecord::Migration
def up
    change_column :applications, :essay, :text
end
def down
    # This might cause trouble if you have strings longer
    # than 255 characters.
    change_column :applications, :essay, :string
end
end
