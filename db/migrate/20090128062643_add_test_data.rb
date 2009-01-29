class AddTestData < ActiveRecord::Migration
  def self.up
    Product.delete_all
    Product.create(:title => 'entry 1',
      :description => 'description 1',
      :image_url => 'http://tbn0.google.com/images?q=tbn:b61MH5BWNmOEhM:http://animals.nationalgeographic.com/staticfiles/NGS/Shared/StaticFiles/animals/images/primary/black-spider-monkey.jpg',
      :price => 10000)
    Product.create(:title => 'entry 2',
      :description => 'description 2',
      :image_url => 'http://tbn1.google.com/images?q=tbn:LjKR9X0hZiylyM:http://upload.wikimedia.org/wikipedia/commons/2/27/Baby_ginger_monkey.jpg',
      :price => 123)
    Product.create(:title => 'entry 3',
      :description => 'description 3',
      :image_url => 'http://tbn3.google.com/images?q=tbn:eXffCiAav0Q4IM:http://img.dailymail.co.uk/i/pix/2007/07_02/SpectacledMonkeyR_468x477.jpg',
      :price => 29)
  end

  def self.down
    Product.delete_all
  end
end
