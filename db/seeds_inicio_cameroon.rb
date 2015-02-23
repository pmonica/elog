 # This file should contain all the record creation needed to seed the database with its default values.

# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


# Criar organizacoes de exemplo
orgadmin = Organization.create(:name => "ADMIN", :active => true, :country => "International")
orgadmin.organization =orgadmin
o1 = Organization.create(:name => "Org 1", :active => true, :country => "Nigeria", :organization => orgadmin)
o2 = Organization.create(:name => "Org 2", :active => true, :country => "Nigeria", :organization => orgadmin)
o3 = Organization.create(:name => "Org 3", :active => true, :country => "Nigeria", :organization => orgadmin)
o4 = Organization.create(:name => "Org 4", :active => true, :country => "Cameroon", :organization => orgadmin)
o5 = Organization.create(:name => "Org 5", :active => true, :country => "Cameroon", :organization => orgadmin)
o6 = Organization.create(:name => "Org 6", :active => true, :country => "Regional", :organization => orgadmin)
o7 = Organization.create(:name => "RED CROSS", :active => true, :country => "Nigeria", :organization => orgadmin)
#comar = Organization.create(:name => "COMAR", :country => "Portugal", :organization => orgadmin)


# Criar administrador
  user = CreateAdminService.new.call
  user.name = "Admin"
  user.organization = orgadmin
  user.clearance = :Secret
  user.role = :admin
  user.save!

# Criar utilizadores de exemplo

u101 = User.find_or_create_by!(email: 'u101@example.com') do |user|
  user.name = "User 101"
  user.organization = o1
  user.clearance = :Secret
  user.role = :p4
  user.password = 'change'
  user.password_confirmation = 'change'
  user.confirm!
end

u102 = User.find_or_create_by!(email: 'u102@example.com') do |user|
  user.name = "User 102"
  user.organization = o1
  user.clearance = :Secret
  user.role = :p3
  user.password = 'change'
  user.password_confirmation = 'change'
  user.confirm!
end

u103 = User.find_or_create_by!(email: 'u103@example.com') do |user|
  user.name = "User 103"
  user.organization = o1
  user.clearance = :Secret
  user.role = :p2
  user.password = 'change'
  user.password_confirmation = 'change'
  user.confirm!
end

u104 = User.find_or_create_by!(email: 'u104@example.com') do |user|
  user.name = "User 104"
  user.organization = o1
  user.clearance = :Private
  user.role = :p2
  user.password = 'change'
  user.password_confirmation = 'change'
  user.confirm!
end

u105 = User.find_or_create_by!(email: 'u105@example.com') do |user|
  user.name = "User 105"
  user.organization = o1
  user.clearance = :Private
  user.role = :p2
  user.password = 'change'
  user.password_confirmation = 'change'
  user.confirm!
end

u106 = User.find_or_create_by!(email: 'u106@example.com') do |user|
  user.name = "User 106"
  user.organization = o1
  user.clearance = :Public
  user.role = :p1
  user.password = 'change'
  user.password_confirmation = 'change'
  user.confirm!
end

u107 = User.find_or_create_by!(email: 'u107@example.com') do |user|
  user.name = "User 107"
  user.organization = o1
  user.clearance = :Public
  user.role = :p1
  user.password = 'change'
  user.password_confirmation = 'change'
  user.confirm!
end

u108 = User.find_or_create_by!(email: 'u108@example.com') do |user|
  user.name = "User 108"
  user.organization = o1
  user.clearance = :Public
  user.role = :p0
  user.password = 'change'
  user.password_confirmation = 'change'
  user.confirm!
end

u201 = User.find_or_create_by!(email: 'u201@example.com') do |user|
  user.name = "User 201"
  user.organization = o2
  user.clearance = :Secret
  user.role = :p3
  user.password = 'change'
  user.password_confirmation = 'change'
  user.confirm!
end

u202 = User.find_or_create_by!(email: 'u202@example.com') do |user|
  user.name = "User 202"
  user.organization = o2
  user.clearance = :Secret
  user.role = :p2
  user.password = 'change'
  user.password_confirmation = 'change'
  user.confirm!
end

u203 = User.find_or_create_by!(email: 'u203@example.com') do |user|
  user.name = "User 203"
  user.organization = o2
  user.clearance = :Private
  user.role = :p2
  user.password = 'change'
  user.password_confirmation = 'change'
  user.confirm!
end

u204 = User.find_or_create_by!(email: 'u204@example.com') do |user|
  user.name = "User 204"
  user.organization = o2
  user.clearance = :Private
  user.role = :p1
  user.password = 'change'
  user.password_confirmation = 'change'
  user.confirm!
end

u205 = User.find_or_create_by!(email: 'u205@example.com') do |user|
  user.name = "User 205"
  user.organization = o2
  user.clearance = :Private
  user.role = :p1
  user.password = 'change'
  user.password_confirmation = 'change'
  user.confirm!
