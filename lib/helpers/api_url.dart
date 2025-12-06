class ApiUrl {
  // Ganti dengan URL API server Anda yang sebenarnya
  // Untuk development/testing lokal, gunakan localhost
  static const String baseUrl = 'http://192.168.2.158:8080';
  
  static const String registrasi = '$baseUrl/registrasi';
  static const String login = '$baseUrl/login';
  static const String listproduk = '$baseUrl/produk';
  static const String createproduk = '$baseUrl/produk';
  
  static String updateproduk(int id) {
    return '$baseUrl/produk/$id';
  }

  static String showproduk(int id) {
    return '$baseUrl/produk/$id';
  }

  static String deleteproduk(int id) {
    return '$baseUrl/produk/$id';
  }
}
