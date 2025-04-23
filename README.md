# spotme

# 🔍 Lost & Found App

A mobile app built to help users report and recover lost or found items. Whether you've lost your phone on campus or found someone’s keys, this app is your go-to digital bulletin board for making connections and retrieving lost belongings.

---

## 🎯 Purpose

The app serves as a centralized platform where users can:
- Post lost items with descriptions and images.
- Report found items to help locate their rightful owners.
- Browse all listed items to find matches.

---

## 🚀 Features

### 🔐 Authentication
- **Login / Sign Up** — Secure Firebase Auth-based login system.
- **Forgot Password** — Password reset functionality through email.

### 📤 Item Reporting
- **Upload Lost/Found Item** — Post details including:
  - Item name & description
  - Date and place it was lost/found
  - Upload image via ImgBB API
- **Delete Listing** — Users can remove their own posts once resolved.

### 👤 User Profile
- View and manage your listed items.
- Update personal information.

### 🔎 Browsing
- Easily view items reported as lost or found.
- Filter through categories or search by keywords (coming soon).

---

## 🛠 Tech Stack

| Layer         | Technology Used            |
|---------------|-----------------------------|
| Frontend      | Flutter (Dart)              |
| Backend       | Firebase (Auth, Firestore)  |
| Image Hosting | ImgBB API                   |
| Auth Handling | Firebase Authentication     |
| Data Storage  | Cloud Firestore             |

---

## 🧑‍💻 Target Audience

This app is made for:
- 📚 Students
- 🧑‍🏫 Teachers
- 👩‍💼 Admin Staff
- 🚶 General Public

Anyone who has lost or found an item can use the app to report and search!

---

## 🧪 Getting Started

### ✅ Prerequisites

- Flutter SDK
- Firebase Project with Auth & Firestore enabled
- ImgBB API key (for image upload)

### Firebase
- Create a Project in firebase 
-Enable Email/pass signin method
-Download google.services.json file and move it into android/app

### Imagebb
-Create Imagebb account
-Copy the API
-Replace it with the API in lost.dart and found.dart

### 🔧 Installation

```bash
git clone https://github.com/yourusername/lost-found-app.git
cd lost-found-app
flutter pub get
flutter run