end

u206 = User.find_or_create_by!(email: 'u206@example.com') do |user|
  user.name = "User 206"
  user.organization = o2
  user.clearance = :Public
  user.role = :p1
  user.password = 'change'
  user.password_confirmation = 'change'
  user.confirm!
end

u301 = User.find_or_create_by!(email: 'u301@example.com') do |user|
  user.name = "User 301"
  user.organization = o3
  user.clearance = :Private
  user.role = :p4
  user.password = 'change'
  user.password_confirmation = 'change'
  user.confirm!
end

u302 = User.find_or_create_by!(email: 'u302@example.com') do |user|
  user.name = "User 302"
  user.organization = o3
  user.clearance = :Secret
  user.role = :p3
  user.password = 'change'
  user.password_confirmation = 'change'
  user.confirm!
end

u303 = User.find_or_create_by!(email: 'u303@example.com') do |user|
  user.name = "User 303"
  user.organization = o3
  user.clearance = :Public
  user.role = :p2
  user.password = 'change'
  user.password_confirmation = 'change'
  user.confirm!
end

u304 = User.find_or_create_by!(email: 'u304@example.com') do |user|
  user.name = "User 304"
  user.organization = o3
  user.clearance = :Private
  user.role = :p1
  user.password = 'change'
  user.password_confirmation = 'change'
  user.confirm!
end

u305 = User.find_or_create_by!(email: 'u305@example.com') do |user|
  user.name = "User 305"
  user.organization = o3
  user.clearance = :Public
  user.role = :p1
  user.password = 'change'
  user.password_confirmation = 'change'
  user.confirm!
end

u401 = User.find_or_create_by!(email: 'u401@example.com') do |user|
  user.name = "User 401"
  user.organization = o4
  user.clearance = :Secret
  user.role = :p4
  user.password = 'change'
  user.password_confirmation = 'change'
  user.confirm!
end

u402 = User.find_or_create_by!(email: 'u402@example.com') do |user|
  user.name = "User 402"
  user.organization = o4
  user.clearance = :Secret
  user.role = :p3
  user.password = 'change'
  user.password_confirmation = 'change'
  user.confirm!
end

u403 = User.find_or_create_by!(email: 'u403@example.com') do |user|
  user.name = "User 403"
  user.organization = o4
  user.clearance = :Private
  user.role = :p3
  user.password = 'change'
  user.password_confirmation = 'change'
  user.confirm!
end

u404 = User.find_or_create_by!(email: 'u404@example.com') do |user|
  user.name = "User 404"
  user.organization = o4
  user.clearance = :Public
  user.role = :p2
  user.password = 'change'
  user.password_confirmation = 'change'
  user.confirm!
end

u405 = User.find_or_create_by!(email: 'u405@example.com') do |user|
  user.name = "User 405"
  user.organization = o4
  user.clearance = :Secret
  user.role = :p1
  user.password = 'change'
  user.password_confirmation = 'change'
  user.confirm!
end

u501 = User.find_or_create_by!(email: 'u501@example.com') do |user|
  user.name = "User 501"
  user.organization = o5
  user.clearance = :Secret
  user.role = :p4
  user.password = 'change'
  user.password_confirmation = 'change'
  user.confirm!
end

u502 = User.find_or_create_by!(email: 'u502@example.com') do |user|
  user.name = "User 502"
  user.organization = o5
  user.clearance = :Public
  user.role = :p3
  user.password = 'change'
  user.password_confirmation = 'change'
  user.confirm!
end

u503 = User.find_or_create_by!(email: 'u503@example.com') do |user|
  user.name = "User 503"
  user.organization = o5
  user.clearance = :Private
  user.role = :p2
  user.password = 'change'
  user.password_confirmation = 'change'
  user.confirm!
end

u504 = User.find_or_create_by!(email: 'u504@example.com') do |user|
  user.name = "User 504"
  user.organization = o5
  user.clearance = :Public
  user.role = :p1
  user.password = 'change'
  user.password_confirmation = 'change'
  user.confirm!
end

u505 = User.find_or_create_by!(email: 'u505@example.com') do |user|
  user.name = "User 505"
  user.organization = o5
  user.clearance = :Public
  user.role = :p1
  user.password = 'change'
  user.password_confirmation = 'change'
  user.confirm!
end

u601 = User.find_or_create_by!(email: 'u601@example.com') do |user|
  user.name = "User 601"
  user.organization = o6
  user.clearance = :Public
  user.role = :p4
  user.password = 'change'
  user.password_confirmation = 'change'
  user.confirm!
end

u602 = User.find_or_create_by!(email: 'u602@example.com') do |user|
  user.name = "User 602"
  user.organization = o6
  user.clearance = :Secret
  user.role = :p3
  user.password = 'change'
  user.password_confirmation = 'change'
  user.confirm!
