class CreateFriendlyIdSlugs < ActiveRecord::Migration[5.2]
  def change
    create_table :friendly_id_slugs do |t|
      t.string   :slug,           :null => false
      t.integer  :sluggable_id,   :null => false
      t.string   :sluggable_type, :limit => 50
      t.string   :scope
      t.datetime :created_at
    end
    add_index :friendly_id_slugs, :sluggable_id
    add_index :friendly_id_slugs, [:slug, :sluggable_type], length: { slug: 140, sluggable_type: 50 }
    add_index :friendly_id_slugs, [:slug, :sluggable_type, :scope], length: { slug: 70, sluggable_type: 50, scope: 70 }, unique: true
    add_index :friendly_id_slugs, :sluggable_type

    # add friendly ids for nodes, roles, statuses
    add_column :nodes, :slug, :string
    add_index :nodes, :slug, unique: true, using: :btree

    add_column :roles, :slug, :string
    add_index :roles, :slug, unique: true, using: :btree

    add_column :statuses, :slug, :string
    add_index :statuses, :slug, unique: true, using: :btree

    add_column :datacenters, :slug, :string
    add_index :datacenters, :slug, unique: true, using: :btree

  end
end
