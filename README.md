# BelyftedKYB

A Flutter application for business identity verification (Know Your Business). The app guides business owners through a structured, multi-step KYB flow that collects business information, registration details, director/UBO data, and supporting documents before final submission for review.

---

## Features

- Multi-step KYB verification flow (4 steps) with animated step indicator
- Business information and registration detail collection
- Director and Ultimate Beneficiary Officer (UBO) management with add, edit, and delete
- Document upload with dotted-border file picker
- Content dialogs with live search for country, industry, role, etc.
- Verification result screen (success / failure)
- KYC status tracking per director (verified, pending, failed)
- Animated page transitions (fade, slide, scale, rotate)
- Fully responsive using Vize screen adaptation

---

## Getting Started

### Prerequisites

- Flutter `>=3.0.0`
- Dart `>=3.0.0`

### Install

```bash
git clone https://github.com/N-DiLo/belyfted-kyb.git
cd belyfted-kyb
flutter pub get
```

### Run

```bash
flutter run
```

### Build

```bash
# Android
flutter build apk --release

# iOS
flutter build ipa --release
```

---

## Technologies Used

| Concern | Choice |
|---|---|
| Language | Dart |
| Framework | Flutter |
| Screen sizing | Vize (figma-based responsive scaling) |
| Dotted borders | `dotted_border` |
| Navigation | Named routes via `RouteService` |
| State management | Local `setState` (no external package) |

---

## State Management Approach

The app uses Flutter's built-in **`setState`** for all state management.

**Why `setState`?**

This is a self-contained, single-feature verification flow with a clear linear progression. Each screen owns a small, well-defined state with form controllers, dialog selections, and a director list. There is no shared state between steps; `KYBView` owns only the current page index, and each step view owns only its own form state. This makes the data flow easily without introducing any state management dependency.

Adding an external state management solution would introduce indirection and boilerplate that is not justified for a flow of this size. If the app scales, sharing form values between steps or persisting partial submissions while migrating to Riverpod would be the next step.

---

## Implementation Decisions

**Clean Architecture in a single feature**
Even though the app is a single KYB flow, the code is split into `data`, `domain`, and `presentation` layers. This means model classes have no Flutter imports, enums carry all display logic via extensions, and views contain zero business logic conditionals. The structure scales cleanly if new features are added.

**Enums over strings for state and routing**
`VerificationResult` and `KycStatus` are typed enums with extensions that own their labels, colors, and images. Route arguments are passed as `enum.name` and converted back via `fromString()`. This eliminates magic strings and makes invalid states impossible to represent.

**Inline director form with `Visibility` + `maintainState`**
Rather than pushing a new route for adding a director, the form renders inline within the same `ListView` using `Visibility(maintainState: true)`. This preserves the multi-step indicator at the top of the screen and avoids a jarring navigation transition for what is effectively an in-page action.

**`CustomDialog` with a generic `show<T>` helper**
All selection dialogs (country, industry, role, etc.) use a single `SelectionDialogContent` widget with live search, wrapped in `CustomDialog.show<String>()`. The typed generic means the caller gets a `String?` back directly with no casting.

**`CustomTextfield` handles both text and dropdown**
Rather than maintaining two separate field widgets, `hasDrop: true` switches `CustomTextfield` from a `TextFormField` to a `DropdownButtonFormField`. For dialogs (country, role), `readOnly: true` combined with `onTap` opens `CustomDialog` instead, keeping the interaction consistent without a native dropdown.

**Randomised page transitions**
`RouteService` picks randomly from four transition strategies (fade, slide, scale, rotate) on every navigation. This adds personality to the flow without requiring animation configuration at each call site.

---

## Project Structure

```
lib/
├── core/
│   ├── constants/
│   │   ├── app_colors.dart          # All MaterialColor tokens
│   │   └── app_images.dart          # Asset path constants
│   └── shared/
│       └── widgets/
│           ├── custom_app_bar.dart
│           ├── custom_button.dart
│           ├── custom_dialog.dart
│           ├── custom_textfield.dart
│           ├── dotted_border_button.dart
│           └── step_indicator.dart
│
├── features/
│   └── kyb/
│       ├── data/
│       │   └── models/
│       │       ├── director_item.dart
│       │       └── mock_data.dart
│       ├── domain/
│       │       └── verification_result.dart
│       └── presentation/
│           ├── kyb_view.dart
│           ├── start_kyb_view.dart
│           ├── kyb_result_view.dart
│           ├── check_status_view.dart
│           └── steps/
│               ├── business_info_view.dart
│               ├── business_reg_info_view.dart
│               ├── beneficiary_officer_view.dart
│               │   ├── director_card.dart
│               │   └── new_director_details.dart
│               └── document_upload_view.dart
│
├── belyfted_kyb.dart                # App entry point (MaterialApp)
└── main.dart
```

---

## Architecture

The app uses a lightweight **Clean Architecture** approach suited to a single-feature Flutter app.

### Layers

**`core/`**
Shared primitives with no feature knowledge. Widgets here accept plain parameters and emit callbacks. Colors and images live here so they can be swapped without touching feature code.

