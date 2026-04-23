# Solar Multi-Sign

## Solar panel visibility on home page

The solar panel on the home page is conditionally shown based on `FFAppState().haveSolarContract`.

This flag is set to `true` when the current property has a solar account with a non-null, non-empty `id` — i.e. `getContractByType(accountsForCurrentProperty, 'solar')?.id` is present. If no solar account exists for the property, the panel is hidden entirely.

Relevant code: `app/lib/pages/home_page/home_page_widget.dart:1062` (condition), `app/lib/actions/actions.dart:490` (flag set).
