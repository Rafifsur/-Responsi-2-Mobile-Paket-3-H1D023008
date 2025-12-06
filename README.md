# 📚 SUPERMARKET KITA - Aplikasi Inventaris Buku

**Rafif Surya Murtadha | H1D023008 | Shift B → C**

## 🎥 Video Demo
<video controls src="Demo_responsi2_H1D023008-1.mp4" title="Title"></video>


---

## 📋 Deskripsi
Aplikasi mobile untuk mengelola inventaris buku dengan fitur CRUD lengkap, autentikasi , dan UI modern dengan tema brown.

**Tech Stack:** Flutter 3.x + CodeIgniter 4 + MySQL

---

## ✨ Fitur
- ✅ CRUD Buku (7 field: Judul, Penulis, Penerbit, Harga, Jumlah, Volume, Tanggal Masuk)
- ✅ Login & Registrasi dengan JWT
- ✅ Session Management (SharedPreferences)
- ✅ List view dengan harga & stok
- ✅ Auto-refresh setelah CRUD

---

## 🚀 Cara Menjalankan

### Setup Backend
```bash
# Buat database
CREATE DATABASE supermarket_kita;

# Import table produk dengan field:
# id, judul, penulis, penerbit, harga, jumlah, volume, tanggal_masuk
```

### Setup Flutter
```bash
flutter pub get
flutter run
```

### Konfigurasi
Edit `lib/helpers/api_url.dart`:
```dart
static const String baseUrl = 'http://192.168.2.158:8080';
```

---
## 📡 API Endpoints

**Base URL:** `http://192.168.2.158:8080`

### Authentication
| Method | Endpoint | Body | Header |
|--------|----------|------|--------|
| POST | `/registrasi` | `nama, email, password` | - |
| POST | `/login` | `email, password` | - |

### Produk/Buku
| Method | Endpoint | Body | Header |
|--------|----------|------|--------|
| GET | `/produk` | - | `Bearer {token}` |
| POST | `/produk` | `judul, penulis, penerbit, harga, jumlah, volume, tanggal_masuk` | `Bearer {token}` |
| PUT | `/produk/{id}` | JSON body (7 fields) | `Bearer {token}`, `application/json` |
| DELETE | `/produk/{id}` | - | `Bearer {token}` |

**Contoh Response:**
```json
{
  "code": 200,
  "status": true,
  "data": [
    {
      "id": "1",
      "judul": "Laskar Pelangi",
      "penulis": "Andrea Hirata",
      "penerbit": "Bentang Pustaka",
      "harga": 75000,
      "jumlah": 10,
      "volume": 300,
      "tanggal_masuk": "2025-12-06"
    }
  ]
}
```

---

## 💻 Penjelasan Kode

### 📁 Struktur Folder

```
lib/
├── main.dart                 # Entry point aplikasi
├── bloc/                     # Business Logic Component
│   ├── login_bloc.dart
│   ├── logout_bloc.dart
│   ├── produk_bloc.dart      # CRUD logic untuk buku
│   └── registrasi_bloc.dart
├── helpers/                  # Helper utilities
│   ├── api.dart              # HTTP client wrapper
│   ├── api_url.dart          # API endpoint configuration
│   ├── app_exception.dart    # Custom exceptions
│   └── user_info.dart        # Session management
├── model/                    # Data models
│   ├── login.dart
│   ├── produk.dart           # Model Buku/Produk
│   └── registrasi.dart
├── ui/                       # User Interface
│   ├── login_page.dart
│   ├── registrasi_page.dart
│   ├── produk_page.dart      # List buku
│   ├── produk_form.dart      # Form tambah/edit
│   └── produk_detail.dart    # Detail buku
└── widget/                   # Reusable widgets
    ├── success_dialog.dart
    └── warning_dialog.dart
```

---

### 🔧 Penjelasan Fungsi Per File

#### 1. `main.dart` - Entry Point

**Fungsi Utama:**
```dart
void main() {
  runApp(const MyApp());
}
```

