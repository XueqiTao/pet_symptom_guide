# Pet Symptom Guide

A Flutter application that helps pet owners identify and understand common pet symptoms, providing guidance on severity levels and recommended next steps. The app integrates with the Cat Facts API and Dog API to provide additional pet-related information.

## Features

- List of common pet symptoms with risk levels (Mild, Moderate, Urgent)
- Detailed symptom information including:
  - Description
  - Possible causes
  - Risk level indicators
  - Recommended next steps
  - Related symptoms
- Integration with external APIs:
  - Cat Facts API for interesting cat facts
  - Dog API for breed information and images
- Search functionality to quickly find symptoms
- Category-based filtering (Digestive, Skin, Movement, Urgent)
- Pet type switching between dogs and cats
- Responsive design for various screen sizes
- Pull-to-refresh for latest data
- Emergency vet contact button
- Clean and intuitive Material Design UI

## Project Structure

```
lib/
├── models/
│   └── symptom.dart         # Data models
├── repositories/
│   └── symptom_repository.dart  # Data access layer
├── services/
│   └── pet_api_service.dart    # API integration
├── screens/
│   ├── symptom_list_screen.dart    # Main list view
│   └── symptom_detail_screen.dart  # Detailed symptom view
└── main.dart               # App entry point
```

## Technologies Used

- Flutter SDK
- Dart
- HTTP package for API calls
- Material Design
- External APIs:
  - Cat Facts API (https://cat-fact.herokuapp.com)
  - Dog API (https://api.thedogapi.com)

## Getting Started

### Prerequisites

- Flutter SDK (latest version)
- Dart SDK (latest version)
- An IDE (VS Code, Android Studio, or IntelliJ)
- Git

### Installation

1. Clone the repository:
```bash
git clone [repository-url]
cd pet_symptom_guide
```

2. Install dependencies:
```bash
flutter pub get
```

3. Run the app:
```bash
# Debug mode
flutter run

# Release mode
flutter run --release
```

## Architecture

The application follows a clean architecture approach with:

- **Models**: Core business entities
- **Repositories**: Data access layer managing both local and remote data
- **Services**: API integration layer
- **Screens**: UI components with state management

## API Integration

The app integrates with two APIs from the public-apis list:

1. **Cat Facts API**
   - Endpoint: https://cat-fact.herokuapp.com
   - Used for: Retrieving interesting cat facts

2. **Dog API**
   - Endpoint: https://api.thedogapi.com
   - Used for: Fetching dog breeds and random dog images

## Features Implementation

### List Screen
- Displays 10+ symptoms with scrollable list/grid view
- Implements search and category filtering
- Shows API-powered pet information
- Responsive layout for different screen sizes

### Detail Screen
- Shows comprehensive symptom information
- Includes risk level indicators
- Lists possible causes and next steps
- Features emergency contact button
- Displays related symptoms

## Future Enhancements

- Offline support with local database
- User authentication
- Symptom history tracking
- Multi-language support
- Dark mode
- Integration with veterinary appointment scheduling

## Contributing

Feel free to submit issues and enhancement requests.

## License

This project is licensed under the MIT License - see the LICENSE file for details.
