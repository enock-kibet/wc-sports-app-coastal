# API Migration Checklist

This checklist translates the current API audit into concrete implementation work for the Flutter app.

## Goal

Move the app from legacy `SportApp/api/...` endpoints to the documented frontend/mobile API in:

- `/Users/kibet/Code/WTL/SportsApp Backend/docs/FRONTEND_API_REFERENCE.md`

Target outcome:

- keep the current app design and navigation intact
- replace legacy service calls and hard-coded IDs
- adapt models and repositories to the new response shapes
- confirm backend gaps before touching the affected flows

## Current Verdict

We can migrate without redesigning the app, but not without refactoring the data layer.

Most of the work is in:

- `lib/data/services/client.dart`
- model mapping under `lib/data/models`
- auth persistence in `AppPreferencesManager`
- feature blocs that assume legacy payload fields

## Phase 1: Core API Foundation

- Create a single base URL and versioned route strategy for:
  - `/api/v1/frontend-auth`
  - `/api/v1/mobile/...`
  - `/api/v1/frontend/shop/...`
  - `/api/v1/points/...`
  - `/api/v1/frontend/notifications/...`
- Remove hard-coded league and season IDs from service methods.
- Introduce a shared context source for:
  - active `league_id`
  - active `season_id`
  - authenticated user preferences
- Prefer `X-League-Id` and `X-Season-Id` request headers for cross-feature
  context, with query params kept only where an endpoint still needs per-call
  overrides.
- Seed default context from app config so public and auth requests can resolve
  league/season before the user session is established.
- Add DTO-to-domain mapping instead of decoding backend JSON directly into old app models.

## Phase 2: Auth Migration

### Backend docs already cover

- register
- login
- refresh
- forgot password
- reset password
- request OTP
- verify OTP
- Google login
- Apple login
- me
- update profile
- change password
- logout
- delete account

### App work

- Replace legacy auth calls in `AuthService` with documented routes.
- Update user parsing for:
  - `accessToken`
  - `refreshToken`
  - `userData`
  - `data.context`
- Map new backend fields into app user fields:
  - `full_name` -> `name`
  - `id` -> `userID`
  - `phone` -> `phoneNumber`
- Decide how to handle `picture`, since the docs do not show profile image fields.
- Update token refresh logic to use `refresh_token` request body instead of legacy query-string refresh.

### Confirm before implementation

- Is `phone` required on register?
- Does `/frontend-auth/me` include profile image fields?

### Confirmed

- `preferred_league_id` and `preferred_season_id` are optional on register.
- Backend now accepts `X-League-Id` and `X-Season-Id` headers on frontend and
  mobile APIs, and resolves those before query params.

### Risk

If register requires `phone` and preferred context fields, signup UI needs a form update.

## Phase 3: Mobile Context

### Backend docs already cover

- `GET /api/v1/mobile/context`
- `POST /api/v1/mobile/context/league`
- `POST /api/v1/mobile/context/season`

### App work

- Add a dedicated context repository/service.
- Persist active league and season locally.
- Use context values in matches, clubs, players, media, standings, shop, and
  points calls.
- Route app-wide context through request headers first, then fall back to query
  params only when an endpoint is explicitly scoped for one request.

### Nice follow-up

- Expose league/season switching in the app later without changing the current migration scope.

## Phase 4: Home, Banners, Matches

### Backend docs already cover

- `GET /api/v1/mobile/home`
- `GET /api/v1/mobile/banners`
- `GET /api/v1/mobile/banners/personalized`
- `GET /api/v1/mobile/matches`
- `GET /api/v1/mobile/matches/{match}`

### App work

- Replace:
  - legacy match list
  - legacy played-match list
  - legacy banner feed
- Stop generating fake ticket prices where possible and source actual values from backend ticket types.
- Update `MatchType` and `MatchModel` mapping for:
  - home club
  - away club
  - venue
  - scheduled time
  - scores
  - status

