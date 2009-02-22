class AddLocaleToProduct < ActiveRecord::Migration
  def self.up
    add_column :products, :locale, :string
  end

  def self.down
    remove_column :products, :locale
  end
end
