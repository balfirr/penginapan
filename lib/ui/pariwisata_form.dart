import 'package:flutter/material.dart';
import '../bloc/pariwisata_bloc.dart';
import '../widget/warning_dialog.dart';
import '../model/pariwisata.dart';
import 'pariwisata_page.dart';

// ignore: must_be_immutable
class PariwisataForm extends StatefulWidget {
  Pariwisata? pariwisata;
  PariwisataForm({Key? key, this.pariwisata}) : super(key: key);
  @override
  _PariwisataFormState createState() => _PariwisataFormState();
}

class _PariwisataFormState extends State<PariwisataForm> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  String judul = "TAMBAH";
  String tombolSubmit = "SIMPAN";
  final _accomodationTextboxController = TextEditingController();
  final _roomTextboxController = TextEditingController();
  final _rateTextboxController = TextEditingController();
  @override
  void initState() {
    super.initState();
    isUpdate();
  }

  isUpdate() {
    if (widget.pariwisata != null) {
      setState(() {
        judul = "UBAH RESERVASI";
        tombolSubmit = "UBAH";
        _accomodationTextboxController.text = widget.pariwisata!.accomodation!;
        _roomTextboxController.text = widget.pariwisata!.room!;
        _rateTextboxController.text =
            widget.pariwisata!.rate.toString();
      });
    } else {
      judul = "TAMBAH RESERVASI";
      tombolSubmit = "SIMPAN";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(judul)),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                _accomodationTextField(),
                _roomTextField(),
                _rateTextField(),
                _buttonSubmit()
              ],
            ),
          ),
        ),
      ),
    );
  }

//Membuat Textbox Kode Produk
  Widget _accomodationTextField() {
    return TextFormField(
      decoration: const InputDecoration(labelText: "Akomodasi"),
      keyboardType: TextInputType.text,
      controller: _accomodationTextboxController,
      validator: (value) {
        if (value!.isEmpty) {
          return "Akomodasi harus diisi";
        }
        return null;
      },
    );
  }

//Membuat Textbox Nama Produk
  Widget _roomTextField() {
    return TextFormField(
      decoration: const InputDecoration(labelText: "Room"),
      keyboardType: TextInputType.text,
      controller: _roomTextboxController,
      validator: (value) {
        if (value!.isEmpty) {
          return "Room harus diisi";
        }
        return null;
      },
    );
  }

//Membuat Textbox Harga Produk
  Widget _rateTextField() {
    return TextFormField(
      decoration: const InputDecoration(labelText: "Rate"),
      keyboardType: TextInputType.number,
      controller: _rateTextboxController,
      validator: (value) {
        if (value!.isEmpty) {
          return "Rate harus diisi";
        }
        return null;
      },
    );
  }

  //Membuat Tombol Simpan/Ubah
  Widget _buttonSubmit() {
    return OutlinedButton(
        child: Text(tombolSubmit),
        onPressed: () {
          var validate = _formKey.currentState!.validate();
          if (validate) {
            if (!_isLoading) {
              if (widget.pariwisata != null) {
                //kondisi update
                ubah();
              } else {
                //kondisi tambah
                simpan();
              }
            }
          }
        });
  }

  simpan() {
    setState(() {
      _isLoading = true;
    });
    Pariwisata createPariwisata = Pariwisata(id: null);
    createPariwisata.accomodation = _accomodationTextboxController.text;
    createPariwisata.room = _roomTextboxController.text;
    createPariwisata.rate = int.parse(_rateTextboxController.text);
    ProdukBloc.addPariwisata(pariwisata: createPariwisata).then((value) {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (BuildContext context) => const PariwisataPage()));
    }, onError: (error) {
      showDialog(
          context: context,
          builder: (BuildContext context) => const WarningDialog(
                description: "Simpan gagal, silahkan coba lagi",
              ));
    });
    setState(() {
      _isLoading = false;
    });
  }
  ubah() {
    setState(() {
      _isLoading = true;
    });
    Pariwisata updatePariwisata = Pariwisata(id: widget.pariwisata!.id!);
    updatePariwisata.accomodation = _accomodationTextboxController.text;
    updatePariwisata.room = _roomTextboxController.text;
    updatePariwisata.rate = int.parse(_rateTextboxController.text);
    ProdukBloc.updatePariwisata(pariwisata: updatePariwisata).then((value) {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (BuildContext context) => const PariwisataPage()));
    }, onError: (error) {
      showDialog(
          context: context,
          builder: (BuildContext context) => const WarningDialog(
                description: "Permintaan ubah data gagal, silahkan coba lagi",
              ));
    });
    setState(() {
      _isLoading = false;
    });
  }
}



