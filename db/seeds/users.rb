unless User.exists?(email: "admin@admin.com.br")
  user = User.new(:name=>"Administrador", :email=>"admin@admin.com.br", :password=>"admin1234", :role => :admin)
  user.save
end

unless User.exists?(email: "loly.net.app@gmail.com")
  user = User.new(:name=>"Loly", :email=>"loly.net.app@gmail.com", :password=>"informacao", :role => :admin)
  user.save
end

unless User.exists?(email: "juliana.loly.net@gmail.com")
  user = User.new(:name=>"Juliana", :email=>"juliana.loly.net@gmail.com", :password=>"juliana05", :role => :admin)
  user.save
end

unless User.exists?(email: "nazareth.loly.net@gmail.com")
  user = User.new(:name=>"Nazareth", :email=>"nazareth.loly.net@gmail.com", :password=>"bailarina", :role => :admin)
  user.save
end

unless User.exists?(email: "celso.loly.net@gmail.com")
  user = User.new(:name=>"Celso", :email=>"celso.loly.net@gmail.com", :password=>"951753ce", :role => :admin)
  user.save
end

unless User.exists?(email: "dolores.loly.net@gmail.com")
  user = User.new(:name=>"Dolores", :email=>"dolores.loly.net@gmail.com", :password=>"saoroque", :role => :admin)
  user.save
end