### Confirm before implementation

- Does `GET /mobile/matches/{match}` return:
  - quarter or interval scores
  - venue latitude/longitude
  - enough nested stats for the recap screen

## Phase 5: Clubs, Roster, Players, Statistics

### Backend docs already cover

- `GET /api/v1/mobile/clubs`
- `GET /api/v1/mobile/clubs/{club}`
- `GET /api/v1/mobile/clubs/{club}/players`
- `GET /api/v1/mobile/clubs/{club}/matches`
- `GET /api/v1/mobile/players`
- `GET /api/v1/mobile/players/{player}`
- `GET /api/v1/mobile/players/{player}/stats`
- `GET /api/v1/mobile/statistics/categories`
- `GET /api/v1/mobile/statistics/leaders`
- `GET /api/v1/mobile/statistics/players/{player}`
- `GET /api/v1/mobile/standings`

### App work

- Replace legacy roster endpoints with mobile clubs and players endpoints.
- Update player mapping for:
  - `jersey_number`
  - height from `height_feet` + `height_inches`
  - `weight`
  - profile image asset URL
- Update standings mapping for:
  - played
  - wins
  - losses
  - draws
  - points for
  - points against
  - point difference
  - standing points
  - rank
- Rework stats service to support the documented category-driven leaders response.

### Backend gap to confirm

- Match-specific stat leaders are still needed by the recap screen.

Needed backend contract:

- per-match category leaders grouped by club, or
- `GET /mobile/matches/{match}` enriched with equivalent leader data

## Phase 6: Media

### Backend docs already cover

- `GET /api/v1/mobile/media/highlights`
- `GET /api/v1/mobile/media/albums`
- `GET /api/v1/mobile/media/albums/{album}`
- `GET /api/v1/mobile/media/players/{player}`
- `GET /api/v1/mobile/media/clubs/{club}`

### App work

- Remove dependence on `assets/data/media_data.json` for core media flows.
- Map album and highlight responses into:
  - league media page
  - player media tab
  - home media/highlights
- Decide whether the app should consume:
  - highlights directly, or
  - albums plus album items

### Confirm before implementation

- Which endpoint best replaces current "home highlights" behavior?
- Does player media return flat media items or album collections only?

## Phase 7: Shop and Checkout

### Backend docs already cover

- products
- product detail
- ticket types
- promotions
- promotion validation
- addresses
- cart
- checkout initialize
- checkout verify
- orders
- tickets

### App work

- Replace legacy product parsing with new product and variant structures.
- Refactor cart logic to use:
  - `reference_type`
  - `reference_uuid`
  - cart item IDs
  - cart totals from backend
- Update address mapping for:
  - `recipient_name`
  - `physical_address`
  - `postal_code`
  - `is_default`
- Replace direct payment endpoints with:
  - cart checkout initialize
  - checkout verify
- Replace ticket purchase hack that posts a fake `productID` for tickets.

### Progress

- Product listing now maps from `/api/v1/frontend/shop/products`.
- Cart add, fetch, remove, clear, and cart checkout initialize now target the
  frontend shop cart endpoints.
- Address list and create now target `/api/v1/frontend/shop/addresses`.
- Direct merch buy-now now stages selected variants into the frontend cart and
  initializes checkout without changing the existing UI flow.
- Ticket buy-now now resolves a real frontend `ticket_type` and initializes
  frontend checkout instead of posting a fake ticket product.
- Payment webview now waits for the documented frontend checkout callback and
  verifies the payment using `GET /api/v1/frontend/shop/cart/checkout/verify/{provider}/{reference}`
  before showing success.
- Orders and tickets service calls are now available for:
  - `GET /api/v1/frontend/shop/orders`
  - `GET /api/v1/frontend/shop/orders/{order}`
  - `GET /api/v1/frontend/shop/tickets/summary`
  - `GET /api/v1/frontend/shop/tickets`
  - `GET /api/v1/frontend/shop/tickets/{ticket}`
