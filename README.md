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
- Category-based filtering
- Separate views for dog and cat symptoms
- Responsive design for mobile, tablet, and desktop
- Emergency vet contact button
- Pull-to-refresh for latest data
- Error handling and offline support

## Project Structure

```
lib/
├── models/
│   └── symptom.dart         # Data models
├── services/
│   └── pet_api_service.dart # API integration
├── repositories/
│   └── symptom_repository.dart  # Data management
├── screens/
│   ├── symptom_list_screen.dart    # Main list view
│   └── symptom_detail_screen.dart  # Detailed symptom view
└── main.dart               # App entry point
```

## Setup Instructions

### Prerequisites

1. Install Flutter SDK:
   ```bash
   # macOS
   brew install flutter

   # Windows
   # Download Flutter SDK from https://flutter.dev/docs/get-started/install/windows
   ```

2. Verify installation:
   ```bash
   flutter doctor
   ```

3. Clone the repository:
   ```bash
   git clone https://github.com/yourusername/pet_symptom_guide.git
   cd pet_symptom_guide
   ```

4. Install dependencies:
   ```bash
   flutter pub get
   ```

### Running the App

1. Run in debug mode:
   ```bash
   flutter run
   ```

2. Run in release mode:
   ```bash
   flutter run --release
   ```

3. Build for specific platforms:
   ```bash
   # Web
   flutter build web

   # Android
   flutter build apk

   # iOS
   flutter build ios
   ```

## API Integration

The app integrates with two public APIs:
- [Cat Facts API](https://cat-fact.herokuapp.com) - For cat-related facts
- [Dog API](https://api.thedogapi.com/v1) - For dog breeds and images

No API keys are required for basic functionality.

## Architecture

The application follows a clean architecture approach:
- **Models**: Core business entities
- **Services**: API integration layer
- **Repositories**: Data management and business logic
- **Screens**: UI components and state management

## Testing

Run tests with:
```bash
flutter test
```

## Building for Production

1. Web:
   ```bash
   flutter build web --release
   ```
   The output will be in `build/web`

2. Android:
   ```bash
   flutter build apk --release
   ```
   The APK will be in `build/app/outputs/flutter-apk/app-release.apk`

3. iOS:
   ```bash
   flutter build ios --release
   ```
   Open the generated Xcode project to archive and distribute

## Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Contact

For any questions or feedback, please open an issue in the GitHub repository.
