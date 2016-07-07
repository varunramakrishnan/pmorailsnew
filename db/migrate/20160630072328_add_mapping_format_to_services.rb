class AddMappingFormatToServices < ActiveRecord::Migration
  def change
  	add_column :services, :mapping_format, :string
  end
end
