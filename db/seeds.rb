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

statuses = Status.create!([
  { name: 'setup' },
  { name: 'retired' },
  { name: 'broken' },
  { name: 'inservice' }
])

datacenters = Datacenter.create!([
  { name: 'va1', vendor: 'Unitas', provider: 'Unitas' },
  { name: 'tor', vendor: 'Peer1', provider: 'Peer1' },
  { name: 'use', vendor: 'Amazon', provider: 'Amazon' }
])

operating_systems = OperatingSystem.create!([
  { name: 'CentOS 7' },
  { name: 'Windows2012 R2'},
  { name: 'Windows2016'}

])

nodes = Node.create!([
  {
    name: 'tor-ns1.tor.adsrvr.org', fqdn: 'tor-ns1.tor.adsrvr.org',
    status_id: 1, datacenter_id: 1, operating_system_id: 1
  },
  {
    name: 'tor-ns2.tor.adsrvr.org', fqdn: 'tor-ns2.tor.adsrvr.org',
    status_id: 1, datacenter_id: 1, operating_system_id: 1
  },
  {
    name: 'tor-bid001.ops.adsrvr.org', fqdn: 'tor-bid001.ops.adsrvr.org',
    status_id: 4, datacenter_id: 2, operating_system_id: 3
  }
])

