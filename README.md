# Zhinux Contracts

Contracts are defined, stored, managed, and exposed here.

> Events are contracts. They must be versioned, owned, and published exactly like APIs.
>
> Contracts are products. Services depend on contracts, not on each other.
>
> Events are immutable facts. If meaning changes → new event type.
>
> RPC inside a bounded context, Events across bounded contexts.
>
> RPC is about intent. Events are about truth.

## How to use

```sh
cd brand-contracts
make generate
git commit -am "contracts: regenerate hello v1"
git tag v1.2.0
```

In services:

```go
import "company/brand-contracts/gen/go/hello/v1"
```

## CI Flow

```sh
buf lint
buf breaking --against '.git#branch=main'

# Or do it like Google
# buf breaking --against 'https://github.com/company/brand-contracts.git#branch=main'
```
