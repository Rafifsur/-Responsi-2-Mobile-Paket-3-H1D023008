class Produk {
  String? id;
  String? judul;
  var harga;
  var jumlah;
  String? tanggalMasuk;
  var volume;
  String? penulis;
  String? penerbit;
  
  Produk({
    this.id,
    this.judul,
    this.harga,
    this.jumlah,
    this.tanggalMasuk,
    this.volume,
    this.penulis,
    this.penerbit,
  });
  
  factory Produk.fromJson(Map<String, dynamic> obj) {
    return Produk(
      id: obj['id'],
      judul: obj['judul'],
      harga: obj['harga'],
      jumlah: obj['jumlah'],
      tanggalMasuk: obj['tanggal_masuk'],
      volume: obj['volume'],
      penulis: obj['penulis'],
      penerbit: obj['penerbit'],
    );
  }
}
