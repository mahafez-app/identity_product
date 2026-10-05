# identity_product

Layer 3 identity experience package. It owns sign-in, sign-up, name
confirmation, their UI state, and bilingual presentation strings. It consumes
`identity_service` for authentication and profile operations and exposes
screens plus public Riverpod providers to the host shell.

The app supplies route callbacks to login and sign-up screens. The package
does not know host route names or navigation structure.
