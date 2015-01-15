 # This file should contain all the record creation needed to seed the database with its default values.

# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


# Criar organizacoes de exemplo
mrcc = Organization.create(:name => "MRCC", :country => "Portugal", :creator_org =>"ADMIN", :creator_country => "Portugal")
comar = Organization.create(:name => "COMAR", :country => "Portugal", :creator_org =>"ADMIN", :creator_country => "Portugal")
mrccn = Organization.create(:name => "MRCC", :country => "Nigeria", :creator_org =>"ADMIN", :creator_country => "Portugal")
inem = Organization.create(:name => "INEM", :country => "Brazil", :creator_org =>"ADMIN", :creator_country => "Portugal")
orgadmin = Organization.create(:name => "ADMIN", :country => "Portugal", :creator_org =>"ADMIN", :creator_country => "Portugal")

# Criar administrador
  user = CreateAdminService.new.call
  user.name = "Admin"
  user.organization = orgadmin
  user.clearance = :Secret
  user.role = :admin
  user.save!

# Criar utilizadores de exemplo


diogo = User.find_or_create_by!(email: 'diogo@example.com') do |user|
  user.name = "Diogo Monica"
  user.organization = comar
  user.clearance = :Secret
  user.role = :p3
  user.password = 'change'
  user.password_confirmation = 'change'
  user.confirm!
end

nuno = User.find_or_create_by!(email: 'nuno@example.com') do |user|
  user.name = "Nuno Monica"
  user.organization = mrcc
  user.clearance = :Private
  user.role = :p2
  user.password = 'change'
  user.password_confirmation = 'change'
  user.confirm!
end

paulo = User.find_or_create_by!(email: 'paulo@example.com') do |user|
  user.name = "Paulo Monica"
  user.organization = mrccn
  user.password = 'change'
  user.password_confirmation = 'change'
  user.confirm!
end

adilson = User.find_or_create_by!(email: 'adilson@example.com') do |user|
  user.name = "Adilson Fagundes"
  user.organization = inem
  user.clearance = :Secret
  user.role = :p3
  user.password = 'change'
  user.password_confirmation = 'change'
  user.confirm!
end

ladmin = User.find_or_create_by!(email: 'ladmin@example.com') do |user|
  user.name = "Local Admin"
  user.organization = comar
  user.clearance = :Secret
  user.role = :p4
  user.password = 'change'
  user.password_confirmation = 'change'
  user.confirm!
end


# Criar situacoes de exemplo
primeira = Situation.create(:user => adilson, :organization => adilson.organization, :name => "Homem ao mar", :description => "Este e um evento nacional que esta relacionado com a potencial existencia de um naufrago que caiu ao mar no brazil", :level => :Local, :sensitivity => :Public)
segunda = Situation.create(:user => diogo, :organization => diogo.organization, :name => "Poluicao no guincho", :description => "Este que esta relacionado com a potencial existencia de poluiacao no Guincho. Coitadinhas das focas.", :level => :National, :sensitivity => :Public)
terceira = Situation.create(:user => diogo, :organization => diogo.organization, :name => "Homicidio no guincho", :description => "Este e um evento Internacional que esta relacionado com um potencial homicidio no guincho", :level => :National, :sensitivity => :Private)
quarta = Situation.create(:user => diogo, :organization => diogo.organization, :name => "Terrorismo no guincho", :level => :International, :sensitivity => :Secret)
quinta = Situation.create(:user => diogo, :organization => diogo.organization, :name => "Navio Empanado", :level => :International, :sensitivity => :Private)
sexta = Situation.create(:user => diogo, :organization => diogo.organization, :name => "Navio Afundado", :level => :National, :sensitivity => :Secret)
setima = Situation.create(:user => diogo, :organization => diogo.organization, :name => "Apanha de ostras", :level => :Local, :sensitivity => :Private)

# Criar participacoes de exemplo
primeira.organizations << [inem]
segunda.organizations << [comar, mrcc]
terceira.organizations << [mrcc, comar]
quarta.organizations << [mrccn, comar]
quinta.organizations << [mrccn, inem, comar]
sexta.organizations << [comar]
setima.organizations << [mrcc, comar]


# Criar events
evento1 = Event.create(:user => diogo, :organization => diogo.organization, situation: primeira, sensitivity: :Public, level: :Local, title: "O homem caiu ao mar na figueira da foz")
evento2 = Event.create(:user => diogo, :organization => diogo.organization, situation: primeira, sensitivity: :Secret, level: :Local, title: "O morto foi identificado")

evento3 = Event.create(:user => diogo, :organization => diogo.organization, situation: terceira, sensitivity: :Public, level: :International, decision: true, title: "Homem matou outro na praca")
evento4 = Event.create(:user => diogo, :organization => diogo.organization, situation: terceira, sensitivity: :Private, level: :National, title: "Encontrada a arma do crime")

evento5 = Event.create(:user => diogo, :organization => diogo.organization, situation: quarta, sensitivity: :Secret, level: :Local, title: "Foi encontrada uma bomba na praca. A razao pela qual ela não rebentou não é, de momento, conhecida. Há quem diga que não recentou porque, sendo uma bomba de ar manual, daquelas de dar ao pedal, e não estando lá niguém a pedalar, dificilmente aquilo poderia ter criado pressão para rebentar. Mas o facto é, que, honestamente, não sabemos")

# Criar comments

c = Comment.create(:body => "O homem tinha uma tshirt vermelha", :event => evento1, :user => diogo, :organization => diogo.organization, sensitivity: :Public, level: :Local)
c = Comment.create(:body => "O homem tinha uma mulher feiosa", :event => evento1, :user => diogo, :organization => diogo.organization, :sensitivity => :Secret, level: :Local)

c = Comment.create(:body => "O homem matou o outro com uma faca, embora ninguém a tenha visto. Aliás, há bastantes dúvidas de que a faca fosse mesmo uma faca, e não apenas um 
                            corta-unhas que o criminoso tinha. É certo que, sendo o homicida um gajo com umas u
                            nhas enormes, o corta-unhas não podia ser pequeno. Mas crime é crime, bolas.", :event => evento3, :user => diogo, :organization => diogo.organization, sensitivity: :Public, level: :Local)
c = Comment.create(:body => "A faca tinha 30 Cms", :event => evento4, :user => diogo, :organization => diogo.organization, sensitivity: :Private, level: :National)
c = Comment.create(:body => "A faca tinha um cabo metalico", :event => evento4, :user => diogo, :organization => diogo.organization, sensitivity: :Public, level: :National)
c = Comment.create(:body => "A faca tinha era afiada", :event => evento4, :user => diogo, :organization => diogo.organization, sensitivity: :Public, level: :Local)


c = Comment.create(:body => "A bomba era amarela", :event => evento5, :user => diogo, :organization => diogo.organization, sensitivity: :Public, level: :International)
