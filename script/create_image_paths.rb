team_portraits = ["Akalpa Acharya.png", "Akifumi Yokoi.png", "Anthony Good.jpg", "Bianca Esmero.png", "Daisuke Fujimura.png", "Eri Nishihara.png", "Flavio Zanda.png", "Joseph Ganderson.JPG", "Kazuyuki Honda.png", "Keisuke Kawase.png", "Kensuke Nagae.png", "Kohei Hasegawa.png", "Koutaro Chikuba.png", "Mai Ueno.png", "Masatomo Nakano.jpg", "Masayuki Watanabe.jpg", "Matthew Platts.png", "Omar Sahyoun.png","Roxana Rudareanu.png", "Ryan Guerrero.png", "Seth Jeffery.png", "Takeshi Sasaki.png", "Takeshi Ugajin.png", "Takuya Homma.png", "Tomoko Matsukawa.png", "Wis Amarasinghe.jpg", "Yosuke Arakaki.png", "Yuki Miyauchi.png", "Yusuke Kaneko.png", "Yuta Funase.png", "Satoru Tanabe.jpg", "Kati Vorobjova.png" ]

team_portraits.each do |image_name|
  person_name = image_name.split(".")[0]
  # find the person in the TeamMember table
  this_person = TeamMember.find_by_name( person_name )
  
  # set their image path
  this_person.image_path = image_name
  this_person.save
end
  
