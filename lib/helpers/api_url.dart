class ApiUrl {
  static const String baseUrl =
      'http://103.196.155.42/api/pariwisata/penginapan'; //sesuaikan dengan ip laptop / localhost teman teman / url server Codeigniter

  static const String registrasi = baseUrl + '/registrasi';
  static const String login = baseUrl + '/login';
  static const String listPariwisata = baseUrl + '/produk';
  static const String createPariwisata = baseUrl + '/produk';

  static String updatePariwisata(int id) {
    return baseUrl +
        '/pariwisata/' +
        id.toString(); //sesuaikan dengan url API yang sudah dibuat
  }

  static String showPariwisata(int id) {
    return baseUrl +
        '/pariwisata/' +
        id.toString(); //sesuaikan dengan url API yang sudah dibuat
  }

  static String deletePariwisata(int id) {
    return baseUrl +
        '/pariwisata/' +
        id.toString(); //sesuaikan dengan url API yang sudah dibuat
  }
}
