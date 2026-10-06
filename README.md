# identity_product

Layer 3 identity product for sign-in, sign-up, profile completion and related presentation flows.

## Responsibility and dependencies

The package owns identity screens, UI state and localized presentation. It consumes `identity_service` for authentication/profile operations and Layer 1 core/design-system APIs for shared contracts and UI. It does not depend on peer products or own the host router.

The app registers the exported screens and supplies callbacks for transitions that leave the product flow. The product does not import `go_router` or know host route names.

## Use

```yaml
dependencies:
  identity_product:
    git:
      url: https://github.com/mahafez-app/identity_product.git
      ref: v1.0.2
```

Import `package:identity_product/identity_product.dart` for public screens and provider contracts.
