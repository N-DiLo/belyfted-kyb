# BelyftedKYB

A Flutter application for business identity verification (Know Your Business). The app guides business owners through a structured, multi-step KYB flow that collects business information, registration details, director/UBO data, and supporting documents before final submission for review.

---

## Features

- Multi-step KYB verification flow (4 steps) with animated step indicator
- Business information and registration detail collection
- Director and Ultimate Beneficiary Officer (UBO) management with add, edit, and delete
- Document upload with camera, gallery, and file browser support
- Content dialogs with live search for country, industry, role, etc.
- Form validation with `ValueNotifier`-driven button state per step
- Verification result screen (success / failure) with live toggle for testing
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

| Concern          | Choice                                |
| ---------------- | ------------------------------------- |
| Language         | Dart                                  |
| Framework        | Flutter                               |
| Screen sizing    | Vize (figma-based responsive scaling) |
| State management | Riverpod (`flutter_riverpod`)         |
| Dotted borders   | `dotted_border`                       |
| Image picker     | `image_picker`                        |
| File picker      | `file_picker`                         |
| Navigation       | Named routes via `RouteService`       |

---

## State Management Approach

The app uses **Riverpod** (`flutter_riverpod`) for cross-step state management via a single `KYBSubmissionNotifier`.

**Why Riverpod?**

The KYB flow collects data across four independent step views that each need to contribute to a single submission object passed to `CheckStatusView`. With `setState` alone, `KYBView` had to hold 18+ local fields and thread them as named callbacks into every step widget. This made the constructor signatures verbose and tightly coupled, even adding or renaming a field required changes in three places.

Riverpod solves this cleanly:

- Each step writes its slice of data directly to `KYBSubmissionNotifier` via `ref.read(...notifier).updateX()`
- `KYBView` no longer holds any form data but reads it `.toModel()` once at the end to build the submission
- `KYBSubmissionState` is immutable with `copyWith`, preventing accidental mutation across steps
- `reset()` on the notifier clears the entire form in one call after a successful submission
- Steps are fully decoupled from each other and from `KYBView`

Local `setState` and `ValueNotifier` are still used within each step view for form controller listeners, dropdown selections, and button enabled state which are purely local concerns and don't need to leave the widget.

---

## Implementation Decisions

**Clean Architecture in a single feature**
The code is split into `data`, `domain`, and `presentation` layers. Model classes have no Flutter imports, enums carry all display logic via extensions, and views contain zero business logic conditionals. The structure scales cleanly if new features are added.

**Enums over strings for state and routing**
`VerificationResult` and `KycStatus` are typed enums with extensions that own their labels, colors, and images. Route arguments are passed as `enum.name` and converted back via `fromString()`.

**Inline director form with `Visibility` + `maintainState`**
Rather than pushing a new route for adding a director, the form renders inline within the same `ListView` using `Visibility(maintainState: true)`. This preserves the multi-step indicator at the top of the screen without any navigation transition.

**`ValueNotifier` for per-step button gating**
Each step uses a `ValueNotifier<bool>` passed to `CustomButton` `enabledListenable`. Required controllers are collected in a list and share a single `_updateCanProceed` listener with a required field adding it to the list only. The Continue button is disabled until all required fields and dropdowns are filled.

**`CustomDialog` with a generic `show<T>` helper**
All dialog contents (country, industry, role, etc.) use a single `DialogContent` widget with live search, wrapped in `CustomDialog.show<String>()`. The typed generic returns `String?` directly with no casting.

**`CustomTextfield` handles both text and dropdown**
`hasDrop: true` switches `CustomTextfield` from `TextFormField` to `DropdownButtonFormField`. For dialog-based selections (country, role), `readOnly: true` + `onTap` opens `CustomDialog` instead, keeping the interaction consistent.

**Document upload with three source options**
`DocumentUploadField` opens a `CustomDialog` with three picker options — camera (`image_picker`), gallery (`image_picker`), and file browser (`file_picker` supporting PDF, DOC, JPG, PNG). The Continue button on the upload step stays disabled until all required documents are uploaded via `ValueNotifier`.

