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
	Takeyoshi\ Mizusawa
	Yuki\ Naotori
]

names.each do |person|
  email = person.downcase.split[0] << "@quipper.com"
  TeamMember.new( :name => person, :email => email ).save
end

TeamMember.find_by_name("Masatomo Nakano").update_attribute(:email, "tomo@quipper.com")
TeamMember.find_by_name("Masayuki Watanabe").update_attribute(:email, "masa@quipper.com")
TeamMember.find_by_name("Takeyoshi Mizusawa").update_attribute(:email, "take@quipper.com")
TeamMember.find_by_name("Matthew Platts").update_attribute(:email, "matt@quipper.com")

team_portraits = ["Akalpa Acharya.png", "Akifumi Yokoi.png", "Anthony Good.jpg", "Bianca Esmero.png", "Daisuke Fujimura.png", "Eri Nishihara.png", "Flavio Zanda.png", "Joseph Ganderson.JPG", "Kazuyuki Honda.png", "Keisuke Kawase.png", "Kensuke Nagae.png", "Kohei Hasegawa.png", "Koutaro Chikuba.png", "Mai Ueno.png", "Masatomo Nakano.jpg", "Masayuki Watanabe.jpg", "Matthew Platts.png", "Omar Sahyoun.png","Roxana Rudareanu.png", "Ryan Guerrero.png", "Seth Jeffery.png", "Takeshi Sasaki.png", "Takeshi Ugajin.png", "Takuya Homma.png", "Tomoko Matsukawa.png", "Wis Amarasinghe.jpg", "Yosuke Arakaki.png", "Yuki Miyauchi.png", "Yusuke Kaneko.png", "Yuta Funase.png", "Satoru Tanabe.jpg", "Kati Vorobjova.png", "Takeyoshi Mizusawa.png", "Yuki Naotori.png" ]

team_portraits.each do |image_name|
  person_name = image_name.split(".")[0]
  # find the person in the TeamMember table
  this_person = TeamMember.find_by_name( person_name )
  
  # set their image path
  this_person.image_path = image_name
  this_person.save
end

questions = [
	#"Who would alienate themselves and others?",
	#"Who would kill for love?",
	"Who would win at ping pong?",
	"Who would win at fussball?",
	"Who would score a penalty?",
	#"Who would start their own business?",
	"Who would sell themselves to the highest bidder?",
	"Who would sneeze without covering their mouth?",
	#"Who would conduct their affairs in secret?",
	#"Who would destroy something beautiful?",
	#"Who would build a better house?",
	#"Who would surprise themselves the most?",
	#"Who would wish you a happy birthday?",
	"Who would give money to a tramp?",
	#"Who would speak loudly in quiet surroundings?",
	#"Who would ponder life's hidden meaning?",
	"Who would run a marathon?",
	"Who would win in a battle to the death?",
	"Who would get a tattoo?",
	"Who would get inappropriately drunk?",
	#"Who would wake up in unfamiliar surroundings?",
	"Who would slay the dragon?",
	#"Who would bite off more than they could chew?",
	"Who would start a revolution?",
	#"Who would vote Conservative?",
	#"Who would vote Labour?",
	"Who would blame others for their own farts?",
	"Who would live fast and die young?",
	#"Who would swear on their mother's life?",
	#"Who would lie through their teeth?",
	"Who would paint a crap picture?",
	"Who would compose a reasonably good symphony?",
	#"Who would delude themselves?",
	"Who would travel the world?",
	#"Who would unmask Batman?",
	"Who would live amongst the animals?",
	#"Who would bark in anger?",
	"Who would bark in fear?",
	"Who would best control their bladder?",
	#"Who would defeat their inner demons?",
	"Who would do better at maths?",
	"Who would sing surprisingly well?",
	"Who would be seduced by their own reflection?",
	#"Who would travel the world and be disappointed by it?",
	"Who would survive the apocalypse?",
	"Who would shoot you if you turned into a zombie?",
	#"Who would sign a pact with the devil?",
	"Who would spend ages looking for their keys, only to find them in their pocket?",
	"Who would react badly to losing their phone?",
	#"Who would ask a silly question?",
	#"Who would declare a bold truth?",
	#"Who would give you the finger?",
	"Who would mutter under their breath?",
	"Who would brew their tea longest?",
	"Who would take their coffee black?",
	"Who would enjoy a trashy novel?",
	"Who would listen to bad pop?",
	"Who would go to an art gallery and actually enjoy it?",
	#"Who would buy an expensive sandwich?",
	#"Who would wear expensive clothes?",
	"Who would pay for lunch?",
	"Who would tip handsomely?",
	#"Who would decide the matter outright?",
	#"Who would laugh in the other's face?",
	#"Who would be content in themselves?",
	"Who would turn the other cheek?",
	#"Who would fight with grave violence?",
	#"Who would go berserk?",
	#"Who would triumph in adversity?",
	#"Who would own the means of production?",
	#"Who would play the piano?",
]

questions.each do |q|
  Question.new( :text => q ).save
end