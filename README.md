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
- Enable Email/pass signin method
- Download google.services.json file and move it into android/app

### Imagebb
- Create Imagebb account
- Copy the API
- Replace it with the API in lost.dart and found.dart

<table>
  <tr>
    <td><img src="https://github.com/user-attachments/assets/ca9ef82f-4c3d-4c83-99d4-f053f6ef0fce" alt="Google Logo" width="150px"></td>
    <td><img src="https://github.com/user-attachments/assets/ca9ef82f-4c3d-4c83-99d4-f053f6ef0fce" width="150px"></td>
  </tr>

  <tr>
    <td><img src="https://github.com/user-attachments/assets/184047f9-a8af-4be2-8f1c-b6ffa091b0c3" alt="Google Logo" width="150px"></td>
    <td><img src="https://github.com/user-attachments/assets/221db84f-97f0-47fe-872e-febb62bf444b" width="150px"></td>
  </tr>

   <tr>
    <td><img src="https://github.com/user-attachments/assets/f8db673c-bd3f-4be3-9b34-2b32b68b7d60" alt="Google Logo" width="150px"></td>
    <td><img src="https://github.com/user-attachments/assets/e935e4e7-66f1-476b-9a68-2991cca0c7c1" width="150px"></td>
  </tr>
    <tr>
    <td><img src="https://github.com/user-attachments/assets/bd8248cd-cc36-4c45-9090-4a6564fc6b76" alt="Google Logo" width="150px"></td>
    <td><img src="https://github.com/user-attachments/assets/87b297d5-7793-40d6-bc5d-7c498f573542" width="150px"></td>
  </tr>

  
</table>

### 🔧 Installation

```bash
git clone https://github.com/Princee99/SpotMe-Lost_and_Found_app.git
cd lost-found-app
flutter pub get
flutter run

