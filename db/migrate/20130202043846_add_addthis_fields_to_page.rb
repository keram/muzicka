class AddAddthisFieldsToPage < ActiveRecord::Migration
  def self.up
    add_column :refinery_pages, :addthis_url, :string
    add_column :refinery_pages, :addthis_title, :string
    add_column :refinery_pages, :addthis_description, :string
  end

  def self.down
    remove_column :refinery_pages, :addthis_url
    remove_column :refinery_pages, :addthis_title
    remove_column :refinery_pages, :addthis_description
  end
end
