 # This file should contain all the record creation needed to seed the database with its default values.

# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

orgadmin = Organization.new
orgadmin.name = "ADMIN"
orgadmin.country = "Portugal"
orgadmin.active = true
orgadmin.organization =orgadmin
orgadmin.save

# Criar organizacoes de exemplo
mrcc = Organization.new
mrcc.name = "MRCC"
mrcc.country = "Portugal"
mrcc.active = true
mrcc.organization =orgadmin
mrcc.save

comar = Organization.new
comar.name = "COMAR"
comar.country = "Portugal"
comar.active = true
comar.organization =orgadmin
comar.save

mrccn = Organization.new
mrccn.name ="MRCC"
mrccn.country = "Nigeria"
mrccn.active = true
mrccn.organization =orgadmin
mrccn.save

inem = Organization.new
inem.name = "INEM"
inem.country = "Brazil"
inem.active = true
inem.organization =orgadmin
inem.save



# Criar administrador
  user = CreateAdminService.new.call
  user.name = "Admin"
  user.organization = orgadmin 
  user.clearance = :Secret
  user.role = :admin
  user.save!


# Criar utilizadores de exemplo


  diogo = User.new
  diogo.email= "diogo@example.com"
  diogo.name = "Diogo Monica"
  diogo.organization = comar
  diogo.clearance = :Secret
  diogo.role = :p3
  diogo.password = 'change'
  diogo.password_confirmation = 'change'
  diogo.confirm!

  nuno = User.new
  nuno.email= "nuno@example.com"
  nuno.name = "Nuno Monica"
  nuno.organization = mrcc
  nuno.clearance = :Private
  nuno.role = :p2
  nuno.password = 'change'
  nuno.password_confirmation = 'change'
  nuno.confirm!

  paulo = User.new
  paulo.email=  "paulo@example.com"
  paulo.name = "Paulo Monica"
  paulo.organization = mrccn
  paulo.clearance = :Public
  paulo.role = :p1
  paulo.password = 'change'
  paulo.password_confirmation = 'change'
  paulo.confirm!


  adilson = User.new
  adilson.email= "adilson@example.com"
  adilson.name = "Adilson Fagundes"
  adilson.organization = inem
  adilson.clearance = :Secret
  adilson.role = :p3
  adilson.password = 'change'
  adilson.password_confirmation = 'change'
  adilson.confirm!


  ladmin = User.new
  ladmin.email="ladmin@example.com"
  ladmin.name = "Local Admin"
  ladmin.organization = comar
  ladmin.clearance = :Secret
  ladmin.role = :p4
  ladmin.password = 'change'
  ladmin.password_confirmation = 'change'
  ladmin.confirm!


# Criar situacoes de exemplo
primeira = Situation.new
primeira.user = adilson
primeira.organization = adilson.organization
primeira.name = "Homem ao mar"
primeira.description = "Este e um evento nacional que esta relacionado com a potencial existencia de um naufrago que caiu ao mar no brazil"
primeira.level = "Local"
primeira.sensitivity = "Public"
primeira.save


segunda = Situation.new
segunda.user = diogo
segunda.organization = diogo.organization
segunda.name = "Poluicao no guincho"
segunda.description = "Este que esta relacionado com a potencial existencia de poluiacao no Guincho. Coitadinhas das focas."
segunda.level = "National"
segunda.sensitivity = "Public"
segunda.save

terceira=Situation.new
terceira.user = diogo
terceira.organization = diogo.organization
terceira.name = "Homicidio no guincho"
terceira.level = "National"
terceira.sensitivity = "Private"
terceira.save

quarta = Situation.new
quarta.user = diogo
quarta.organization = diogo.organization
quarta.name = "Terrorismo no guincho"
quarta.level = "International"
quarta.sensitivity = "Secret"
quarta.save

quinta = Situation.new
quinta.user = diogo
quinta.organization = diogo.organization
quinta.name = "Navio Empanado"
quinta.level = "International"
quinta.sensitivity = "Private"
quinta.save

