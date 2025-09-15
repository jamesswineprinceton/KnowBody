# KnowBody

A medical social networking iOS app built with SwiftUI and Firebase, designed to connect medical professionals and for case discussions and knowledge sharing.

## About

KnowBody is a specialized social media platform for the medical community where users can:
- Share medical cases and seek expert opinions
- Connect with professionals across various medical specialties
- Engage in educational discussions about complex medical scenarios
- Build a professional network within the healthcare field

## Features

### Core Functionality
- **User Authentication** - Secure login and registration with Firebase Auth
- **Medical Case Feed** - Browse and interact with medical cases shared by the community
- **Case Creation** - Post detailed medical cases with:
  - Patient demographics (age, sex)
  - Medical history indicators
  - Specialty targeting
  - Detailed case descriptions
- **Specialty Filtering** - Target specific medical specialties for focused discussions
- **User Profiles** - Professional profiles with medical specialty information
- **Explore** - Discover new cases and connect with other medical professionals
- **Notifications** - Stay updated on case responses and interactions

### Architecture
- **MVVM Pattern** - Clean separation of concerns with ViewModels
- **Firebase Integration** - Real-time data synchronization
- **SwiftUI** - Modern, declarative UI framework
- **Modular Design** - Well-organized code structure by feature

## Tech Stack

- **Framework**: SwiftUI
- **Backend**: Firebase
  - Authentication
  - Firestore Database
  - Storage
  - Functions
  - Analytics
- **Image Handling**: Kingfisher
- **Architecture**: MVVM
- **Language**: Swift

## Requirements

- iOS 15.0+
- Xcode 14.0+
- Firebase account and project setup

## Getting Started

### Prerequisites

1. **Xcode**: Install the latest version of Xcode from the App Store
2. **Firebase Project**: Create a new Firebase project at [Firebase Console](https://console.firebase.google.com/)

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/jamesswineprinceton/KnowBody.git
   cd KnowBody
   ```

2. **Firebase Setup**
   - Go to your Firebase Console
   - Create a new iOS app in your Firebase project
   - Download the `GoogleService-Info.plist` file
   - Add it to the `KnowBody/` directory in Xcode
   - **Important**: The `GoogleService-Info.plist` file is gitignored for security

3. **Firebase Services Configuration**
   Enable the following Firebase services in your console:
   - **Authentication** (Email/Password)
   - **Firestore Database**
   - **Storage**
   - **Functions** (optional)

4. **Open the project**
   ```bash
   open KnowBody.xcodeproj
   ```

5. **Build and Run**
   - Select your target device or simulator
   - Press `Cmd + R` to build and run

## Project Structure

```
KnowBody/
├── App/
│   └── KnowBodyApp.swift          # Main app entry point
├── Core/
│   ├── Authentication/            # Login/Registration
│   ├── Feed/                     # Main case feed
│   ├── Create/                   # Case creation
│   ├── Explore/                  # Discovery features
│   ├── Profile/                  # User profiles
│   ├── Notifications/            # Push notifications
│   ├── TabBar/                   # Main navigation
│   └── Components/               # Reusable UI components
├── Model/                        # Data models
├── Services/                     # Firebase services
├── Extensions/                   # Swift extensions
└── Utils/                        # Utilities and modifiers
```

## Security

This project implements several security best practices:
- Firebase configuration files are gitignored
- User authentication through Firebase Auth
- Secure data storage with Firestore security rules
- Input validation and sanitization

## Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Author

**James Swinehart**
- Email: jamesswine@princeton.edu
- GitHub: [@jamesswineprinceton](https://github.com/jamesswineprinceton)

## Acknowledgments
- Doctors and interns at MercyMed of Columbus, who provided insights for the app design

---

**Note**: This app is designed for educational and professional medical discussions. Always consult with qualified healthcare providers for actual medical advice. This app is in the process of seeking legal compliance, but should not yet be used for official medical advice.