**Randomised page transitions**
`RouteService` picks randomly from four transition strategies (fade, slide, scale, rotate) on every navigation.

---

## Project Structure

```
lib/
├── core/
│   ├── packages/
│   │   └── packages.dart                      # All Used packages exported
│   ├── navigators/
│   │   └── navigators.dart                    # Navigations and router class exposed
│   └── shared/
│       ├── constants/
│       |    ├── app_colors.dart               # All MaterialColor tokens
│       |    └── app_images.dart               # Asset path constants
│       └── widgets/
│           ├── custom_app_bar.dart
│           ├── custom_button.dart
│           ├── custom_dialog.dart
│           ├── custom_textfield.dart
│           ├── document_upload_field.dart
│           ├── dotted_border_button.dart
│           ├── image_widget.dart
│           ├── dialog_content.dart
│           ├── step_indicator.dart
│           └── verification_image.dart
│
├── features/
│   └── kyb/
│       ├── data/
│       │   └── models/
│       │       ├── director_item.dart
│       │       ├── kyb_submission_model.dart
│       │       └── mock_data.dart
│       ├── domain/
│       │   ├── verification_result.dart
│       │   ├── kyb_state.dart                  # Riverpod State
|       |   └── kyb_notifier.dart               # Riverpod Notifier
│       └── presentation/
│           ├── kyb_view.dart
│           ├── start_kyb_view.dart
│           ├── kyb_result_view.dart
│           ├── check_status_view.dart
│           ├── steps/
│           |   ├── business_info_view.dart
│           |   ├── business_reg_info_view.dart
│           |   ├── beneficiary_officer_view.dart
│           |   └── document_upload_view.dart
│           └── widgets/
│               ├── dialog_content.dart
│               ├── feature_card.dart
│               └── director_card.dart
│
├── belyfted_kyb.dart                         # App entry point (MaterialApp)
└── main.dart                                 # ProviderScope root
```

---

## Architecture

The app uses a lightweight **Clean Architecture** approach suited to a single-feature Flutter app.

### Layers

**`core/`**
Shared primitives with no feature knowledge. Widgets accept plain parameters and emit callbacks. Colors and images live here so they can be swapped without touching feature code.

**`data/`**
Plain Dart model classes only. No Flutter imports. `DirectorItem` and `KYBSubmissionModel` are immutable value objects. This is where repository implementations and API mappers would live when connecting to a real backend.

**`domain/`**
Riverpod `Notifier` and state class. `KYBSubmissionState` is immutable with `copyWith`. Each step calls one `updateX` method. `toModel()` converts state to `KYBSubmissionModel` for routing.

**`presentation/`**
`ConsumerStatefulWidget` step views that write to the notifier on continue. `KYBView` owns only page index state. No view holds cross-step data.

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
              │         Tax ID, registered country/year, scope, description
              │
              ├── Step 3 · BeneficiaryOfficerView
              │         Add / edit / delete directors and UBO shareholders
              │
              └── Step 4 · DocumentUploadView
                          Camera / gallery / file upload per document type
                              │
                              └──► CheckStatusView  (submission summary + KYC status)
                                          │
                                          └──► KYBResultView
                                                    ├── Verified
                                                    └── Failed
```

---

## Navigation

Routes are defined as typed constants in `RouteService`. Arguments are always passed as `.name` on a typed enum — no magic strings cross route boundaries.

```dart
navigations.pushReplacementNamed(
  RouteService.verificationResult,
  arguments: VerificationResult.verified.name,
);