end

u603 = User.find_or_create_by!(email: 'u603@example.com') do |user|
  user.name = "User 603"
  user.organization = o6
  user.clearance = :Secret
  user.role = :p2
  user.password = 'change'
  user.password_confirmation = 'change'
  user.confirm!
end

u604 = User.find_or_create_by!(email: 'u604@example.com') do |user|
  user.name = "User 604"
  user.organization = o6
  user.clearance = :Private
  user.role = :p1
  user.password = 'change'
  user.password_confirmation = 'change'
  user.confirm!
end

u607 = User.find_or_create_by!(email: 'qwertyui_REDCROSS_Nigeria@nodomain.com') do |user|
  user.name = "qwertyui_REDCROSS_Nigeria"
  user.organization = o7
  user.clearance = :Private
  user.role = :p1
  user.password = 'qwertyui'
  user.password_confirmation = 'qwertyui'
  user.confirm!
end

# Create situations for example
first = Situation.create(:user => u102, :organization => u102.organization, :name => "Routine Situation", :description => "Daily Working logbook. Events not pertaining to a particular Situation", :level => :Local, :sensitivity => :Public)
second = Situation.create(:user => u201, :organization => u201.organization, :name => "Routine Situation", :description => "Daily Working logbook. Events not pertaining to a particular Situation", :level => :Local, :sensitivity => :Public)
third = Situation.create(:user => u302, :organization => u302.organization, :name => "Routine Situation", :description => "Daily Working logbook. Events not pertaining to a particular Situation", :level => :Local, :sensitivity => :Public)
fourth = Situation.create(:user => u402, :organization => u402.organization, :name => "Routine Situation", :description => "Daily Working logbook Events not pertaining to a particular Situation", :level => :Local, :sensitivity => :Public)
fifth = Situation.create(:user => u502, :organization => u502.organization, :name => "Routine Situation", :description => "Daily Working logbook. Events not pertaining to a particular Situation", :level => :Local, :sensitivity => :Public)
sixth = Situation.create(:user => u602, :organization => u602.organization, :name => "Routine Situation", :description => "Daily Working logbook. Events not pertaining to a particular Situation", :level => :International, :sensitivity => :Private)
seventh = Situation.create(:user => u102, :organization => u102.organization, :name => "MC 1/15 - SAR - Explosion and fire on board M/V SIRIUS ", :description => "At xxxx master reports explosion on board followed by uncontrolled fire. There are 200 people on board. Pos:LAT/LONG, 10 miles away from coast. M/V Capella is in vicinities, less then 3 miles, and is going to assist", :level => :National, :sensitivity => :Private)
eight = Situation.create(:user => u302, :organization => u302.organization, :name => "MC 1/15 - PIRACY - M/V ALDEBARAN under attack", :description => "At yyyy master reports being under shooting, position LAT, LONG by 8 unidentified armed men approaching fast in two RIB. A crew member was already hit. AIS confirms position. Last week there were 2 attacks in the same area", :level => :National, :sensitivity => :Private)
ninth = Situation.create(:user => u502, :organization => u502.organization, :name => "MC 8/15 - SAR/POLLUTION - Collision at sea M/V POLUX and F/V CASTOR" , :description => "Collision at zzzz, position LAT, LONG in EEZ waters, 4 miles away from Nigerian EEZ waters. No injured people reported on board any vessel. M/V POLUX reports hull damage with an uncontrolled oil spill to the sea", :level => :International, :sensitivity => :Private)
tenth = Situation.create(:user => u201, :organization => u201.organization, :name => "MC 2/15 - SAR - M/V RIGEL aground on South Beach", :description => "F/V RIGEL ran aground on the South Beach at 15/01/2015, Green City, 2 miles east of the Breakwater Lighthouse, due to rough seas", :level => :National, :sensitivity => :Public)
eleventh = Situation.create(:user => u602, :organization => u602.organization, :name => "MC 1/15 - SECURITY - Interception of COI M/V SUSPICIOUS" , :description => "Follow up and interception of COI M/V SUSPICIOUS; Reported to have terrorists and biological weapons on board", :level => :International, :sensitivity => :Secret)
twelfth = Situation.create(:user => u101, :organization => u101.organization, :name => "OP 1/15 - FISHERY LAW ENFORCEMENT - Area BRAVO" , :description => "Fishery control operation in area Bravo", :level => :Local, :sensitivity => :Private)
thirteenth = Situation.create(:user => u102, :organization => u102.organization, :name => "RS 1/15 - M/V VEGA permission to anchor" , :description => "M/V VEGA, Senegal Flag, requests permission to anchor at Sea Port Outer anchorage for a small engine damage repair. ETR 2 hours. No assistance required", :level => :Local, :sensitivity => :Private)


