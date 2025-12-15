# 🔐 Google Sign-In using Google Native OAuth Client

> A Flutter project demonstrating Google Sign-In using Google's Native OAuth Client, featuring a sign-in page that initializes the `google_sign_in` package with OAuth client IDs, listens for authentication events via streams, and upon successful authentication navigates to a user details page displaying the user's name, email, photo, and ID—with support for Android platform using `auto_route` for navigation.

---

## 📋 Table of Contents

- [Getting Started](#getting-started)
- [What is OAuth?](#what-is-oauth)
- [OAuth Setup with Google Console](#oauth-with-google-console)
- [Implementation](#implementation)
- [References](#references)

---

## 🚀 Getting Started

### Prerequisites

| Requirement | Description |
|-------------|-------------|
| ✅ Flutter Project | With valid namespace and SHA-1 key |
| ✅ google_sign_in | [Package](https://pub.dev/packages/google_sign_in) installed |

---

## 🔑 What is OAuth?

OAuth, or **Open Authorization**, is a widely adopted authorization framework that allows you to consent to an application interacting with another on your behalf without having to reveal your password. It does this by providing access tokens to third-party services without exposing user credentials.

---

## ☁️ OAuth with Google Console

### Step 1: Login/Signup to Google Cloud Console

Visit: [Google Cloud Console](https://rb.gy/lx65v4)

### Step 2: Create a New Project

Create a project using the project name and organization (if involved):
[Create Project](https://console.cloud.google.com/projectcreate?previousPage=%2Fwelcome%3Fproject%3Dbamboo-pact-481004-p8&organizationId=0)

### Step 3: Enable APIs and Services

1. Click the created project
2. Search **APIs and Services** under Quick Access
3. Click on it

### Step 4: Enable Google People API

Tap on the **`+ Enable APIs and Services`** button in the header and enable the **Google People API**.

### Step 5: Configure OAuth Consent Screen

Navigate to **API and Services Dashboard** → Click **OAuth consent Screen**

### Step 6: Complete Project Configuration

Provide the following information:
- 📱 App Information
- 👥 Audience
- 📧 Contact Information

> ⚠️ **Important:** Be careful when naming your app. Certain names are unacceptable.

| ❌ Unacceptable Names | ✅ Acceptable Names |
|----------------------|---------------------|
| Google | Photo Browser |
| YouTube | Inbox Assistant |
| Google+ Online | PDF Viewer for Google Drive |
| Google Drive for iOS | Top YouTube Videos |
| Mobile YouTube app | |
| Gmail for Android | |
| Google Photo App | |

### Step 7: Create OAuth Client

Once successfully set up, head to **OAuth Overview** → Click **[Create OAuth Client](https://console.cloud.google.com/auth/clients/create?project=Project_name-id)**

> 💡 Replace `project=Project_name-id` with your own project ID.

### Step 8: Select Application Type

Choose from the following application types:

- 🌐 Web Application
- 🤖 Android
- 🔌 Chrome Extension
- 🍎 iOS
- 📺 TV and Limited Input Devices
- 🖥️ Desktop App
- 🪟 Universal Windows Platform

*For this guide, we're selecting **Android**.*

### Step 9: Configure Android Details

Fill in the required information:

| Field | Example Value |
|-------|---------------|
| **Name** | `Android client 1` |
| **Package Name** | `com.org.namespace.name` |
| **SHA-1 Key** | `AA:BB:CC:DD:EE:FF:11:22:33:44:55:66:77:88:99:00:AA:BB:CC:DD` |

> 📝 **Tips for SHA-1 Key:**
> ```bash
> cd android
> ./gradlew signingReport
> ```
> - You'll get keys for different environments: `debug`, `release`, and `profile`
> - Use the appropriate key for your environment to avoid errors

### Step 10: Download Credentials

After successful setup, you'll receive:
- 🔑 Client ID
- 📄 JSON file (download for later use)

### Step 11: Create Web Application Client

> ⚠️ **Important:** Setting up only Android isn't sufficient!

For `serverClientId`, repeat **Step 8 - Step 10** by selecting **Web Application** as the Application Type.

### Step 12: Obtain Required IDs

For the [google_sign_in](https://pub.dev/packages/google_sign_in) package, you'll need:
- `clientId` (from Android client)
- `serverClientId` (from Web Application client)

---

## 💻 Implementation

### Initialize Google Sign-In

```dart
Future<void> _initializeGoogleSignIn() async {
  final GoogleSignIn signIn = GoogleSignIn.instance;

  try {
    await signIn.initialize(
      clientId: "android_client_id",
      serverClientId: "web_application_client_id",
    );

    // Set up the authentication event listener only once
    _authSubscription = signIn.authenticationEvents.listen(
      _handleAuthenticationEvent,
      onError: _handleAuthenticationError,
    );

    // Attempt lightweight authentication to check if user is already signed in
    // signIn.attemptLightweightAuthentication();
  } catch (error) {
    debugPrint('Google Sign-In initialization failed: $error');
  }
}
```

### Sign-In Button Handler

```dart
onPressed: () async {
  setState(() {
    _isLoading = true;
  });

  try {
    await GoogleSignIn.instance.authenticate();
  } catch (e) {
    debugPrint('Caught: $e');
    setState(() {
      _isLoading = false;
    });

    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Authentication failed: $e'),
        ),
      );
    }
  }
},
```

---

## 📚 References

| Resource | Link |
|----------|------|
| 📦 google_sign_in Package | [pub.dev](https://pub.dev/packages/google_sign_in) |
| ☁️ Google Cloud Console | [OAuth 2.0 Documentation](https://developers.google.com/identity/protocols/oauth2) |
| 📝 Medium Post | [Flutter Google Sign-In Without Firebase](https://medium.com/codebrew/flutter-google-sign-in-without-firebase-3680713966fb) |

---

<div align="center">

### 💬 Developer Vibes

| Style | Footer |
|:-----:|--------|
| 🔐 | Made with `clientId` confusion and `serverClientId` enlightenment |
| 🔑 | Made with *"Why isn't it working?"* → checks SHA-1 → works |
| 🐛 | Made with `print('here')` debugging — like a professional |
| ☕ | Made with hot reload expectations and hot restart reality |
| 🎯 | Made with Flutter 💙 and too many OAuth tabs open |

---



*— for Flutter Developers*

</div>