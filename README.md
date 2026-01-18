# 📧 View Email Prototype — Flutter + Protocol Buffers

A Flutter application that loads and displays a locally stored email message encoded in **Protocol Buffer format**, verifies its integrity using **SHA-256 hashing**, and presents a modern animated UI with dark/light theme support.

---

## 🚀 Project Overview

This project demonstrates:

- Local file loading (`sample_email.pb`)
- Protocol Buffers decoding
- SHA-256 integrity verification
- State management with Riverpod
- Error handling for malformed `.pb` files

The app loads an email message at startup, verifies the email body and attached image using cryptographic hashes, and displays verification status to the user.

---

## 🧱 Architecture

The project follows **Clean Architecture** principles:
```

lib/
├── core/
│    ├── errors/
│    ├── Theme/
│    └── utils/
├── data/
│    ├── datasources/
│    ├── models/proto/
│    └── repositories/
├── domain/
│    ├── entities/
│    └── repositories/
└── presentation/
     ├── providers/
     ├── screens/
     └── widgets/
```

## 🔐 Integrity Verification

**The app performs:**


- Email body
- Attached image bytes

It then compares computed hashes with the stored hashes and displays verification status using badges:

| Status   | Meaning                  |
|----------|--------------------------|
| Verified | Data integrity confirmed |
| Failed   | Hash mismatch detected   |

## 🧠 State Management

**I used Riverpod to handles:**

 - Loading state

 - Error state

 - Success state

## 🎨 UI Features

 - Gmail-inspired email layout

 - Verification badges

 - Image preview

 - Dark / Light theme 


## ⚠️ Error Handling

**I created custom exceptions:**

 - EmailFileNotFoundException

 - EmailParseException

 - EmailIntegrityException

## 🧪 Sample Email Generation

Created a script  to generate the sample_email.pb file.

**Location**

scripts/generate_sample_email.dart


And runed:

dart run scripts/generate_sample_email.dart


**This creates:**

assets/sample_email.pb

## 📂 Assets Configuration

**In pubspec.yaml:**

assets:
  - assets/sample_email.pb

## 🛠 Tech Stack
**Technology	Usage**
 - Flutter UI framework
 - Dart Programming language
 - Riverpod for State management
 - Protocol Buffers for Data serialization
 - SHA-256 for Data integrity verification
   
## ▶️ Running the App
 - flutter pub get
 - flutter run