# Create participations for example
first.organizations << [o1]
second.organizations << [o2]
third.organizations << [o3]
fourth.organizations << [o4]
fifth.organizations << [o5]
sixth.organizations << [o6]
seventh.organizations << [o1, o2]
eight.organizations << [o3, o2, o1]
ninth.organizations << [o5, o1, o2, o3, o4]
tenth.organizations << [o2, o1]
eleventh.organizations << [o6, o4, o2, o1]
twelfth.organizations << [o1]
thirteenth.organizations << [o1]

# Create events for example
#event1 = Event.create(:user => u102, :organization => user102.organization, situation: first, sensitivity: :Public, level: :Local, title: "Good VHF comm's with the Master;There are 8 people on board. No injured reported")
#event1 = Event.create(:user => u105, situation: first, sensitivity: :Public, level: :Local, title: "Weather update")

#SITUATION 1: u102/L/P - E1 U105/N/P (C1-2-3 u105/N/P/I)
e1 = Event.new
e1.user = u105
e1.organization = u105.organization
e1.situation = first
e1.sensitivity = "Public"
e1.level = "National"
e1.title= "Weather update"
e1.save

e2 = Event.new
e2.user = u105
e2.organization = u105.organization
e2.situation = first
e2.sensitivity = "Public"
e2.level = "Local"
e2.title = "Weather update resent to the TG 123 naval forces conducting the exercise Deep See in EEZ"
e2.save

#SITUATION 1: u102/L/P - E2 U105/L/P (C4-5 u105/L/P)
e3 = Event.new
e3.user = u105
e3.organization = u105.organization
e3.situation = first
e3.sensitivity = "Public"
e3.level = "Local"
e3.title = "M/V VEGA requests permission to anchor at Sea Port Outer anchorage for a small engine damage repair. ETR 2 hours. No assistance required"
e3.save

e4 = Event.new
e4.user = u102
e4.organization = u102.organization
e4.situation = first
e4.sensitivity = "Public"
e4.level = "Local"
e4.decision = true
e4.title = "M/V VEGA request for permission to anchor becomes a particular Situation: RS 1/15"
e4.save

e5 = Event.new
e5.user = u102
e5.organization = u102.organization
e5.situation = thirteenth
e5.sensitivity = "Public"
e5.level = "International"
e5.decision = true
e5.title = "Situation RS 1/15 M/V VEGA permission to anchor created as Private, Local. Participating organizations: Org 1 - Nigeria"
e5.save

e6 = Event.new
e6.user = u105
e6.organization = u105.organization
e6.situation = thirteenth
e6.sensitivity = "Public"
e6.level = "International"
e6.title = "Master informs that left from Mindelo 7 days ago with final destination Douala. Sea agent in Nigeria is Mr Alexis Ungund, from Sea Entreprise"
e6.save

e7 = Event.new
e7.user = u105
e7.organization = u105.organization
e7.situation = thirteenth
e7.sensitivity = "Public"
e7.level = "International"
e7.title = "Master informs that all he needs are small electrical repairs, without any sea pollution arising, and that there are no limitations on the engine's command and control system"
e7.save

e8 = Event.new
e8.user = u105
e8.organization = u105.organization
e8.situation = thirteenth
e8.sensitivity = "Public"
e8.level = "International"
e8.title = "Ship agent to send a written request for the anchorage permission explaining in detail the repairs to be done and the existing limitations on conducting and manoeuvring the ship. Also, copies of the documentation of the ship must be sent."
e8.save

e9= Event.new
e9.user = u105
e9.organization = u105.organization
e9.situation = thirteenth
e9.sensitivity = "Public"
e9.level = "National"
e9.title = "COMTEL with Mindelo Port State Autorithy: M/V Vega was visited by Mindelo Port State Authority before leaving the harbour without any limitation to report"
e9.save

#SITUATION 1: u102/L - E3 u102/L(C6-u105/L;C7-8 u103/I/N)
e10 = Event.new
e10.user = u102
e10.organization = u102.organization
e10.situation = thirteenth
e10.sensitivity = "Public"
e10.level = "Local"
e10.decision = true
e10.title = "M/V VEGA authorized to proceed to Sea Port Outer Anchorage"
e10.save

e11 = Event.new
e11.user = u102
e11.organization = u102.organization
e11.situation = thirteenth
e11.sensitivity = "Public"
e11.level = "National"
e11.title = "A consolidated report of the situation was sent to the National Port State Authority"
e11.save

#SITUATION 1: u102/L/ - E4 u105/I/P (C9 u105/N)
e12 = Event.new
e12.user = u105
e12.organization = u105.organization
e12.situation = first
e12.sensitivity = "Public"
e12.level = "International"
e12.title = "M/V ALTAIR reports a big yellow floating navigation mark adrif on positition LAT, LONG, 22 miles away from the coast"
e12.save

