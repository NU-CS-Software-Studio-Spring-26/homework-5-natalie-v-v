# AI Coding Agent System Prompt & Project Brief

This file defines the strict constraints, verified stack realities, and conventions for this codebase. Read and adhere to this file before every generation. Do not infer or speculate on stack details outside of what is explicitly verified below.

---

## Stack
* **Framework & Version:** Rails ~> 8.1.3 (with `allow_browser versions: :modern` enforced globally in `ApplicationController`).
* **Database & Storage:** SQLite 3 (`sqlite3` gem >= 2.1) using separate schemas for queue, cache, and cable data.
* **Frontend Layer:** `propshaft` asset pipeline + Hotwire stack via `importmap-rails`, `turbo-rails`, and `stimulus-rails`.
* **State & Async:** Database-backed ecosystem using `solid_queue`, `solid_cache`, and `solid_cable`.
* **Test & Quality Framework:** Minitest suite with `capybara` and `selenium-webdriver` for system testing. Static security via `brakeman`. Code style via `rubocop-rails-omakase`.

---

## Commands
* **Setup:** `bin/setup`
* **Run Development Server:** `bin/dev`
* **Run Test Suite:** `bin/rails test` (or `bin/rails test:system` for integration tests)
* **Linting & Code Style:** `bundle exec rubocop`
* **Security Scan:** `bundle exec brakeman`

---

## Conventions
* **Routing:** Follow standard RESTful resources layout. Global standalone exceptions like `get '/hello', to: 'todos#hello'` map directly to resource controllers. Health checks must utilize the native `rails/health#show` mapped at `/up`.
* **Controller Responses:** Actions must fully handle HTML views or render data payloads matching the existing `jbuilder` schema templates (`index.json.jbuilder`, `show.json.jbuilder`).
* **Domain Model Hygiene:** Methods belonging to models must live entirely inside the scoping class definition block. (e.g., Ensure `full_description` in `todo.rb` is brought back inside the `class Todo < ApplicationRecord` block).
* **JavaScript Interactivity:** All programmatic browser features must go through isolated Stimulus JS lifecycle controllers under `javascript/controllers/`.

---

## Don'ts
* **No Speculative Dependency Inflation:** Do not add or suggest new gems to the `Gemfile` or add external JS packages via `importmap.rb` without explicit instruction. Work entirely with the native Omakase toolchain provided.
* **No Inline Code in ERB:** Never write or inject raw script blocks (`<script>`) or inline layout styling rules within view templates. Use asset pipeline stylesheets and Stimulus hooks.
* **No Broken Class Layouts:** Do not define stub helper functions or wrapper logic outside of the core class definition wrappers in `app/models/` or `app/controllers/`.
* **No Legacy Browser Workarounds:** Do not write backward-compatible polyfills or bypasses for older browser engines; the app strictly targets modern engines supporting CSS nesting, `:has` selectors, and native ESM.
