# encoding: utf-8

Refinery::I18n.configure do |config|
	config.enabled = true

	config.default_locale = :sk

	config.current_locale = :sk

	config.default_frontend_locale = :sk

	config.frontend_locales = [:sk, :en, :pl]

	config.locales = {:en => 'EN', :sk => 'SK', :pl => 'PL'}
end
