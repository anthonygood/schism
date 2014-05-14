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