#SITUATION 1: u102/L/ - E4 u102/I/
e13 = Event.new
e13.user = u102
e13.organization = u102.organization
e13.situation = first
e13.sensitivity = "Public"
e13.level = "International"
e13.decision = true
e13.title = "Navigational Warning promulgated, reporting the yellow floating navigational mark adrift"
e13.save

e14 = Event.new
e14.user = u105
e14.organization = u105.organization
e14.situation = first
e14.sensitivity = "Public"
e14.level = "Local"
e14.title = "VHF MAYDAY received. M/V SIRIUS reports explosion on board followed by fire; Fire is uncontrolled; Position LAT, LONG; 200 people on board. Two injured people"
e14.save

e15 = Event.new
e15.user = u105
e15.organization = u105.organization
e15.situation = first
e15.sensitivity = "Public"
e15.level = "Local"
e15.title = "M/V CAPELLA reports a passenger ship on fire, 3 miles SW from her own position LAT, LONG. M/V CAPELLA is going to render assistance"
e15.save

e16 = Event.new
e16.user = u102
e16.organization = u102.organization
e16.situation = first
e16.sensitivity = "Public"
e16.level = "National"
e16.decision = true
e16.title = "M/V SIRIUS MC situation becomes MC 1/15 situation, National, Private. Emergency Phase declared"
e16.save

e17 = Event.new
e17.user = u104
e17.organization = u104.organization
e17.situation = first
e17.sensitivity = "Public"
e17.level = "National"
e17.title = "Personnel reinforcement and readiness assets increased"
e17.save


e18 = Event.new
e18.user = u102
e18.organization = u102.organization
e18.situation = first
e18.sensitivity = "Public"
e18.level = "National"
e18.decision = true
e18.title = " XXX designated as DC."
e18.save

e19 = Event.new
e19.user = u102
e19.organization = u102.organization
e19.situation = first
e19.sensitivity = "Public"
e19.level = "National"
e19.decision = true
e19.title = "Crisis Posture in force - level 2"
e19.save

#SITUATION SEVENTH
e20 = Event.new
e20.user = u102
e20.organization = u102.organization
e20.situation = seventh
e20.sensitivity = "Public"
e20.level = "National"
e20.decision = true
e20.title = "Situation MC 1/15 - SAR - Explosion and fire on board M/V SIRIUS created as Private, National. Participating organizations: Org 1 - Nigeria, Org 2 - Nigeria"
e20.save

e21 = Event.new
e21.user = u104
e21.organization = u104.organization
e21.situation = seventh
e21.sensitivity = "Public"
e21.level = "National"
e21.title = "Provision of information concerning involved ship details and contacts"
e21.save

e22 = Event.new
e22.user = u104
e22.organization = u104.organization
e22.situation = seventh
e22.sensitivity = "Private"
e22.level = "National"
e22.title = "Provision of available information concerning relevant precedent movements/happennings of M/V SIRIs"
e22.save

e23 = Event.new
e23.user = u102
e23.organization = u102.organization
e23.situation = seventh
e23.sensitivity = "Public"
e23.level = "National"
e23.decision = true
e23.title = "PB SHARK (Patrolling Boat unit at sea) ordered to proceed at maximum available speed to the distress area and Commander will assume OCS. SITREP on arrival and then after every 2 hours at least "
e23.save

e24 = Event.new
e24.user = u104
e24.organization = u104.organization
e24.situation = seventh
e24.sensitivity = "Public"
e24.level = "National"
e24.title = "COMTEL to SV Org2: SITREP on MC 1/15. Invitation to join ORG1 MC 1/15 situation - full access. Requesting availability of fire fighting assets, firefighters and damage control personnel."
e24.save

e25 = Event.new
e25.user = u202
e25.organization = u202.organization
e25.situation = second
e25.sensitivity = "Public"
e25.level = "Local"
e25.decision = true
e25.title = "COMTEL from OOD Org1, informing about the Crisis Situation of M/V SIRIUS (ORG 1 MC 1/15). Assets and manpower for fire fighting and damage control in a vessel at sea are requested. ORG 1 MC 1/15 situation eventlogger is open to access"
e25.save

e26 = Event.new
e26.user = u201
e26.organization = u201.organization
e26.situation = second
e26.sensitivity = "Public"
e26.level = "Local"
e26.decision = true
e26.title = "Emergency state declared"
e26.save

e27 = Event.new
e27.user = u201
e27.organization = u201.organization
e27.situation = second
e27.sensitivity = "Public"
e27.level = "Local"
e27.decision = true
e27.title = "Bolstering organization to Emergency Response Organization"
e27.save

