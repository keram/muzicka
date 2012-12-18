# encoding: utf-8
# rails runner db/progressbar.rb

module Refinery

  module Import

    def self.import_settings

      settings = {
        :site_email => 'info@muzicka.sk',
        :site_phone => '',
        :site_url => 'http://www.muzicka.sk',
        :site_twitter => 'muzicka',
        :site_twitter_link => 'https://twitter.com/muzicka',
        :site_facebook_link => 'www.facebook.com/muzickaband',
        :site_google_plus_link => 'https://profiles.google.com/111043170539089740356'
      }

      settings.each {|k, v|
        Refinery::Setting.set(k, v.to_s)
        puts "#{k} : #{v}"
      }

    end

    def self.import_users

      users = [
        {:username => 'Tomáš Brunovský', :email => 'tbrunovsky@limba.com'}
      ]

      users.each do |user|
        u = User.find_by_email(user[:email])
        unless u
#          p = (Rails.env.production?) ? (0...32).map{ ('a'..'z').to_a[rand(26)] }.join : 'nbusr123'
          p = 'nbusr123'
          u = User.create(user.merge({:password => p, :password_confirmation => p}))
          puts "User \"#{user[:username]}\" with email \"#{user[:email]}\" was created."
        end

        u.add_role(:superuser)
        u.add_role(:refinery)
      end

    end

    def self.find_page (id, slug, title)
      page = Page.find_by_id(id)
      current_locale = ::I18n.locale

      I18n.frontend_locales.each do |lang|
        ::I18n.locale = lang
        page = Page.find_by_title(title[lang]) unless page
        page = Page.find_by_slug(slug) unless page
      end

      ::I18n.locale = current_locale

      page
    end

    def self.import_pages
      pages = {
        :home => {
          :id => 1,
          :title => { :sk => 'Úvod', :en => 'Home', :pl => 'Home'},
          :menu_position => 1
        },
        :about_us => {
          :id => 3,
          :title => { :sk => 'O Muzičke', :en => 'About Muzička', :pl => 'About Muzička'},
          :attributes => {:deletable => false, :show_in_menu => true},
          :menu_position => 20
        },
        :video => {
          :title => { :sk => 'Video', :en => 'Video', :pl => 'Video'},
          :attributes => {
            :deletable => true,
            :show_in_menu => true,
            :link_url => 'http://www.youtube.com/muzickaband' },
          :menu_position => 30
        },
        :recordings => {
          :title => { :sk => 'Nahrávky', :en => 'Recordings', :pl => 'Recordings'},
          :attributes => {:deletable => false, :show_in_menu => true, :skip_to_first_child => true},
          :menu_position => 40
        },
        :recordings_2011 => {
          :title => { :sk => 'Pomo auťa, bo anťa ňeto kja! (2011)', :en => 'Pomo auťa, bo anťa ňeto kja! (2011)', :pl => 'Pomo auťa, bo anťa ňeto kja! (2011)'},
          :attributes => {:deletable => false, :show_in_menu => true, :parent_id => 9}
        },
        :recordings_2012 => {
          :title => { :sk => 'Speváci z Rejdovej a Muzička (2012)', :en => 'Singers from Rejdová village and Muzička (2012)', :pl => 'Singers from Rejdová village and Muzička (2012)'},
          :attributes => {:deletable => false, :show_in_menu => true, :parent_id => 9}
        },
        :blog => {
          :id => 7,
          :title => { :sk => 'Blog', :en => 'Blog', :pl => 'Blog'},
          :attributes => {:deletable => false, :show_in_menu => true},
          :menu_position => 50
        },
        :contact => {
          :id => 4,
          :title => { :sk => 'Kontakt', :en => 'Contact', :pl => 'Contact'},
          :attributes => {:deletable => false, :show_in_menu => true},
          :menu_position => 60
        },
        :contact_thank_you => {
          :id => 5,
          :title => { :sk => 'Ďakujeme', :en => 'Thank You', :pl => 'Thank You'},
          :attributes => {:deletable => false, :show_in_menu => false}
        }
      }

      pages.each do |psym, p|

        page = find_page(p[:id], psym, p[:title])

        attributes = {:deletable => false, :show_in_menu => true}
        attributes = attributes.merge(p[:attributes]) if p[:attributes]

        page_created = false
        unless page
          attributes = attributes.merge({:title => p[:title][::I18n.locale].to_s})
          page = Page.create(attributes)
          page.save!
          page_created = true
        end

        Pages.default_parts.each_with_index do |part_title, i|
          part = page.parts.find_by_title(part_title)
          unless part
            page.parts.create({
                :title => part_title,
                :body => "",
                :position => i
              })
          else
            part.update_attributes(:position => i)
          end
        end

        I18n.frontend_locales.each do |lang|
          ::I18n.locale = lang

          Pages.default_parts.each do |part_title|
            file_part_name = part_title.downcase.gsub(/ /, '_')
            part_file_path = Rails.root.join("db/templates/#{psym}_#{file_part_name}_#{lang}.html")
            part = page.parts.find_by_title(part_title)
            part_body = IO.read(part_file_path) rescue ''
            part.update_attributes(:body => part_body)
          end

          attributes = attributes.merge({:custom_slug => p[:custom_slug][lang].to_s}) if p[:custom_slug] and p[:custom_slug][lang]
          attributes = attributes.merge({:title => p[:title][lang].to_s})
          page.update_attributes(attributes)
        end if I18n.frontend_locales.any?

        puts "Page \"#{page.title}\" (#{page.id}) #{page_created ? 'created' : 'updated'}."
      end

      tmp_arr = []
      menu_pages = []

      pages.each do |s, p|
        tmp_arr[p[:menu_position]] = Page.find_by_title(p[:title][::I18n.locale]) if p[:menu_position]
      end

      tmp_arr.compact.each do |p|
        menu_pages << p
      end

      menu_pages.each_with_index do |p, i|
        if i > 0
          p.move_to_right_of(menu_pages[i - 1])
        end
      end
    end

    puts 'import/update settings'
    import_settings
    puts 'import/update users'
    import_users
    puts 'import/update pages'
    import_pages
  end
end