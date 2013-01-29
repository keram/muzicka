class CreateMailinglists < ActiveRecord::Migration

  def self.up

    create_table ::Refinery::Mailinglists::Subscriber.table_name do |t|
      t.string :email
      t.boolean :subscribed, :default => true
      t.boolean :spam, :default => false
      t.timestamps
    end

    add_index ::Refinery::Mailinglists::Subscriber.table_name, :id
    add_index ::Refinery::Mailinglists::Subscriber.table_name, :email, :unique => true

    if (seed = Rails.root.join('db', 'seeds', 'mailinglists.rb')).exist?
      load(seed)
    end
  end

  def self.down
    if defined?(::Refinery::UserPlugin)
      ::Refinery::UserPlugin.destroy_all({:name => "mailinglists"})
    end

    drop_table ::Refinery::Mailinglists::Subscriber.table_name
  end

end
