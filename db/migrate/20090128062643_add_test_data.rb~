class AddTestData < ActiveRecord::Migration
  def self.up
    Product.delete_all
    Product.create(:title => 'entry 1',
      :description => 'description 1',
      :image_url => 'image1.jpg',
      :price => 10000)
    Product.create(:title => 'entry 2',
      :description => 'description 2',
      :image_url => 'image2.png',
      :price => 123)
    Product.create(:title => 'entry 3',
      :description => 'description 3',
      :image_url => 'image3.gif',
      :price => 29)
  end

  def self.down
    Product.delete_all
  end
end
