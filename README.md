# SpotMe

# 🔍 Lost & Found App

A mobile app built to help users report and recover lost or found items. Whether you've lost your phone on campus or found someone’s keys, this app is your go-to digital bulletin board for making connections and retrieving lost belongings.

---

## 🎯 Purpose

The app serves as a centralized platform where users can:
- Post lost items with descriptions and images.
- Report found items to help locate their rightful owners.
- Browse all listed items to find matches.
<<<<<<< HEAD

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
    <td><img src="https://github.com/user-attachments/assets/ba7adef6-1585-4df9-9922-c3b68e13f472" alt="Login Page" width="150px"></td>
    <td><img src="https://github.com/user-attachments/assets/69101d8c-6754-4569-a290-51bd91563635" alt="SignIn page" width="150px"></td>
  </tr>

  <tr>
    <td><img src="https://github.com/user-attachments/assets/87302d2b-65bc-4515-b9fc-d8f6c66c1a5c" alt="Reset Pass" width="150px"></td>
    <td><img src="https://github.com/user-attachments/assets/f400e3fe-cfa9-4692-8460-d37641365d42" alt="Home page" width="150px"></td>
  </tr>
   <tr>
    <td><img src="https://github.com/user-attachments/assets/288ac445-c1be-4c10-bde5-2d4396a59ee9" alt="Home Page" width="150px"></td>
    <td><img src="https://github.com/user-attachments/assets/a86066cb-0a0d-4796-baba-aa97e75d1ee5" alt="Add Item" width="150px"></td>
  </tr>
    <tr>
    <td><img src="https://github.com/user-attachments/assets/3b81c2ab-cfbe-4b3e-95c8-81f0e9d7367f" alt="Profile Page " width="150px"></td>
    <td><img src="https://github.com/user-attachments/assets/9743e748-e21a-4bdb-aca1-554895f1abf6" alt="Delete item " width="150px"></td>
  </tr>
</table>

### 🔧 Installation

```bash
git clone https://github.com/Princee99/SpotMe-Lost_and_Found_app.git
cd lost-found-app
flutter pub get
flutter run
=======

---



>>>>>>> 057643dad2c73232e45053ff1d11d275413ac984
