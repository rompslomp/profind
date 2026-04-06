# proFind

A platform for homeowners to find qualified, verified professionals for home improvement and maintenance — electricians, plumbers, painters, carpenters, and more.

## Features

- **Search & discovery** — browse service providers by category tags or free-text search
- **Provider profiles** — professionals advertise their services with descriptions and photos
- **Quote requests** — users can contact providers directly through the platform
- **Provider approval flow** — professionals request an upgrade; admins approve or reject
- **Admin backoffice** — manage users, tags, and pending provider requests at `/admin`

## Tech Stack

| Layer | Technology |
|-------|------------|
| Framework | Ruby on Rails 8.1 |
| Ruby | 4.0.1 |
| Database | PostgreSQL 17 |
| Frontend | Bootstrap 5, Hotwire (Turbo + Stimulus) |
| Authentication | Devise |
| Authorization | Pundit |
| Search | Ransack |
| File uploads | Active Storage |
| Testing | RSpec, FactoryBot |
| Deployment | Docker + docker-compose |

---

## Running with Docker

The recommended way to run proFind is via Docker Compose.

**1. Copy the environment file and set your master key:**

```bash
cp .env.example .env
# Open .env and set RAILS_MASTER_KEY to the value in config/master.key
```

**2. Start the app:**

```bash
docker compose up
```

The app will be available at **http://localhost:3000**.

On first boot, Docker Compose automatically creates and migrates the database. It does **not** seed automatically — run this once to load test data:

```bash
docker compose run --rm web bin/rails db:seed
```

---

## Running Locally

**Requirements:** Ruby 4.0.1, PostgreSQL, Node.js, Yarn

```bash
bundle install
yarn install
yarn build:css

# Configure your local PostgreSQL credentials in config/database.yml, then:
bin/rails db:create db:migrate db:seed

# Start the dev server (Rails + CSS watcher)
bin/dev
```

---

## Test Data

The seed file (`db/seeds.rb`) creates the following accounts. All passwords are `password123`.

| Role | Email | Notes |
|------|-------|-------|
| Admin | `admin@profind.dev` | Full access to `/admin` backoffice |
| Provider | `john@prohandyman.dev` | Approved — 2 active services (electrical, handyman) |
| Provider | `maria@cleanpro.dev` | Approved — 2 active services (painting, cleaning) |
| Basic user | `sarah@example.com` | Regular account, can request quotes |
| Pending provider | `mike@wannabepro.dev` | Submitted provider request, awaiting approval |

The seeds also create **10 category tags** (Electrician, Plumber, Painter, Carpenter, Landscaper, HVAC, Roofer, Tiler, Cleaner, Handyman) and a sample quote from Sarah to John's electrical service.

To seed (or re-seed) at any time:

```bash
# Locally:
bin/rails db:seed

# Inside Docker:
docker compose run --rm web bin/rails db:seed
```

---

## Running Tests

```bash
bundle exec rspec
```

The test suite covers model validations, associations, scopes, and request-level authentication and authorization.

---

## User Roles

| Role | Capabilities |
|------|-------------|
| **Basic** | Browse providers, search, request quotes |
| **Provider** | All of the above + create and manage own services |
| **Admin** | All of the above + access backoffice, approve providers, manage tags |

Providers start as basic users and submit a request to upgrade. An admin approves or rejects the request from `/admin/provider_requests`.

---

## Key URLs

| URL | Description |
|-----|-------------|
| `/` | Homepage with featured services |
| `/services` | Browse and search all providers |
| `/services/new` | Create a service (approved providers only) |
| `/quotes` | Your quote request history |
| `/admin` | Admin dashboard (admin role required) |
| `/admin/provider_requests` | Approve / reject provider upgrades |
| `/admin/tags` | Manage service category tags |
| `/users/sign_in` | Sign in |
| `/users/sign_up` | Create an account |
