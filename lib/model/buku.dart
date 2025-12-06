class Buku {
  String? id;
  String? judul;
  var harga;
  var jumlah;
  String? tanggalMasuk;
  var volume;
  String? penulis;
  String? penerbit;
  
  Buku({
    this.id,
    this.judul,
    this.harga,
    this.jumlah,
    this.tanggalMasuk,
    this.volume,
    this.penulis,
    this.penerbit,
  });
  
  factory Buku.fromJson(Map<String, dynamic> obj) {
    return Buku(
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
