import 'package:flutter/material.dart';
import 'package:supermarketkita/bloc/produk_bloc.dart';
import 'package:supermarketkita/model/produk.dart';
import 'package:supermarketkita/ui/produk_page.dart';
import 'package:supermarketkita/widget/warning_dialog.dart';

// ignore: must_be_immutable
class produkForm extends StatefulWidget {
  Produk? produk;
  produkForm({super.key, this.produk});
  @override
  _produkFormState createState() => _produkFormState();
}

class _produkFormState extends State<produkForm> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  String judul = "TAMBAH BUKU";
  String tombolSubmit = "SIMPAN";
  final _judulTextboxController = TextEditingController();
  final _hargaTextboxController = TextEditingController();
  final _jumlahTextboxController = TextEditingController();
  final _tanggalMasukTextboxController = TextEditingController();
  final _volumeTextboxController = TextEditingController();
  final _penulisTextboxController = TextEditingController();
  final _penerbitTextboxController = TextEditingController();

  @override
  void initState() {
    super.initState();
    isUpdate();
  }

  isUpdate() {
    if (widget.produk != null) {
      setState(() {
        judul = "UBAH BUKU RAFIF";
        tombolSubmit = "UBAH";
        _judulTextboxController.text = widget.produk!.judul!;
        _hargaTextboxController.text = widget.produk!.harga.toString();
        _jumlahTextboxController.text = widget.produk!.jumlah.toString();
        _tanggalMasukTextboxController.text = widget.produk!.tanggalMasuk!;
        _volumeTextboxController.text = widget.produk!.volume.toString();
        _penulisTextboxController.text = widget.produk!.penulis!;
        _penerbitTextboxController.text = widget.produk!.penerbit!;
      });
    } else {
      judul = "TAMBAH BUKU RAFIF";
      tombolSubmit = "SIMPAN";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF8B4513),
              Color(0xFFD2B48C),
            ],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                children: [
                  const SizedBox(height: 40),
                  // Header
                  Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: IconButton(
                          icon: const Icon(Icons.arrow_back, color: Colors.white),
                          onPressed: () => Navigator.pop(context),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            judul,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Text(
                            'Isi data buku dengan lengkap',
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 40),
                  // produk Form
                  Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 20,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          // Icon and title
                          Center(
                            child: Container(
                              width: 80,
                              height: 80,
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                  colors: [Color(0xFF8B4513), Color(0xFFD2B48C)],
                                ),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: const Icon(
                                Icons.library_books,
                                color: Colors.white,
                                size: 40,
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          const Text(
                            'Informasi produk',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF1F2937),
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 30),
                          _judulTextField(),
                          const SizedBox(height: 20),
                          _penulisTextField(),
                          const SizedBox(height: 20),
                          _penerbitTextField(),
                          const SizedBox(height: 20),
                          _hargaTextField(),
                          const SizedBox(height: 20),
                          _jumlahTextField(),
                          const SizedBox(height: 20),
                          _volumeTextField(),
                          const SizedBox(height: 20),
                          _tanggalMasukTextField(),
                          const SizedBox(height: 30),
                          _buttonSubmit(),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Judul
  Widget _judulTextField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: "Judul produk",
        prefixIcon: const Icon(Icons.title, color: Color(0xFF8B4513)),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        filled: true,
        fillColor: const Color(0xFFF8FAFC),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        labelStyle: const TextStyle(color: Color(0xFF6B7280)),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFF8B4513), width: 2),
        ),
      ),
      keyboardType: TextInputType.text,
      controller: _judulTextboxController,
      validator: (value) {
        if (value!.isEmpty) {
          return "Judul harus diisi";
        }
        return null;
      },
    );
  }

  // Penulis
  Widget _penulisTextField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: "Penulis",
        prefixIcon: const Icon(Icons.person, color: Color(0xFF8B4513)),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        filled: true,
        fillColor: const Color(0xFFF8FAFC),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        labelStyle: const TextStyle(color: Color(0xFF6B7280)),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFF8B4513), width: 2),
        ),
      ),
      keyboardType: TextInputType.text,
      controller: _penulisTextboxController,
      validator: (value) {
        if (value!.isEmpty) {
          return "Penulis harus diisi";
        }
        return null;
      },
    );
  }

  // Penerbit
  Widget _penerbitTextField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: "Penerbit",
        prefixIcon: const Icon(Icons.business, color: Color(0xFF8B4513)),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        filled: true,
        fillColor: const Color(0xFFF8FAFC),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        labelStyle: const TextStyle(color: Color(0xFF6B7280)),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFF8B4513), width: 2),
        ),
      ),
      keyboardType: TextInputType.text,
      controller: _penerbitTextboxController,
      validator: (value) {
        if (value!.isEmpty) {
          return "Penerbit harus diisi";
        }
        return null;
      },
    );
  }

  // Harga
  Widget _hargaTextField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: "Harga",
        prefixIcon: const Icon(Icons.attach_money, color: Color(0xFF8B4513)),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        filled: true,
        fillColor: const Color(0xFFF8FAFC),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        labelStyle: const TextStyle(color: Color(0xFF6B7280)),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFF8B4513), width: 2),
        ),
      ),
      keyboardType: TextInputType.number,
      controller: _hargaTextboxController,
      validator: (value) {
        if (value!.isEmpty) {
          return "Harga harus diisi";
        }
        return null;
      },
    );
  }

  // Jumlah
  Widget _jumlahTextField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: "Jumlah",
        prefixIcon: const Icon(Icons.inventory, color: Color(0xFF8B4513)),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        filled: true,
        fillColor: const Color(0xFFF8FAFC),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        labelStyle: const TextStyle(color: Color(0xFF6B7280)),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFF8B4513), width: 2),
        ),
      ),
      keyboardType: TextInputType.number,
      controller: _jumlahTextboxController,
      validator: (value) {
        if (value!.isEmpty) {
          return "Jumlah harus diisi";
        }
        return null;
      },
    );
  }

  // Volume
  Widget _volumeTextField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: "Volume",
        prefixIcon: const Icon(Icons.square_foot, color: Color(0xFF8B4513)),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        filled: true,
        fillColor: const Color(0xFFF8FAFC),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        labelStyle: const TextStyle(color: Color(0xFF6B7280)),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFF8B4513), width: 2),
        ),
      ),
      keyboardType: TextInputType.number,
      controller: _volumeTextboxController,
      validator: (value) {
        if (value!.isEmpty) {
          return "Volume harus diisi";
        }
        return null;
      },
    );
  }

  // Tanggal Masuk
  Widget _tanggalMasukTextField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: "Tanggal Masuk (YYYY-MM-DD)",
        prefixIcon: const Icon(Icons.date_range, color: Color(0xFF8B4513)),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        filled: true,
        fillColor: const Color(0xFFF8FAFC),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        labelStyle: const TextStyle(color: Color(0xFF6B7280)),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFF8B4513), width: 2),
        ),
      ),
      keyboardType: TextInputType.datetime,
      controller: _tanggalMasukTextboxController,
      validator: (value) {
        if (value!.isEmpty) {
          return "Tanggal masuk harus diisi";
        }
        return null;
      },
    );
  }

  // Tombol Submit
  Widget _buttonSubmit() {
    return Container(
      width: double.infinity,
      height: 54,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF8B4513), Color(0xFFD2B48C)],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF8B4513).withOpacity(0.3),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        onPressed: _isLoading ? null : () {
          var validate = _formKey.currentState!.validate();
          if (validate) {
            if (!_isLoading) {
              if (widget.produk != null) {
                ubah();
              } else {
                simpan();
              }
            }
          }
        },
        child: _isLoading 
            ? const SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  strokeWidth: 2,
                ),
              )
            : Text(
                tombolSubmit,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
      ),
    );
  }

  simpan() {
    setState(() {
      _isLoading = true;
    });
    Produk createproduk = Produk(id: null);
    createproduk.judul = _judulTextboxController.text;
    createproduk.harga = int.parse(_hargaTextboxController.text);
    createproduk.jumlah = int.parse(_jumlahTextboxController.text);
    createproduk.tanggalMasuk = _tanggalMasukTextboxController.text;
    createproduk.volume = int.parse(_volumeTextboxController.text);
    createproduk.penulis = _penulisTextboxController.text;
    createproduk.penerbit = _penerbitTextboxController.text;
    
    ProdukBloc.addProduk(produk: createproduk).then(
      (value) {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (BuildContext context) => produkPage(),
          ),
        );
      },
      onError: (error) {
        print('Error simpan: $error');
        showDialog(
          context: context,
          builder: (BuildContext context) => WarningDialog(
            description: "Simpan gagal: $error",
          ),
        );
      },
    );
    setState(() {
      _isLoading = false;
    });
  }

  ubah() {
    setState(() {
      _isLoading = true;
    });
    Produk updateproduk = Produk(id: widget.produk!.id!);
    updateproduk.judul = _judulTextboxController.text;
    updateproduk.harga = int.parse(_hargaTextboxController.text);
    updateproduk.jumlah = int.parse(_jumlahTextboxController.text);
    updateproduk.tanggalMasuk = _tanggalMasukTextboxController.text;
    updateproduk.volume = int.parse(_volumeTextboxController.text);
    updateproduk.penulis = _penulisTextboxController.text;
    updateproduk.penerbit = _penerbitTextboxController.text;
    
    ProdukBloc.updateProduk(produk: updateproduk).then(
      (value) {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (BuildContext context) => produkPage(),
          ),
        );
      },
      onError: (error) {
        print('Error ubah: $error');
        showDialog(
          context: context,
          builder: (BuildContext context) => WarningDialog(
            description: "Permintaan ubah data gagal: $error",
          ),
        );
      },
    );
    setState(() {
      _isLoading = false;
    });
  }
}
