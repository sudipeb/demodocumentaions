# Google Sign in using Google Native Oauth Client

This Flutter project demonstrates Google Sign-In using Google's Native OAuth Client, featuring a sign-in page that initializes the google_sign_in package with OAuth client IDs, listens for authentication events via streams, and upon successful authentication navigates to a user details page displaying the user's name, email, photo, and ID—with support for Android platform using auto_route for navigation.

## Getting Started

### What is Oauth?
OAuth, or open authorization, is a widely adopted authorization framework that allows you to consent to an application interacting with another on your behalf without having to reveal your password. It does this by providing access tokens to third-party services without exposing user credentials. 

## Oauth With Google Console:
Oauth using google cloud console for flutter involves following steps:
### Step 1: Login/Signup Google Cloud Console ID
For Login/Signup the google cloud Console visit to: https://rb.gy/lx65v4
### Step 2: Create a new Project
Create an Project using the project name and organization(if involved) using https://console.cloud.google.com/projectcreate?previousPage=%2Fwelcome%3Fproject%3Dbamboo-pact-481004-p8&organizationId=0
### Step 3: click the Created Project and search APIs and Services under Quick Access on the project screen and Click that.
### Step 4: Tap on {+ Enable Api and Services} icon in header and enable Google People API.
### Step 5: Navigate to API and Services Dashboard and click OAuth consent Screen.
### Step 6: Configure the project by Providing App Information, Audience, Contact Information and Finish.
Points to Remember: While naming the app we must be careful as certain names are Unacceptable. Here's overview of acceptable and unacceptable names:
#### Examples of unacceptable names:

- Google
- YouTube
- Google+ Online
- Google Drive for iOS
- Mobile YouTube app
- Gmail for Android
- Google Photo App

#### Examples of acceptable names:

- Photo Browser
- Inbox Assistant
- PDF Viewer for Google Drive
- Top YouTube Videos
### Step 7: Once Successfully setupped you head on to Oauth Overview. On the Metrics Overview, Click on [Create OAuth Client](https://console.cloud.google.com/auth/clients/create?project=Project_name-id)
You can replace project=Project_name-id with your own project.
### Step 8: Now Create OAuth client ID by selecting the Application type:
Application Type includes:
- Web Application
-  Android
- Chrome Extension
- ios
- Tv and limited input devices
- Desktop App
- Universal Windows Platform
For now I am picking Android.
### Step 9: Since we decided to make on Android, we need to fill some other details like:
For Eg:
- Name -> [Android client 1]    
- Package Name -> [com.org.namespace.name]
- SHA-1 Key -> [AA:BB:CC:DD:EE:FF:11:22:33:44:55:66:77:88:99:00:AA:BB:CC:DD]
After configuring these we setupped [Oauth Client] successfully.