**Class MyApp:**
- Mengecek status login dengan `UserInfo().getToken()`
- Redirect ke `produkPage()` jika sudah login
- Redirect ke `LoginPage()` jika belum login
- Setup Material Design 3 dengan tema brown (#8B4513)

**Method `isLogin()`:**
```dart
void isLogin() async {
  var token = await UserInfo().getToken();
  if (token != null) {
    setState(() {
      page = produkPage();  // Sudah login
    });
  } else {
    setState(() {
      page = const LoginPage();  // Belum login
    });
  }
}
```

---

#### 2. `lib/helpers/api.dart` - HTTP Client Wrapper

**Fungsi:** Menangani semua HTTP requests dengan authentication otomatis

**Method `post()`:**
```dart
Future<dynamic> post(dynamic url, dynamic data) async {
  var token = await UserInfo().getToken();
  final response = await http.post(
    Uri.parse(url),
    body: data,
    headers: {HttpHeaders.authorizationHeader: "Bearer $token"},
  );
  return _returnResponse(response);
}
```
- Mengirim POST request dengan form-encoded body
- Otomatis attach Bearer token dari session

**Method `put()`:**
```dart
Future<dynamic> put(dynamic url, dynamic data) async {
  var token = await UserInfo().getToken();
  final response = await http.put(
    Uri.parse(url),
    body: json.encode(data),  // Encode ke JSON
    headers: {
      HttpHeaders.authorizationHeader: "Bearer $token",
      HttpHeaders.contentTypeHeader: "application/json",
    },
  );
  return _returnResponse(response);
}
```
- Mengirim PUT request dengan JSON body
- Menggunakan `json.encode()` karena CI4 tidak bisa baca form-encoded PUT

**Method `_returnResponse()`:**
```dart
dynamic _returnResponse(http.Response response) {
  switch (response.statusCode) {
    case 200:
      return response;
    case 400:
      throw BadRequestException(response.body.toString());
    case 401:
    case 403:
      throw UnauthorisedException(response.body.toString());
    case 422:
      throw InvalidInputException(response.body.toString());
    case 500:
    default:
      throw FetchDataException('Error with StatusCode: ${response.statusCode}');
  }
}
```
- Handle response berdasarkan status code
- Throw custom exception untuk error handling

---

#### 3. `lib/helpers/api_url.dart` - Endpoint Configuration

```dart
class ApiUrl {
  static const String baseUrl = 'http://192.168.2.158:8080';
  
  static const String registrasi = '$baseUrl/registrasi';
  static const String login = '$baseUrl/login';
  static const String listproduk = '$baseUrl/produk';
  static const String createproduk = '$baseUrl/produk';
  
  static String updateproduk(int id) {
    return '$baseUrl/produk/$id';
  }
  
  static String deleteproduk(int id) {
    return '$baseUrl/produk/$id';
  }
}
```

**Fungsi:** Centralized management untuk semua API endpoints

---

#### 4. `lib/helpers/user_info.dart` - Session Management

**Method `setToken()`:**
```dart
Future<void> setToken(String value) async {
  final SharedPreferences pref = await SharedPreferences.getInstance();
  return pref.setString("token", value);
}
```
- Menyimpan JWT token ke local storage

**Method `getToken()`:**
```dart
Future<String?> getToken() async {
  final SharedPreferences pref = await SharedPreferences.getInstance();
  return pref.getString("token");
}
```
- Mengambil token dari local storage
- Return null jika belum login

**Method `logout()`:**
```dart
Future<void> logout() async {
  final SharedPreferences pref = await SharedPreferences.getInstance();
  pref.clear();
}
```
- Menghapus semua session data

---

#### 5. `lib/model/produk.dart` - Data Model

```dart
class Produk {
  String? id;
  String? judul;
  int? harga;
  int? jumlah;
  String? tanggalMasuk;
  int? volume;
  String? penulis;
  String? penerbit;
  
## 💻 Penjelasan Kode

### 📁 Struktur File
```
lib/
├── main.dart              # Entry point & routing
├── bloc/                  # Business logic (CRUD)
├── helpers/               # API & session management
├── model/                 # Data models
├── ui/                    # Screens (login, list, form, detail)
└── widget/                # Reusable dialogs
```

### 🔑 File Penting

#### 1. `lib/helpers/api.dart`
HTTP wrapper dengan auto JWT authentication.

**Key Method:**
- `put()` - Kirim JSON body dengan `json.encode()` karena CI4 tidak bisa baca form-encoded PUT

#### 2. `lib/model/produk.dart`
Model dengan 7 field: `id, judul, penulis, penerbit, harga, jumlah, volume, tanggal_masuk`

**Key Feature:**
- Safe parsing dengan `int.tryParse()` untuk handle inconsistent API response

#### 3. `lib/bloc/produk_bloc.dart`
Business logic untuk CRUD operations.

**Methods:**
- `getProduks()` - GET all books
- `addProduk()` - POST dengan form-encoded body
- `updateProduk()` - PUT dengan JSON body
- `deleteProduk()` - DELETE by ID

#### 4. `lib/ui/produk_form.dart`
Form untuk tambah/edit buku dengan 7 input fields.

**Key Features:**
- Gunakan `trim()` untuk clean whitespace
- `pushReplacement` untuk force refresh list setelah submit
- `setState(_isLoading)` di dalam callback

#### 5. `lib/ui/produk_page.dart`
List buku dengan display judul, harga, dan stok.

**Widget:**
- `FutureBuilder` untuk async data loading
- Custom item card dengan brown theme
- FAB untuk tambah buku baru

---



## 🎨 UI Theme
- **Primary:** Brown (#8B4513)
- **Secondary:** Tan (#D2B48C)
- **Design:** Material Design 3 dengan gradient backgrounds

---## 📦 Dependencies
```yaml
dependencies:
  http: ^1.2.1                # HTTP client
  shared_preferences: ^2.0.11 # Local storage
  intl: ^0.18.0              # Date formatting
```

---

**Rafif Surya Murtadha | H1D023008 | Shift B → C**  
*Praktikum Pemrograman Mobile - 2025*