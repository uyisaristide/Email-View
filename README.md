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

lib/
├── core/
│    ├── errors/
│    ├──Theme/
     └── utils/
├── data/
│    ├── datasources/
│    ├── models/proto/
│    └── repositories/
├── domain/
│    ├── entities/
│    ├──Repositories
└── presentation/
    ├── providers/
    ├── screens/
    └── widgets/
