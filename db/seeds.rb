# Development seed file for proFind
# Creates: 1 admin, 1 approved provider with services, 1 basic user, plus extra users/services
# Idempotent: uses find_or_create_by! to avoid duplicates

puts "Seeding proFind..."

# ────────────────────────────────
# Tags (created by admin, managed in backoffice)
# ────────────────────────────────
tag_names = [
  "Electrician", "Plumber", "Painter", "Carpenter", "Landscaper",
  "HVAC", "Roofer", "Tiler", "Cleaner", "Handyman"
]

tags = tag_names.map do |name|
  Tag.find_or_create_by!(name: name)
end
puts "  Created #{tags.size} tags"

# ────────────────────────────────
# Admin user
# ────────────────────────────────
admin = User.find_or_initialize_by(email: "admin@profind.dev")
admin.assign_attributes(
  name: "Alex Admin",
  password: "password123",
  password_confirmation: "password123",
  role: :admin,
  provider_status: :not_requested
)
admin.save!
puts "  Admin: #{admin.email} / password123"

# ────────────────────────────────
# Approved professional (provider)
# ────────────────────────────────
provider = User.find_or_initialize_by(email: "john@prohandyman.dev")
provider.assign_attributes(
  name: "John Handyman",
  password: "password123",
  password_confirmation: "password123",
  role: :provider,
  provider_status: :approved,
  provider_bio: "15 years of experience in electrical and general home maintenance. Licensed and insured. Available weekdays and weekends."
)
provider.save!
puts "  Provider: #{provider.email} / password123"

# Services for the provider
electrician_service = Service.find_or_initialize_by(title: "Residential Electrical Repairs", user: provider)
electrician_service.assign_attributes(
  description: "Complete electrical repair and installation service for your home. Outlet replacement, panel upgrades, ceiling fan installation, and safety inspections. All work meets local code requirements. Free estimates on larger jobs."
)
electrician_service.save!
electrician_service.tags = [ tags.find { |t| t.name == "Electrician" }, tags.find { |t| t.name == "Handyman" } ].compact

handyman_service = Service.find_or_initialize_by(title: "General Home Maintenance & Repairs", user: provider)
handyman_service.assign_attributes(
  description: "Your one-stop solution for home repairs and maintenance tasks. Door and window repairs, minor plumbing fixes, furniture assembly, drywall patching, and more. No job too small!"
)
handyman_service.save!
handyman_service.tags = [ tags.find { |t| t.name == "Handyman" }, tags.find { |t| t.name == "Carpenter" } ].compact

puts "  Provider has #{provider.services.count} services"

# ────────────────────────────────
# Second provider (to show variety)
# ────────────────────────────────
provider2 = User.find_or_initialize_by(email: "maria@cleanpro.dev")
provider2.assign_attributes(
  name: "Maria CleanPro",
  password: "password123",
  password_confirmation: "password123",
  role: :provider,
  provider_status: :approved,
  provider_bio: "Professional cleaning and painting services with 10 years of experience. Eco-friendly products available."
)
provider2.save!

paint_service = Service.find_or_initialize_by(title: "Interior & Exterior Painting", user: provider2)
paint_service.assign_attributes(
  description: "Transform your home with a fresh coat of paint. We handle everything from wall prep, priming, to the final coat. Interior rooms, exterior facades, cabinets, and fences. We use premium, low-VOC paints."
)
paint_service.save!
paint_service.tags = [ tags.find { |t| t.name == "Painter" } ].compact

clean_service = Service.find_or_initialize_by(title: "Deep Home Cleaning Service", user: provider2)
clean_service.assign_attributes(
  description: "Professional deep cleaning for your home. Kitchen degreasing, bathroom sanitizing, window cleaning, and floor polishing. We bring all equipment and eco-friendly cleaning products. One-time or recurring bookings available."
)
clean_service.save!
clean_service.tags = [ tags.find { |t| t.name == "Cleaner" } ].compact

puts "  Provider 2: #{provider2.email} / password123 with #{provider2.services.count} services"

# ────────────────────────────────
# Basic user (pending provider request)
# ────────────────────────────────
basic_user = User.find_or_initialize_by(email: "sarah@example.com")
basic_user.assign_attributes(
  name: "Sarah Basic",
  password: "password123",
  password_confirmation: "password123",
  role: :basic,
  provider_status: :not_requested
)
basic_user.save!
puts "  Basic user: #{basic_user.email} / password123"

# ────────────────────────────────
# User with pending provider request
# ────────────────────────────────
pending_user = User.find_or_initialize_by(email: "mike@wannabepro.dev")
pending_user.assign_attributes(
  name: "Mike Pending",
  password: "password123",
  password_confirmation: "password123",
  role: :basic,
  provider_status: :pending,
  provider_bio: "Experienced plumber with 8 years in the trade."
)
pending_user.save!
puts "  Pending provider: #{pending_user.email} / password123"

# ────────────────────────────────
# Sample quote from basic user
# ────────────────────────────────
quote = Quote.find_or_initialize_by(user: basic_user, service: electrician_service)
quote.assign_attributes(
  message: "Hi John, I need help replacing a faulty outlet in my kitchen and checking if my electrical panel needs an upgrade. My house is from 1985. When would you be available?",
  status: :pending
)
quote.save!
puts "  Created sample quote"

puts "\nSeed complete!"
puts "\nLogin credentials:"
puts "  Admin:    admin@profind.dev / password123"
puts "  Provider: john@prohandyman.dev / password123"
puts "  Provider: maria@cleanpro.dev / password123"
puts "  Basic:    sarah@example.com / password123"
puts "  Pending:  mike@wannabepro.dev / password123"