e28 = Event.new
e28.user = u202
e28.organization = u202.organization
e28.situation = seventh
e28.sensitivity = "Public"
e28.level = "National"
e28.title = "Information on assets requested by Org 1 was provided: we have two tugs available with fire fighting on 10 minutes notice at commercial pier Calabar. Able to provide 3 teams of 10 firefighters. Plans from the distress vessel should be available for briefing"
e28.save

#SITUATION 8
e29 = Event.new
e29.user = u303
e29.organization = u303.organization
e29.situation = third
e29.sensitivity = "Public"
e29.level = "Local"
e29.title = "VHF MAYDAY received. M/V ALDEBARAN under pirate attack, position LAT, LONG. Two RIB approaching fast with unidentified armed men; several shots fired. A crew member was hit."
e29.save

e30 = Event.new
e30.user = u303
e30.organization = u303.organization
e30.situation = third
e30.sensitivity = "Public"
e30.level = "Local"
e30.title = "AIS confirms position of M/V ALDEBARAN. Panorama picture shows no other vessels in vicinity. Nearest vessel is M/V POLAR 11 miles away"
e30.save

e31 = Event.new
e31.user = u301
e31.organization = u301.organization
e31.situation = third
e31.sensitivity = "Public"
e31.level = "Local"
e31.decision = true
e31.title = "Emergency Phase declared. M/V ALDEBARAN situation becomes MC situation MC 1/15, National, Private"
e31.save

e32 = Event.new
e32.user = u301
e32.organization = u301.organization
e32.situation = third
e32.sensitivity = "Public"
e32.level = "National"
e32.decision = true
e32.title = "Crisis Posture in force - level 1"
e32.save

e33 = Event.new
e33.user = u301
e33.organization = u301.organization
e33.situation = eight
e33.sensitivity = "Private"
e33.level = "National"
e33.decision = true
e33.title = "Situation MC 1/15 - PIRACY - M/V ALDEBARAN under attack created as Private, National. Participating organizations: Org 1 - Nigeria, Org 2 - Nigeria, Org 3 - Nigeria"
e33.save

e34 = Event.new
e34.user = u301
e34.organization = u301.organization
e34.situation = eight
e34.sensitivity = "Private"
e34.level = "National"
e34.decision = true
e34.title = " YYY Designated as DC"
e34.save

e35 = Event.new
e35.user = u303
e35.organization = u303.organization
e35.situation = eight
e35.sensitivity = "Private"
e35.level = "National"
e35.title = "COMTEL to OOD Org 1 and Org 2, inviting them to join Org 3 MC 1/15"
e35.save

e36 = Event.new
e36.user = u105
e36.organization = u105.organization
e36.situation = first
e36.sensitivity = "Private"
e36.level = "Local"
e36.title = "COMTEL from OOD Org3, inviting us to join Crisis Situation ORG3 MC 1/15, Private, National"
e36.save

e37 = Event.new
e37.user = u203
e37.organization = u203.organization
e37.situation = second
e37.sensitivity = "Private"
e37.level = "Local"
e37.title = "COMTEL from OOD Org 3, inviting us to join Crisis Situation ORG 3 MC 1/15, Private, National"
e37.save

#SITUATION 5 - 9
#event12 = Event.create(:user => u105, situation: first, sensitivity: :Private, level: :Local, title: "VHF SECURITÉ received. M/V POLUX reports a colision with M/V Castor, position LAT, LONG in EZ waters, 4 miles away from Sao Tome and Principe EZ waters. No injured people reported on board, but resulting in an uncontrolled oil spill into the sea due to damages in the hull. M/V Castor reports no injured people and no damage.")
e38 = Event.new
e38.user = u503
e38.organization = u503.organization
e38.situation = fifth
e38.sensitivity = "Public"
e38.level = "Local"
e38.title = "VHF SECURITÉ received. M/V POLUX reports a collision with M/V Castor, position LAT, LONG. No injured people reported on board. M/V POLUX with hull damages resulting in an uncontrolled oil spill."
e38.save

e39 = Event.new
e39.user = u503
e39.organization = u503.organization
e39.situation = fifth
e39.sensitivity = "Public"
e39.level = "Local"
e39.title = "VHF SECURITÉ received. M/V Castor reports collision with M/V POLUX. No damage on board or injured people"
e39.save

e40 = Event.new
e40.user = u502
e40.organization = u502.organization
e40.situation = fifth
e40.sensitivity = "Public"
e40.level = "Local"
e40.decision = true
e40.title = "M/V POLUX and M/V Castor collision becomes MC 8/15 situation, International, Private. Emergency Phase declared"
e40.save

e41 = Event.new
e41.user = u502
e41.organization = u502.organization
e41.situation = fifth
e41.sensitivity = "Public"
e41.level = "National"
e41.decision = true
e41.title = "Crisis Posture in force - level 2"
e41.save