final result = VerificationResultX.fromString(option);
```

`KYBSubmissionModel` is passed as the route argument to `CheckStatusView`:

```dart
navigations.pushReplacementNamed(
  RouteService.checkStatus,
  arguments: ref.read(kybSubmissionProvider).toModel(),
);
```

Page transitions are randomised from four strategies (fade, slide, scale, rotate) via `RouteService.randomTransition`.

---

## Reusable Widgets

| Widget                | Purpose                                                                                      |
| --------------------- | -------------------------------------------------------------------------------------------- |
| `CustomButton`        | Primary / secondary / outline button with loading state, icon, and `ValueListenable` support |
| `CustomTextfield`     | Text input or dropdown — switches rendering based on `hasDrop`                               |
| `CustomAppBar`        | App bar with back button and optional bottom slot                                            |
| `CustomDialog`        | Modal wrapper with typed `show<T>` static helper                                             |
| `DialogContent`       | Searchable list used inside `CustomDialog`                                                   |
| `DocumentUploadField` | Dotted-border upload tile with camera / gallery / file picker dialog                         |
| `ImageWidget`         | Unified image renderer for asset/network PNG and SVG with optional shadow                    |
| `VerificationImage`   | Container with rectangle and circular shaped color-matched box shadow for result icons       |
| `StepIndicator`       | Animated step circles — completed steps show green tick                                      |
| `DirectorCard`        | Director row with edit / delete actions                                                      |
| `KycCard`             | Director KYC status list with colored badges and resend link                                 |
| `FeatureCard`         | Info tile used on the start screen                                                           |
| `RequirementsCard`    | Bulleted subtitle list                                                                       |

---

## Mock Data

All development data lives in `MockKycData`. To move to a real API, replace each static list and getter with a repository call — no view code changes required.

| Key             | Purpose                                                                           |
| --------------- | --------------------------------------------------------------------------------- |
| `businessTypes` | Business type dialog                                                              |
| `industries`    | Industry dialog                                                                   |
| `entities`      | Entity type dialog                                                                |
| `countries`     | Country dialog                                                                    |
| `years`         | Years in operation dialog                                                         |
| `scope`         | Business scope dialog                                                             |
| `roles`         | Director role dialog                                                              |
| `kycDirectors`  | Seed KYC director list for `CheckStatusView`                                      |
| `seedDirectors` | Seed director list for `BeneficiaryOfficerView` — set to `[]` for blank state     |
| `mockedResult`  | Controls result screen — swap to `VerificationResult.failed` to test failure path |

---

## Improvements With More Time

**Persistent partial submission**
If the user closes the app mid-flow, all entered data is lost. Persisting `KYBSubmissionState` to local storage and restoring it on re-open would significantly improve the experience.

**Real file upload with progress**
`DocumentUploadField` picks files locally but does not upload them. Wiring a storage backend (e.g. S3 or Firebase Storage) with per-file upload progress indicators would complete the document step.

**Unit and widget tests**
No tests exist currently. Priority targets: `VerificationResultX.fromString()`, `KYBSubmissionNotifier` state transitions, `CustomButton` enabled/disabled via `ValueListenable`, and the `BeneficiaryOfficerView` add/edit/delete director flow.

**Localisation**
All strings are currently hardcoded in English. Extracting them to ARB files via `flutter_localizations` would enable multi-language support with minimal structural change given the existing architecture and based on app reach.

**Director KYC deep link**
Directors added in step 3 currently show as pending in `CheckStatusView`. Generating and sending a KYC verification link per director email, then polling status, would complete the real verification flow.

---

## Adding a New Step

1. Create `my_view.dart` under `features/kyb/presentation/steps/`
2. Extend `ConsumerStatefulWidget` and accept `required this.pageController`
3. Add an `updateX` method to `KYBSubmissionNotifier` for the new step's data
4. Call `ref.read(kybSubmissionProvider.notifier).updateX(...)` before `pageController.nextPage`
5. Add the widget to the `PageView` children list in `kyb_view.dart`
6. Increment `_totalPages` in `_KYBViewState`

---

## Connecting a Real API

1. Define an abstract repository interface in `domain/`
2. Implement it in `data/` using your HTTP client (e.g. Dio, http)
3. Map API responses to the existing model classes (`DirectorItem`, `KycItem`)
4. Inject the repository as a Riverpod provider and read it inside `KYBSubmissionNotifier`
5. Remove seed values from `MockKycData` to keep dialog option lists until they are also served by the API

---
