# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)




mobile_brands = ["Nokia", "OnePlus", "Apple", "Samsung", "Oppo", "Redmi", "Motorola", "Huawei", "Sony", "LG"]

mobile_brands.each do |brand_name|
	Brand.create(name: brand_name)
end

rams = [1,2,3,4,5,6,7,8,9,10]
internal_storage = [16, 32, 64, 128, 256]
external_storage = [128, 256]
years = [2014,2015,2016,2017,2018]

series = ['A', 'B', 'C', 'D', 'E', 'F', 'G', 'I', 'L', 'V']


model = []
brands = Brand.all
brands.each_with_index do |brand, index|
	i = 1
	years.each do |y|
		external_storage.each do |ex_storage|
			internal_storage.each do |in_storage|
				rams.each do |r|
					model = series[index] + i.to_s
					price = 10000 * i
					Product.create(name: (mobile_brands[index]+" "+series[index]+i.to_s), model: model, brand_id: brand.id, ram: r, year: y, external_storage: ex_storage, internal_storage: in_storage, price: price)
					i += 1
				end
			end
		end
	end
end

