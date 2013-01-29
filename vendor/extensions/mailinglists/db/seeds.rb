if defined?(::Refinery::User)
  ::Refinery::User.all.each do |user|
    if user.has_role?(:superuser) and user.plugins.find_by_name('mailinglists').nil?
      user.plugins.create(:name => "mailinglists",
                          :position => (user.plugins.maximum(:position) || -1) +1)
    end
  end
end