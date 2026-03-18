# BelyftedKYB

A Flutter application for business identity verification (Know Your Business). The app guides business owners through a structured, multi-step KYB flow — collecting business information, registration details, director/UBO data, and supporting documents — before submitting for review.

---

## Features

- Multi-step KYB verification flow (4 steps) with animated step indicator
- Business information and registration detail collection
- Director and Ultimate Beneficiary Officer (UBO) management with add, edit, and delete
- Document upload with dotted-border file picker
- Selection dialogs with live search for dropdowns (country, industry, role, etc.)
- Verification result screen (success / failure)
- KYC status tracking per director (verified, pending, failed)
- Animated page transitions (fade, slide, scale, rotate)
- Fully responsive using Vize screen adaptation

---

## Tech Stack

| Concern          | Choice                                 |
| ---------------- | -------------------------------------- |
| Language         | Dart                                   |
| Framework        | Flutter                                |
| Screen sizing    | Vize (figma-based responsive scaling)  |
| Dotted borders   | `dotted_border`                        |
| Navigation       | Named routes via `RouteService`        |
| State management | Local `setState` (no external package) |

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
│           ├── selection_dialog_content.dart
│           └── step_indicator.dart
│
├── features/
│   └── kyb/
│       ├── data/
│       │   └── models/
│       │       ├── director_item.dart
|       |       └── mock_data.dart
│       ├── domain/
│       │   └── enums/
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
Shared primitives with no feature knowledge. Widgets here accept plain parameters and emit callbacks. Colors, images here so they can be swapped without touching feature code.

**`data/`**
Plain Dart model classes only. No Flutter imports. `DirectorItem` and `KycItem` are immutable value objects that flow between layers. This is where repository implementations and API mappers would live when the app connects to a real backend.

**`domain/`**
Pure Dart enums and their extensions. All display logic — labels, colors, images — is on the extension, so views have zero conditional branches based on state. `VerificationResultX.fromString()` safely converts route arguments back to typed values.

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

Routes are defined as typed constants in `RouteService`. Arguments across routes are always passed as `.name` on a typed enum — no magic strings cross route boundaries.

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

| Widget                |
| --------------------- |
| `CustomButton`        |
| `CustomTextfield`     |
| `CustomAppBar`        |
| `CustomDialog`        |
| `DialogContent`       |
| `CustomDialog`        |
| `DocumentUploadField` |
| `StepIndicator`       |
| `DirectorCard`        |
| `KycCard`             |
| `FeatureCard`         |
| `RequirementsCard`    |

---

## Mock Data

All development data lives in `MockKycData`. To move to a real API, replace each static list and getter with a repository call — no view code changes.

| Key             | Purpose                                                                           |
| --------------- | --------------------------------------------------------------------------------- |
| `businessTypes` | Business type dialog                                                              |
| `industries`    | Industry dialog                                                                   |
| `entities`      | Entity type dialog                                                                |
| `countries`     | Country dialog                                                                    |
| `years`         | Years in operation dialog                                                         |
| `scope`         | Business scope multiselect                                                        |
| `roles`         | Director role dialog                                                              |
| `directors`     | Seed KYC director list for `CheckStatusView`                                      |
| `seedDirectors` | Seed director list for `BeneficiaryOfficerView` — set to `[]` for blank state     |
| `mockedResult`  | Controls result screen — swap to `VerificationResult.failed` to test failure path |

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

## Adding a New Step

1. Create `my_view.dart` under `features/kyb/presentation/view/`
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
5. Remove seed values from `MockKycData` — keep dropdown option lists until they are also served by the API

---
