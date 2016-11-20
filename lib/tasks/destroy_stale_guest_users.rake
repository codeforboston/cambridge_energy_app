task destroy_stale_guest_users: :environment do
  User.stale_guests.destroy_all
end
