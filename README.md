# AI Chat Bot & Image Generator

A modern Flutter application that leverages powerful LLMs for conversational AI and image generation using the **Open Router API**.

## 🚀 Features

- **Smart Chatting**: Powered by `google/gemini-3.1-flash-lite` for fast and intelligent responses.
- **Image Generation**: Create stunning visuals using `google/gemini-2.5-flash-image`.
- **Clean Architecture**: Implemented using **MVVM (Model-View-ViewModel)** for scalability and maintainability.
- **State Management**: Managed efficiently with **Provider**.
- **Modern UI**:
  - Interactive chat interface.
  - Smooth "three dots" typing animation.
  - Auto-scrolling and "scroll to bottom" shortcut.
  - Responsive design.
- **Secure Configuration**: Uses `flutter_dotenv` to protect API keys in a `.env` file.

## 📸 Screenshots

| Splash Screen | Chat Screen | Loading Screen | Image-gen Screen |
|:-------------:|:-----------:|:--------------:|:----------------:|
|               |             |                |                  |

## 🛠️ Project Structure

The project follows the **Clean Architecture** principles:

```text
lib/
├── core/           # Constants, themes, and utility classes
├── data/           # Repositories and API service implementations
├── domain/         # Entities and business logic (use cases)
├── presentation/   # UI Screens, Widgets, and Providers (MVVM)
└── main.dart       # App entry point
```

## ⚙️ Setup Instructions

1.  **Clone the repository**:
    ```bash
    git clone <repository-url>
    ```

2.  **Install dependencies**:
    ```bash
    flutter pub get
    ```

3.  **Configure Environment Variables**:
    - Create a `.env` file in the root directory.
    - Add your Open Router API key:
      ```env
      CHAT_API_KEY=your_api_key_here
      ```

4.  **Run the app**:
    ```bash
    flutter run
    ```

## 📦 Dependencies

- [provider](https://pub.dev/packages/provider): State management.
- [http](https://pub.dev/packages/http): API requests.
- [flutter_dotenv](https://pub.dev/packages/flutter_dotenv): Secure environment configuration.
- [cupertino_icons](https://pub.dev/packages/cupertino_icons): Default icons.

---
Developed with ❤️ using Flutter.