**`data/`**
Plain Dart model classes only. No Flutter imports. `DirectorItem` and `KycItem` are immutable value objects that flow between layers. This is where repository implementations and API mappers would live when the app connects to a real backend.

**`domain/`**
Pure Dart enums and their extensions. All display logic with labels, colors, images is on the extension, so views have zero conditional branches based on state. `VerificationResultX.fromString()` safely converts route arguments back to typed values.

**`presentation/`**
Stateful and stateless widgets. Each step view owns only its own form controllers and selection state. `KYBView` owns page index state. No view imports another view's state.

---

## Screens and Flow

```
StartKYBView
    │
    └──► KYBView  (PageView — 4 steps)
              │
              ├── Step 1 · BusinessInfoView
              │         Business name, contact info, address, dropdowns
              │
              ├── Step 2 · BusinessRegInfoView
              │         Registration number, incorporation date, scope
              │
              ├── Step 3 · BeneficiaryOfficerView
              │         Add / edit / delete directors and UBO shareholders
              │
              └── Step 4 · DocumentUploadView
                          Upload incorporation cert, memorandum, shares, proof of address
                              │
                              └──► CheckStatusView  (pending / polling)
                                          │
                                          └──► KYBResultView
                                                    ├── Verified
                                                    └── Failed
```

---

## Navigation

Routes are defined as typed constants in `RouteService`. Arguments across routes are always passed as `.name` on a typed enum.

```dart
navigations.pushReplacementNamed(
  RouteService.verificationResult,
  arguments: VerificationResult.verified.name,
);

final result = VerificationResultX.fromString(option);
```

Page transitions are randomised from four strategies (fade, slide, scale, rotate) via `RouteService.randomTransition`.

---

## Reusable Widgets

| Widget | Purpose |
|---|---|
| `CustomButton` | Primary / secondary / outline button with loading state and icon support |
| `CustomTextfield` | Text input or dropdown — switches rendering based on `hasDrop` |
| `CustomAppBar` | App bar with back button guard and optional bottom slot |
| `CustomDialog` | Modal wrapper with typed `show<T>` static helper |
| `SelectionDialogContent` | Searchable list used inside `CustomDialog` |
| `DocumentUploadField` | Dotted-border file picker tile |
| `StepIndicator` | Animated step circles — completed steps show green tick |
| `DirectorCard` | Director row with edit / delete actions |
| `KycCard` | Director KYC status list with colored badges |
| `FeatureCard` | Info tile used on the start screen |
| `RequirementsCard` | Bulleted subtitle list |

---

## Mock Data

All development data lives in `MockKycData`. To move to a real API, each static list and getter would be replaced with a repository call with no view code changes.

| Key | Purpose |
|---|---|
| `businessTypes` | Business type dialog |
| `industries` | Industry dialog |
| `entities` | Entity type dialog |
| `countries` | Country dialog |
| `years` | Years in operation dialog |
| `scope` | Business scope multiselect |
| `roles` | Director role dialog |
| `directors` | Seed KYC director list for `CheckStatusView` |
| `seedDirectors` | Seed director list for `BeneficiaryOfficerView` — set to `[]` for blank state |
| `mockedResult` | Controls result screen — swap to `VerificationResult.failed` to test failure path |

---

## Improvements With Time

**Form validation**
All step views currently allow navigation without validating inputs. Adding a `GlobalKey<FormState>` with validators on each `CustomTextfield` would prevent progression until required fields are filled and correctly formatted.

**Persistent partial submission**
If the user closes the app mid-flow, all entered data is lost. Persisting each step's data to local storage and restoring it on re-open would significantly improve the experience.

**Real file picking and upload**
`DocumentUploadField` currently takes an `onTap` callback with no file picker integration. Wiring `file_picker` and uploading to a storage backend with upload progress feedback would complete this step.

**State management migration to Riverpod**
As form data needs to be shared across steps (e.g. pre-filling director email from business info), `setState` becomes limiting. Riverpod as an SM tool would handle cross-step state, API calls, and loading/error states cleanly without excessive boilerplate.

**Unit and widget tests**
No tests exist currently. Priority targets would be `VerificationResultX.fromString()`, `DirectorItem` computed getters, `CustomButton` enabled/disabled state, and the `BeneficiaryOfficerView` add/edit/delete director flow.


**Localisation**
All strings are currently hardcoded in English. Extracting them to ARB files via `flutter_localizations` would enable multi-language support with minimal structural change given the existing architecture and based on app reach.

---

## Adding a New Step

1. Create `my_view.dart` under `features/kyb/presentation/steps/`
2. Accept `required this.pageController` as a constructor parameter
3. Call `widget.pageController.nextPage(duration: ..., curve: ...)` on your continue button
4. Add the widget to the `PageView` children list in `kyb_view.dart`
5. Increment `_totalPages` in `_KYBViewState`

---

## Connecting a Real API

1. Define an abstract repository interface in `domain/`
2. Implement it in `data/` using your HTTP client (e.g. Dio, http)
3. Map API responses to the existing model classes (`DirectorItem`, `KycItem`)
4. Inject the repository into the relevant view via constructor or a provider
5. Remove seed values from `MockKycData` keep dialog option lists until they are also served by the API

---
