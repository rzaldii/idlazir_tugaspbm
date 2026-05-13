# ☕ IDLAZIR

Modern Coffee Catalog Mobile App berbasis Flutter yang memungkinkan pengguna untuk login, mengelola draft produk kopi, melakukan pencarian produk, serta submit tugas melalui integrasi REST API menggunakan Bearer Token Authentication.

---

## 👨‍💻 Author

Iqbal Rizaldi

---

## 📌 Deskripsi Project

IDLAZIR merupakan aplikasi mobile bertema coffee shop yang dibangun menggunakan Flutter dengan konsep modern UI dan clean architecture.  
Aplikasi ini dikembangkan sebagai implementasi praktikum Pemrograman Berbasis Mobile 2026 yang berfokus pada integrasi REST API, autentikasi token, state management, dan penerapan konsep OOP pada Flutter.

Aplikasi memungkinkan pengguna untuk:
- Login menggunakan akun mahasiswa
- Mengelola draft produk kopi
- Menampilkan katalog produk
- Melakukan pencarian produk
- Melihat detail produk
- Submit tugas beserta repository GitHub

Project ini menerapkan struktur folder yang modular agar kode lebih mudah dikelola, scalable, dan maintainable.

---

## ✨ Fitur Utama

### 🔐 Authentication
- Login menggunakan NIM
- Bearer Token Authentication
- Secure token storage
- Logout confirmation dialog

### ☕ Product Management
- Menampilkan daftar draft produk
- Menambahkan produk kopi
- Product detail page
- Soft delete simulation
- Search produk realtime
- Pull to refresh

### 🚀 Submit Assignment
- Preview produk sebelum submit
- Submit repository GitHub
- Validasi input
- Snackbar feedback

---

## 🔌 Integrasi API

Aplikasi menggunakan REST API eksternal sebagai backend:

```bash
https://task.itprojects.web.id/api
