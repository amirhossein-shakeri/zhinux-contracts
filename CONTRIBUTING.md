# Contributing to API Contracts

This repository defines long‑lived public contracts.
Changes here carry permanent consequences.

Please read this document carefully before proposing changes.

---

## Guiding Philosophy

APIs are promises.

Once released, a contract must remain valid for all existing consumers.
Backward compatibility is not a preference — it is a requirement.

This repository optimizes for:

- Stability over convenience
- Clarity over cleverness
- Long‑term evolution over short‑term speed

### Contracts as Products

Contracts in this repository are first‑class products.

Services depend on these contracts, not on each other.
Generated Go packages are the supported consumption model for Go services.

Proto files are not consumed directly by services.
They exist to define, review, and evolve contracts with long‑term guarantees.

---

## Allowed Changes (Within a Version)

The following changes are safe and allowed:

- Adding new fields with new field numbers
- Adding new messages
- Adding new RPCs
- Adding new enum values (append‑only)
- Adding new optional fields
- Improving comments and documentation

---

## Forbidden Changes (Within a Version)

The following changes are NOT allowed and will be rejected by CI:

- Removing fields
- Renaming fields
- Reusing field numbers
- Changing field types
- Changing RPC request or response types
- Removing enum values
- Renaming packages

If you need any of the above, you must introduce a new major version.

---

## Versioning Rules

- Each domain is versioned independently
- Versions are directories (v1, v2, ...)
- Once published, a version is immutable
- New versions may coexist indefinitely

Never modify past facts.

Tags represent published contract releases.

Whenever generated code changes:

- A semantic version tag MUST be created
- Services should upgrade by updating the dependency version only

This repository follows consumer‑driven versioning discipline.

---

## Generated Code Policy

Generated Go code under gen/go is committed to this repository and versioned
alongside the protobuf definitions.

Rules:

- Generated code must always be regenerated via `make generate`
- Manual edits to generated code are forbidden
- Any protobuf change must include regenerated Go output in the same commit
- Services must never generate code independently

This guarantees:

- Deterministic builds
- Zero codegen drift across services
- A single, authoritative API surface for Go consumers

---

## Linting and CI

All changes are validated automatically using Buf:

- Lint rules enforce naming, comments, and structure
- Breaking change detection compares against main branch
- CI failures must be resolved before approval

Do not bypass these checks.

---

## Events

Event schemas represent historical facts.

Rules:

- Events are immutable
- Fields may be added, never changed
- Consumers must tolerate unknown fields
- New semantics require new events

---

## Review Expectations

API changes require careful review.

Reviewers will evaluate:

- Compatibility guarantees
- Naming clarity
- Domain ownership
- Future evolution paths
- Consumer impact

Approval means the organization is committing to support this API long‑term.

---

## Final Note

Treat every commit here as if it will still be in use five years from now.

Because it probably will be.
