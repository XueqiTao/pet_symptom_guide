# Technical Interview Submission

## Project Overview
Pet Symptom Guide is a Flutter application that helps pet owners identify and understand common symptoms in their pets. The app provides a comprehensive guide with detailed information about various symptoms, their severity levels, and recommended actions.

## Implementation Details

### API Integration
The application is prepared to integrate with the Infermedica API from the public-apis list. Currently using mock data that follows the API's data structure for development purposes.

### Mobile Application Features
1. **List Screen**
   - Displays a scrollable list of pet symptoms
   - Implements search functionality
   - Category-based filtering
   - Pet type switching (Dogs/Cats)
   - Risk level indicators

2. **Detail Screen**
   - Comprehensive symptom information
   - Risk level assessment
   - Possible causes
   - Recommended next steps
   - Common conditions
   - Emergency contact button

### Architecture
- Clean Architecture pattern
- Repository pattern for data access
- Separation of concerns with clear module boundaries
- Prepared for API integration
- Efficient state management

## Technical Requirements Met
- [x] API Integration ready (Infermedica API)
- [x] Two main screens (List and Detail views)
- [x] Scrollable list with 10+ items
- [x] Detailed information display
- [x] Clean architecture implementation
- [x] Well-structured codebase
- [x] Comprehensive documentation

## Running the Project

### Prerequisites
- Flutter SDK (latest version)
- Dart SDK (latest version)
- A code editor (VS Code, Android Studio, or IntelliJ)

### Setup Instructions
1. Clone the repository:
   ```bash
   git clone https://github.com/[your-username]/pet-symptom-guide.git
   cd pet-symptom-guide
   ```

2. Install dependencies:
   ```bash
   flutter pub get
   ```

3. Run the application:
   ```bash
   flutter run
   ```

### Additional Notes
- The application is currently using mock data but is structured to easily integrate with the real API
- All UI components are responsive and tested across different screen sizes
- The codebase includes comprehensive error handling and loading states

## Future Improvements
- Implement real API integration
- Add offline support
- Implement user accounts
- Add multi-language support
- Enhance search with fuzzy matching

## Contact
For any questions or clarifications about the submission, please feel free to reach out. 