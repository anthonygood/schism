# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

names = %w[
	Masayuki\ Watanabe
	Anthony\ Good
	Wis\ Amarasinghe
	Masatomo\ Nakano
	Seth\ Jeffery
	Omar\ Sahyoun
	Joseph\ Ganderson
	Takuya\ Homma
	Yosuke\ Arakaki
	Kazuyuki\ Honda
	Akifumi\ Yokoi
	Yuki\ Miyauchi
	Flavio\ Zanda
	Roxana\ Rudareanu
	Takeshi\ Ugajin
	Kensuke\ Nagae
	Kohei\ Hasegawa
	Daisuke\ Fujimura
	Takeshi\ Sasaki
	Koutaro\ Chikuba
	Yusuke\ Kaneko
	Matthew\ Platts
	Mai\ Ueno
	Tomoko\ Matsukawa
	Eri\ Nishihara
	Akalpa\ Acharya
	Ryan\ Guerrero
	Yuta\ Funase
	Keisuke\ Kawase
	Bianca\ Esmero
	Satoru\ Tanabe
	Kati\ Vorobjova
]

names.each do |person|
  email = person.downcase.split[0] << "@quipper.com"
  TeamMember.new( :name => person, :email => email ).save
end

TeamMember.find_by_name("Masatomo Nakano").update_attribute(:email, "tomo@quipper.com")
TeamMember.find_by_name("Masayuki Watanabe").update_attribute(:email, "masa@quipper.com")

team_portraits = ["Akalpa Acharya.png", "Akifumi Yokoi.png", "Anthony Good.jpg", "Bianca Esmero.png", "Daisuke Fujimura.png", "Eri Nishihara.png", "Flavio Zanda.png", "Joseph Ganderson.JPG", "Kazuyuki Honda.png", "Keisuke Kawase.png", "Kensuke Nagae.png", "Kohei Hasegawa.png", "Koutaro Chikuba.png", "Mai Ueno.png", "Masatomo Nakano.jpg", "Masayuki Watanabe.jpg", "Matthew Platts.png", "Omar Sahyoun.png","Roxana Rudareanu.png", "Ryan Guerrero.png", "Seth Jeffery.png", "Takeshi Sasaki.png", "Takeshi Ugajin.png", "Takuya Homma.png", "Tomoko Matsukawa.png", "Wis Amarasinghe.jpg", "Yosuke Arakaki.png", "Yuki Miyauchi.png", "Yusuke Kaneko.png", "Yuta Funase.png", "Satoru Tanabe.jpg", "Kati Vorobjova.png" ]

team_portraits.each do |image_name|
  person_name = image_name.split(".")[0]
  # find the person in the TeamMember table
  this_person = TeamMember.find_by_name( person_name )
  
  # set their image path
  this_person.image_path = image_name
  this_person.save
end