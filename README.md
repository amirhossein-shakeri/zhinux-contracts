# Zhinux Contracts

Contracts are defined, stored, managed, and exposed here and this repository contains the authoritative, implementation‑agnostic API contracts for the organization. It defines gRPC / Protocol Buffers interfaces that are consumed by multiple services, teams, and external integrations. No implementation code lives here.

This repository is the single source of truth for:

- Service APIs
- Domain models
- Events
- Cross‑cutting system contracts

---

## Core Principles

- Contracts are stable, intentional, and long‑lived
- Backward compatibility is strictly enforced
- Domains are versioned explicitly (v1, v2, ...)
- Implementation concerns never leak into contracts
- All changes are reviewed as API design decisions

Think of this repository as constitutional law, not application code.

> - Events are contracts. They must be versioned, owned, and published exactly like APIs.
> - Contracts are products. Services depend on contracts, not on each other.
> - Events are immutable facts. If meaning changes → new event type.
> - RPC inside a bounded context, Events across bounded contexts.
> - RPC is about intent. Events are about truth.
> - RPCs are for business logic. Don't use them for metrics, ping, etc.

---

## Repository Structure

Each domain owns its own versioned namespace:

```text
user/
  v1/
    user.proto
    user_requests.proto
    user_responses.proto
    user_service.proto

password/
  v1/
    password.proto
    password_requests.proto
    password_responses.proto
    password_service.proto

common/
  v1/
    metadata.proto
    pagination.proto
    errors.proto
    system.proto

events/
  <domain>/
    v1/
      event_name.proto
```

Rules:

- Domains own their folders
- Versions are immutable
- Events are append‑only

---

## Versioning Policy

- v1 is forever backward‑compatible
- Breaking changes require a new major version
- Fields are never removed or renumbered
- Enum values are append‑only
- Messages and services are never repurposed

Compatibility is enforced automatically using Buf.

---

## Tooling

This repository uses Buf as the contract enforcement engine.

Key files:

- buf.yaml     — linting and breaking‑change rules
- buf.lock     — pinned external dependencies
- buf.gen.yaml — standard code generation templates

CI rejects:

- Breaking API changes
- Undocumented public symbols
- Non‑versioned packages

---

## CI Flow

All contract changes are validated using Buf before being merged.

```sh
buf lint
buf breaking --against '.git#branch=main'
```

Equivalent remote check (recommended for forks and CI parity):

```sh
buf breaking --against 'https://github.com/amirhossein-shakeri/zhinux-contracts.git#branch=main'
```

Any change that fails linting or backward‑compatibility checks will be rejected.

---

## How to Use

This repository is the single source of truth for generated Go contracts.

All Go code generated from protobuf definitions is committed and versioned
in this repository. Service repositories import generated Go packages directly
and do not generate protobuf code themselves.

To update contracts:

```sh
cd zhinux-contracts
make generate
git commit -am "contracts: regenerate hello v1"
git tag v1.2.0
```

In Go services:

```go
import "company/brand-contracts/gen/go/hello/v1"
```

---

## What This Repo Is Not

This repository does NOT contain:

- Service implementations
- Business logic
- Databases or schemas
- Runtime configuration

Those live in service repositories.

---

## Governance

All changes to this repository are reviewed as API design changes.
Merges represent permanent commitments to backward compatibility.

If you are unsure whether a change is safe, it probably is not.

See CONTRIBUTING.md for details.