e42= Event.new
e42.user = u502
e42.organization = u502.organization
e42.situation = ninth
e42.sensitivity = "Private"
e42.level = "International"
e42.decision = true
e42.title = "Situation MC 8/15 - SAR/POLLUTION - Collision at sea M/V POLUX and F/V CASTOR created as Private, International. Participating organizations: Org 5 - Cameroon, Org 4 - Cameroon Org 1 - Nigeria, Org 2 - Nigeria, Org 3 - Nigeria"
e42.save

e43 = Event.new
e43.user = u502
e43.organization = u502.organization
e43.situation = ninth
e43.sensitivity = "Public"
e43.level = "International"
e43.decision = true
e43.title = " ZZZ Designated as DC"
e43.save

#SITUATION 2 - 10
e44 = Event.new
e44.user = u203
e44.organization = u203.organization
e44.situation = second
e44.sensitivity = "Public"
e44.level = "Local"
e44.title = "Air traffic controller informs that a red flare was sighted from a local operating commercial Cessna in the area of South Beach"
e44.save

e45 = Event.new
e45.user = u203
e45.organization = u203.organization
e45.situation = second
e45.sensitivity = "Public"
e45.level = "Local"
e45.title = "COMTEL reporting that the F/V RIGEL went aground on the South Beach, Green City, 2 miles east of the Breakwater Lighthouse, due to rough seas. All crew still on board (3 people); they are not able to leave the vessel due to sea conditions "
e45.save

e46 = Event.new
e46.user = u201
e46.organization = u201.organization
e46.situation = second
e46.sensitivity = "Public"
e46.level = "National"
e46.decision = true
e46.title = "M/V RIGEL grounding on South Beach becomes MC 2/15 situation, Public, National"
e46.save

e47= Event.new
e47.user = u201
e47.organization = u201.organization
e47.situation = tenth
e47.sensitivity = "Public"
e47.level = "Local"
e47.decision = true
e47.title = "Situation MC 2/15 - SAR - M/V RIGEL aground on South Beach created as Public, National. Participating organizations: Org 2 - Nigeria, Org 1 - Nigeria"
e47.save

e48= Event.new
e48.user = u203
e48.organization = u203.organization
e48.situation = tenth
e48.sensitivity = "Public"
e48.level = "Local"
e48.title = "Maritime police, and a team from Fire Department are underway by land. Lifeboat RIB is underway by sea"
e48.save

e49= Event.new
e49.user = u203
e49.organization = u203.organization
e49.situation = tenth
e49.sensitivity = "Public"
e49.level = "Local"
e49.title = "No COMMs with vessel"
e49.save

#SITUATION 11

e50= Event.new
e50.user = u602
e50.organization = u602.organization
e50.situation = eleventh
e50.sensitivity = "Secret"
e50.level = "International"
e50.decision = true
e50.title = "MC 1/15 - SECURITY - Interception of COI M/V SUSPICIOUS created as Secret, International. Participating organizations: Org 6 - Regional Center, Org 4 - Cameroon Org 1 - Nigeria, Org 2 - Nigeria"
e50.save

e51 = Event.new
e51.user = u602
e51.organization = u602.organization
e51.situation = eleventh
e51.sensitivity = "Secret"
e51.level = "International"
e51.title = "M/V SUSPICIOUS currently on pos LAT, LONG approaching from Cameroons' waters from the South"
e51.save

e52 = Event.new
e52.user = u602
e52.organization = u602.organization
e52.situation = eleventh
e52.sensitivity = "Secret"
e52.level = "International"
e52.title = "Satellite COMM's between M/V SUSPICIOUS and a well-known leader of terrorist training camps were intercepted. A rendezvous with another vessel will occur at high seas for transshipment of arms and illegal weapons"
e52.save

#SITUATION 1 - 12
e53= Event.new
e53.user = u102
e53.organization = u102.organization
e53.situation = twelfth
e53.sensitivity = "Private"
e53.level = "Local"
e53.title = "OP 1/15 - FISHERY LAW ENFORCEMENT - Area BRAVO"
e53.save

e54= Event.new
e54.user = u102
e54.organization = u102.organization
e54.situation = seventh
e54.sensitivity = "Private"
e54.level = "Local"
e54.decision = true
e54.title = "Created a temporary access to national org RED CROSS with view privileges, clearance private to this logger"
e54.save

e55= Event.new
e55.user = u102
e55.organization = u102.organization
e55.situation = seventh
e55.sensitivity = "Private"
e55.level = "Local"
e55.decision = true
e55.title = "RED CROSS invited to join situation"
e55.save

#e55= Event.new
#e55.user = u104
#e55.organization = u104.organization
#e55.situation = fifth
#e55.sensitivity = "Private"
#e55.level = "National"
#e55.title = "COMTEL to SV org RED CROSS: User name and access password to access sent by private email to redcrosspoerationalcenter@redcross.ng.com"
#e55.save