- Post-payment success now reads ticket summary so the frontend tickets API is
  exercised on a live checkout path.
- Profile now exposes a `My Tickets` screen backed by frontend ticket summary,
  upcoming tickets, and recent orders.
- Ticket and order detail screens now consume:
  - `GET /api/v1/frontend/shop/tickets/{ticket}`
  - `GET /api/v1/frontend/shop/orders/{order}`
- Ticket and merch checkout now pass `redeem_points` into the documented
  frontend cart checkout initialize endpoint instead of falling back to the
  legacy payments API.
- Pickup location list now reads from
  `GET /api/v1/frontend/shop/pickup-stations` instead of local JSON.

### Important app assumptions to remove

- hard-coded ticket `productID`
- email-based cart lookup
- local subtotal calculations as the source of truth
- old `authorizationUrl` response shape

### Current gap after implementation

- Buy-now now depends on an empty active cart before staging one-off checkout
  items, otherwise the app asks the user to use the cart flow or clear cart
  first.
- Ticket/order UI still has room for enhancements like QR presentation,
  download/share actions, and richer order item rendering.

## Phase 8: Points

### Backend docs already cover

- wallet
- summary
- history
- active rules
- earn points for action
- redeem points
- transfer points

### App work

- Points history now reads from `GET /api/v1/points/history` and maps into the
  existing `PointsData` cards without UI changes.
- Points balance now reads from `GET /api/v1/points/wallet`.
- Share-driven points earn now targets `POST /api/v1/points/actions/earn`.
- Legacy field decoding for history has been removed from the migrated read
  flow.

### Remaining app/backend mismatch

- points transfer is documented with `recipient_frontend_user_uuid`, but the
  current bottom sheet UI captures recipient email only

## Phase 9: Notifications

### Backend docs already cover

- register device
- list notifications
- mark notification read
- mark all notifications read

### App work

- Notification list now reads from `GET /api/v1/frontend/notifications` and is
  mapped into the existing `Notifications` UI model without screen changes.
- Device registration payload now matches the documented frontend fields:
  - `device_id`
  - `device_token`
  - `platform`
  - `device_name`
  - `app_version`
- Notification actions now call the documented endpoints:
  - `PATCH /api/v1/frontend/notifications/{notification}/read`
  - `PATCH /api/v1/frontend/notifications/read-all`

## Phase 10: Model Refactor

These app models are currently too coupled to the old backend shape and should be refactored or wrapped with adapters:

- `lib/data/models/user/user.dart`
- `lib/data/models/products/product.dart`
- `lib/data/models/products/cart.dart`
- `lib/data/models/addresses/address.dart`
- `lib/data/models/points/points.dart`
- `lib/data/models/notifications/notification.dart`
- `lib/data/models/roaster/roaster.dart`
- `lib/data/models/teamstats/teamstats.dart`
- `lib/data/models/match/match-recarp.dart`

Recommended approach:

- add API DTOs shaped like the new backend
- map DTOs into app-friendly view models
- keep UI widgets unchanged as much as possible

## Backend Questions To Resolve First

- Is `phone` required at registration?
- Are preferred league and season required at registration?
- Does user profile include image fields?
- What replaces points earn for share actions?
- Is there a frontend user lookup/search endpoint so email-based points transfer
  can work without changing the current design?
- What is the supported ticket purchase flow for the current "Buy Ticket" screen?
- What is the intended source for home-page highlights: home feed, banners, highlights, or albums?

## Recommended Implementation Order

1. Create new API DTOs and a context service.
2. Migrate auth and token persistence.
3. Migrate matches, clubs, standings, and roster.
4. Migrate media.
5. Migrate shop, cart, and checkout.
6. Migrate points and notifications.
7. Remove local JSON fallbacks and hard-coded IDs.

## Blocking Items

Do not start final production migration until these are answered:

- signup required fields
- ticket purchase backend contract
