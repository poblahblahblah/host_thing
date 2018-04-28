# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Node.destroy_all
Status.destroy_all
OperatingSystem.destroy_all
Datacenter.destroy_all
Role.destroy_all
SoftwareApp.destroy_all

statuses = Status.create!([
  { name: 'setup' },
  { name: 'retired' },
  { name: 'broken' },
  { name: 'inservice' }
])

datacenters = Datacenter.create!([
  { name: 'va1', vendor: 'HostFolks', provider: 'CoreSite' },
  { name: 'tor', vendor: 'EdgeHost', provider: 'XO Communications' },
  { name: 'use', vendor: 'Amazon', provider: 'Amazon' }
])

operating_systems = OperatingSystem.create!([
  { name: 'CentOS 7' },
  { name: 'Windows2012 R2'},
  { name: 'Windows2016'}
])

roles = Role.create!([
  { name: 'Bitter' },
  { name: 'Dataserver' },
  { name: 'dns-slave' },
  { name: 'FactServ' }
])

software_apps = SoftwareApp.create!([
  { name: 'Bitter', roles: [Role.first] },
  { name: 'Dataserver', roles: [Role.second] },
  { name: 'LogCollector', roles: [Role.first, Role.second] },
  { name: 'BitterCache', roles: [Role.first] }
])

nodes = Node.create!([
  {
    name: 'tor-ns1', fqdn: 'tor-ns1.tor.example.org', status_id: 1, datacenter_id: 1, roles: [Role.fourth],
    operating_system_id: 1
  },
  {
    name: 'tor-ns2', fqdn: 'tor-ns2.tor.example.org', status_id: 1, datacenter_id: 1, roles: [Role.fourth],
    operating_system_id: 1
  },
  {
    name: 'tor-bit001', fqdn: 'tor-bit001.ops.example.org', status_id: 4, datacenter_id: 2, roles: [Role.first],
    operating_system_id: 3
  },
  {
    name: 'tor-bit002', fqdn: 'tor-bit002.ops.example.org', status_id: 4, datacenter_id: 2, roles: [Role.first],
    operating_system_id: 3
  },
  {
    name: 'va1-combo001', fqdn: 'va1-combo001.ops.example.org', status_id: 4, datacenter_id: 1, roles: [Role.first, Role.second],
    operating_system_id: 3
  },
])