sexta = Situation.new
sexta.user = diogo
sexta.organization = diogo.organization
sexta.name = "Navio Afundado"
sexta.level = "National"
sexta.sensitivity = "Secret"
sexta.save

setima = Situation.new
setima.user = diogo
setima.organization = diogo.organization
setima.name = "Apanha de ostras"
setima.level = "Local"
setima.sensitivity = "Private"
setima.save

# Criar participacoes de exemplo
primeira.organizations << [inem]
segunda.organizations << [comar, mrcc]
terceira.organizations << [mrcc, comar]
quarta.organizations << [mrccn, comar]
quinta.organizations << [mrccn, inem, comar]
sexta.organizations << [comar]
setima.organizations << [mrcc, comar]


# Criar events
e1 = Event.new
e1.user = diogo
e1.organization = diogo.organization
e1.situation=primeira
e1.sensitivity="Public"
e1.level="Local"
e1.title= "O homem caiu ao mar na figueira da foz"
e1.save

e2 = Event.new
e2.user = diogo
e2.organization = diogo.organization
e2.situation= primeira
e2.sensitivity="Secret"
e2.level="Local"
e2.title= "O morto foi identificado"
e2.save

e3 = Event.new
e3.user = diogo
e3.organization = diogo.organization
e3.situation= terceira
e3.sensitivity="Public"
e3.level="International"
e3.decision=true
e3.title= "Homem matou outro na praca"
e3.save

e4 = Event.new
e4.user = diogo
e4.organization = diogo.organization
e4.situation= terceira
e4.sensitivity="Private"
e4.level="National"
e4.title= "Encontrada a arma do crime"
e4.save

e5 = Event.new
e5.user = diogo
e5.organization = diogo.organization
e5.situation= quarta
e5.sensitivity="Secret"
e5.level="Local"
e5.title= "Foi encontrada uma bomba na praca. A razao pela qual ela não rebentou não é, de momento, conhecida. Há quem diga que não recentou porque, sendo uma bomba de ar manual, daquelas de dar ao pedal, e não estando lá niguém a pedalar, dificilmente aquilo poderia ter criado pressão para rebentar. Mas o facto é, que, honestamente, não sabemos"
e5.save

# Criar comments

c1 = Comment.new
c1.body = "O homem tinha uma tshirt vermelha"
c1.event = e1
c1.user = diogo
c1.organization = diogo.organization
c1.sensitivity="Public"
c1.level="Local"
c1.save

c2 = Comment.new
c2.body = "O homem tinha uma mulher feiosa"
c2.event = e1
c2.user = diogo
c2.organization = diogo.organization
c2.sensitivity = "Secret"
c2.level="Local"
c2.save

c3 = Comment.new
c3.body = "O homem matou o outro com uma faca, embora ninguém a tenha visto. Aliás, há bastantes dúvidas de que a faca fosse mesmo uma faca, e não apenas um corta-unhas que o criminoso tinha. É certo que, sendo o homicida um gajo com umas unhas enormes, o corta-unhas não podia ser pequeno. Mas crime é crime, bolas."
c3.event = e3
c3.user = diogo
c3.organization = diogo.organization
c3.sensitivity="Public"
c3.level="Local"
c3.save

c4 = Comment.new
c4.body = "A faca tinha 30 Cms"
c4.event = e4
c4.user = diogo
c4.organization = diogo.organization
c4.sensitivity="Private"
c4.level="National"
c4.save

c5 = Comment.new
c5.body = "A faca tinha um cabo metalico"
c5.event = e4
c5.user = diogo
c5.organization = diogo.organization
c5.sensitivity="Public"
c5.level="National"
c5.save

c6 = Comment.new
c6.body = "A faca tinha era afiada"
c6.event = e4
c6.user = diogo
c6.organization = diogo.organization
c6.sensitivity="Public"
c6.level="Local"
c6.save


c7 = Comment.new
c7.body = "A bomba era amarela"
c7.event = e5
c7.user = diogo
c7.organization = diogo.organization
c7.sensitivity="Public"
c7.level="International"
c7.save
