namespace :dev do
  
  task fake_product: :environment do
    Product.destroy_all

    100.times do |i|
      Product.create!(
        name: FFaker::Name.first_name,
        description: FFaker::Lorem.paragraph,
        price: [10,15,20,50,100].sample,
        remote_image_url: FFaker::Avatar.image  
      )
    end
    puts "have created fake products"
    puts "now you have #{Product.count} products data"
  end
end