# Create comments for example
#c = Comment.create(:body => "XXXXXX", :event => event1, :user => u102, :organization => u102.organization, sensitivity: :Public, level: :Local)
#c = Comment.create(:body => "Under observation; to be updated in 20 minutes", :event => event2, :user => u105, :organization => u105.organization, sensitivity: :Public, level: :Local)

c1 = Comment.new
c1.body = "surface analysis at 0000Z file "
c1.event = e1
c1.user = u105
c1.organization = u105.organization
c1.sensitivity = "Public"
c1.level = "International"
c1.save

c2 = Comment.new
c2.body = "48 hours prognostic file "
c2.event = e1
c2.user = u105
c2.organization = u105.organization
c2.sensitivity = "Public"
c2.level = "International"
c2.save

c3 = Comment.new
c3.body = "Information received from METOC via mail "
c3.event = e1
c3.user = u105
c3.organization = u105.organization
c3.sensitivity = "Public"
c3.level = "Local"
c3.save

c4 = Comment.new
c4.body = "Position reported consistance with AIS information"
c4.event = e14
c4.user = u103
c4.organization = u103.organization
c4.sensitivity = "Public"
c4.level = "Local"
c4.save

c5 = Comment.new
c5.body = "Position observed is consistent with the position on the M/V SIRIUS distress signal"
c5.event = e15
c5.user = u103
c5.organization = u103.organization
c5.sensitivity = "Public"
c5.level = "Local"
c5.save

c6 = Comment.new
c6.body = "PB SHARK: ETA to scene of action 20 minutes"
c6.event = e23
c6.user = u104
c6.organization = u104.organization
c6.sensitivity = "Public"
c6.level = "National"
c6.save

c7 = Comment.new
c7.body = "Last week there were two similar attacks in the same area"
c7.event = e29
c7.user = u303
c7.organization = u303.organization
c7.sensitivity = "Private"
c7.level = "National"
c7.save

c8 = Comment.new
c8.body = "Position in EEZ waters, 4 miles away from Nigerian EEZ waters"
c8.event = e38
c8.user = u503
c8.organization = u503.organization
c8.sensitivity = "Public"
c8.level = "International"
c8.save

c9 = Comment.new
c9.body = "COMTEL from Assuy Botu, mobile phone +812323232, adress Boulevard Street 45, 3, Southwest Beach"
c9.event = e45
c9.user = u203
c9.organization = u203.organization
c9.sensitivity = "Public"
c9.level = "Local"
c9.save

c10 = Comment.new
c10.body = "Due to sea state near the grounding position, the lifeboat master will evaluate the risk of the approach by sea when in the area"
c10.event = e48
c10.user = u203
c10.organization = u203.organization
c10.sensitivity = "Public"
c10.level = "Local"
c10.save

c11 = Comment.new
c11.body = "M/V VEGA has Senegal Flag"
c11.event = e3
c11.user = u105
c11.organization = u105.organization
c11.sensitivity = "Public"
c11.level = "Local"
c11.save

c12 = Comment.new
c12.body = "M/V Sirius: source: AIS; 225 metres long passenger vessel belonging to AroundSeaWorld agency; Flag: Greek; Ship agent in Nigeria is Mr Alexis Undung, mobile phone +8111111111, commercial, business headquarters in Victory Square, 32-A, Southwest Bay"
c12.event = e21
c12.user = u105
c12.organization = u105.organization
c12.sensitivity = "Public"
c12.level = "National"
c12.save

c13 = Comment.new
c13.body = "M/V CAPELLA: source: Master of the vessel and AIS; M/V CAPELLA is a 120 metres long bulk carrier with a total crew of 8 men, National flag. It has no cargo on board and it can easily accommodate around 100 people if needed. However she has a 11 meters side hight and just one ladder to go onboard"
c13.event = e22
c13.user = u105
c13.organization = u105.organization
c13.sensitivity = "Public"
c13.level = "National"
c13.save

c14 = Comment.new
c14.body = "org RED CROSS; user name: qwertyui_REDCROSS_Nigeria; user email: qwertyui_REDCROSS_Nigeria@nodomain.com (for first validation and changeable)/ user password: qwertyui (for first validation and changeable)"
c14.event = e54
c14.user = u101
c14.organization = u105.organization
c14.sensitivity = "Secret"
c14.level = "Local"
c14.save

c15 = Comment.new
c15.body = "COMTEL to SV org RED CROSS: RED CROSS has read-only permission to access Situation logger; A temporary user name and access password was sent by email to redcrossoperationalcenter@redcross.ng.com"
c15.event = e55
c15.user = u104
c15.organization = u105.organization
c15.sensitivity = "Private"
c15.level = "National"
c15.save





