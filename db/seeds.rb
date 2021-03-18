# User.create(email: 'user@mail.ru', password: 'password')
brand = Whisky::Brand.find_or_create_by(name: 'Nikka', country: 'Japan')
brand.whiskies.find_or_create_by(title: 'From the barrel',
                                 description: 'Japanese whiskey')
brand.whiskies.find_or_create_by(title: 'Coffey grain',
                                 description: 'Japanese whiskey')
brand.whiskies.find_or_create_by(title: '12 years blended',
                                 description: 'Japanese whiskey')
