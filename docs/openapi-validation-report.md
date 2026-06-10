# OpenAPI Validation Report

## Errors

- Broken $ref: `#/components/responses/ErrorResponse` at `paths//auth/register/post/responses/400`
- Broken $ref: `#/components/responses/ErrorResponse` at `paths//auth/login/post/responses/401`
- Broken $ref: `#/components/responses/ErrorResponse` at `paths//auth/refresh/post/responses/401`
- Broken $ref: `#/components/responses/ErrorResponse` at `paths//users/me/get/responses/401`
- Broken $ref: `#/components/responses/ErrorResponse` at `paths//users/{id}/get/responses/404`
- Broken $ref: `#/components/responses/ErrorResponse` at `paths//trips/post/responses/409`
- Broken $ref: `#/components/responses/ErrorResponse` at `paths//trips/{id}/accept/post/responses/409`

## Warnings

- POST/PUT/PATCH without requestBody:
  - POST /trips/{id}/start
  - POST /trips/{id}/complete
  - POST /notifications/{id}/mark-read

## Modeling Problems

- None identified

## Endpoints Missing In Docs

- /users
- /users/{id}
- /drivers
- /drivers/{id}
- /drivers/{id}/availability
- /vehicles
- /trips/{id}
- /trips/{id}/accept
- /trips/{id}/start
- /trips/{id}/complete
- /trips/{id}/cancel
- /trips/{id}/locations
- /payments/{id}
- /webhooks/payments
- /coupons/{code}

## Schemas Not Used

- ErrorResponse
- Payment
- WalletTransaction
- CouponUsage
- AuditLog
- RefreshToken
- IdempotencyKey

## Broken References

- #/components/responses/ErrorResponse referenced at paths//auth/register/post/responses/400
- #/components/responses/ErrorResponse referenced at paths//auth/login/post/responses/401
- #/components/responses/ErrorResponse referenced at paths//auth/refresh/post/responses/401
- #/components/responses/ErrorResponse referenced at paths//users/me/get/responses/401
- #/components/responses/ErrorResponse referenced at paths//users/{id}/get/responses/404
- #/components/responses/ErrorResponse referenced at paths//trips/post/responses/409
- #/components/responses/ErrorResponse referenced at paths//trips/{id}/accept/post/responses/409

## Improvements Recommended

- Add explicit examples for key endpoints (Create Trip, Payment Charge, Position Update).
- Clarify TripLocation coords ordering and provide GeoJSON examples.
- Mark internal endpoints consistently with `x-internal: true` and document access requirements.
- Remove unused schemas or document rationale.

## Consistency Checklist

- All paths present in docs: FAIL
- No broken $ref: FAIL
- All POST/PUT/PATCH have requestBody: FAIL
- Every operation has a 2xx response: OK

## Automatic Fixes Applied

- Replaced references to `#/components/schemas/Error` with `#/components/schemas/ErrorResponse` where applicable