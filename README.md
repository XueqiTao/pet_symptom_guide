# Pet Symptom Guide

A Flutter application designed to help pet owners identify and understand common symptoms in dogs and cats. The app provides a user-friendly interface to search and filter through various symptoms, categorized by severity and type.

## Features

- 🐱🐶 Support for both cats and dogs
- 🔍 Search functionality to quickly find specific symptoms
- 📊 Symptoms categorized by system (Digestive, Skin, Movement, etc.)
- ⚠️ Risk level indicators (Mild, Moderate, Urgent)
- 🎨 Modern and intuitive UI design
- 📱 Responsive layout for both mobile and desktop

## Screenshots

### List Screen
![List Screen](assets/screenshots/list_screen.png)
*Main screen showing the list of symptoms with search, filtering, and risk level indicators*

### Detail Screen
![Detail Screen](assets/screenshots/detail_screen.png)
*Detailed view of a symptom showing risk level, description, causes, and recommended steps*

## Key Features

### Core Functionality
- **Symptom Browsing**: Browse through a comprehensive list of common pet symptoms
- **Detailed Information**: Access detailed information about each symptom including:
  - Risk level assessment (Mild, Moderate, Urgent)
  - Possible causes
  - Recommended next steps
  - Related symptoms
  - Common conditions

### User Interface
- **Intuitive Navigation**
  - Category-based filtering (Digestive, Skin, Movement, Urgent)
  - Pet type switching between dogs and cats (🐕/🐈)
  - Search functionality for quick symptom lookup
  - Risk level indicators with color coding:
    - Mild: Green
    - Moderate: Amber
    - Urgent: Red
  - Emergency contact button for urgent cases

### Smart Features
- **Intelligent Filtering**
  - Pet-specific symptom display
  - Category-based organization
  - Risk level classification
- **Search Capabilities**
  - Real-time search results
  - Search across symptom names and descriptions
  - Category-aware search results

## Technical Implementation

### Architecture
```
lib/
├── blocs/           # Business Logic Components
│   ├── symptom_bloc.dart
│   ├── symptom_event.dart
│   └── symptom_state.dart
├── models/          # Data models
│   └── symptom.dart
├── repositories/    # Data layer
│   └── symptom_repository.dart
├── screens/         # UI screens
│   ├── symptom_list_screen.dart
│   └── symptom_detail_screen.dart
└── main.dart        # Application entry point
```

### Key Components
- **SymptomRepository**: Implements singleton pattern for centralized data management
- **InfermedicaApiService**: Handles API integration (simulated in current version)
- **Symptom Model**: Comprehensive data model for symptom information
- **Risk Level System**: Three-tier classification (Mild, Moderate, Urgent)

### Data Management
- In-memory caching for improved performance
- Efficient filtering and search algorithms
- Mock data implementation for development
- Prepared for API integration

## Getting Started

### Prerequisites

- Flutter SDK (latest stable version)
- Chrome browser (for web development)
- Git

### Installation

1. Clone the repository:
```bash
git clone [your-repository-url]
```

2. Navigate to the project directory:
```bash
cd pet_symptom_guide
```

3. Install dependencies:
```bash
flutter pub get
```

4. Run the application:
```bash
flutter run -d chrome
```

## Project Structure

```
lib/
├── blocs/           # Business Logic Components
│   ├── symptom_bloc.dart
│   ├── symptom_event.dart
│   └── symptom_state.dart
├── models/          # Data models
│   └── symptom.dart
├── repositories/    # Data layer
│   └── symptom_repository.dart
├── screens/         # UI screens
│   ├── symptom_list_screen.dart
│   └── symptom_detail_screen.dart
└── main.dart        # Application entry point
```

## Architecture

The application follows the BLoC (Business Logic Component) pattern for state management:
- **Models**: Define the data structures
- **Repositories**: Handle data operations
- **BLoCs**: Manage application state and business logic
- **Screens**: Present the UI and handle user interactions

## Dependencies

- `flutter_bloc`: State management
- `equatable`: Value equality comparison
- Other Flutter standard libraries

## Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Acknowledgments
- Flutter team for the excellent framework
- Infermedica API for the medical knowledge base
- Contributors and maintainers

## Support
For support, please open an issue in the repository or contact the maintainers.
