import 'package:flutter/material.dart';
import '../bloc/pariwisata_bloc.dart';
import '../widget/warning_dialog.dart';
import '../model/pariwisata.dart';
import 'pariwisata_form.dart';
import 'pariwisata_page.dart';

// ignore: must_be_immutable
class PariwisataDetail extends StatefulWidget {
  Pariwisata? pariwisata;

  PariwisataDetail({Key? key, this.pariwisata}) : super(key: key);

  @override
  _PariwisataDetailState createState() => _PariwisataDetailState();
}

class _PariwisataDetailState extends State<PariwisataDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Produk'),
      ),
      body: Center(
        child: Column(
          children: [
            Text(
              "Kode : ${widget.pariwisata!.accomodation}",
              style: const TextStyle(fontSize: 20.0),
            ),
            Text(
              "Nama : ${widget.pariwisata!.room}",
              style: const TextStyle(fontSize: 18.0),
            ),
            Text(
              "Harga : Rp. ${widget.pariwisata!.rate}",
              style: const TextStyle(fontSize: 18.0),
            ),
            _tombolHapusEdit()
          ],
        ),
      ),
    );
  }

  Widget _tombolHapusEdit() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Tombol Edit
        OutlinedButton(
          child: const Text("EDIT"),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PariwisataForm(
                  pariwisata: widget.pariwisata!,
                ),
              ),
            );
          },
        ),
        // Tombol Hapus
        OutlinedButton(
          child: const Text("DELETE"),
          onPressed: () => confirmHapus(),
        ),
      ],
    );
  }

  void confirmHapus() {
    AlertDialog alertDialog = AlertDialog(
      content: const Text("Yakin ingin menghapus data ini?"),
      actions: [
        //tombol hapus
        OutlinedButton(
          child: const Text("Ya"),
          onPressed: () {
            ProdukBloc.deletePariwisata(id: widget.pariwisata!.id!).then(
                (value) => {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const PariwisataPage()))
                    }, onError: (error) {
              showDialog(
                  context: context,
                  builder: (BuildContext context) => const WarningDialog(
                        description: "Hapus gagal, silahkan coba lagi",
                      ));
            });
          },
        ),
        //tombol batal
        OutlinedButton(
          child: const Text("Batal"),
          onPressed: () => Navigator.pop(context),
        )
      ],
    );

    showDialog(builder: (context) => alertDialog, context: context);
  }
}
