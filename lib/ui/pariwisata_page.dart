import 'package:flutter/material.dart';
import '../bloc/logout_bloc.dart';
import '../bloc/pariwisata_bloc.dart';
import '../model/pariwisata.dart';
import 'pariwisata_detail.dart';
import 'pariwisata_form.dart';
import 'login_page.dart';

class PariwisataPage extends StatefulWidget {
  const PariwisataPage({Key? key}) : super(key: key);

  @override
  _PariwisataPageState createState() => _PariwisataPageState();
}

class _PariwisataPageState extends State<PariwisataPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('List'),
        actions: [
          Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                child: const Icon(Icons.add, size: 26.0),
                onTap: () async {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => PariwisataForm()));
                },
              ))
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            ListTile(
              title: const Text('Logout'),
              trailing: const Icon(Icons.logout),
              onTap: () async {
                await LogoutBloc.logout().then((value) => {
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(builder: (context) => LoginPage()),
                          (route) => false)
                    });
              },
            )
          ],
        ),
      ),
      body: FutureBuilder<List>(
        future: ProdukBloc.getProduks(),
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);
          return snapshot.hasData
              ? ListPariwisata(
                  list: snapshot.data,
                )
              : const Center(
                  child: CircularProgressIndicator(),
                );
        },
      ),
    );
  }
}

class ListPariwisata extends StatelessWidget {
  final List? list;

  const ListPariwisata({Key? key, this.list}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: list == null ? 0 : list!.length,
        itemBuilder: (context, i) {
          return ItemPariwisata(
            pariwisata: list![i],
          );
        });
  }
}

class ItemPariwisata extends StatelessWidget {
  final Pariwisata pariwisata;

  const ItemPariwisata({Key? key, required this.pariwisata}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => PariwisataDetail(
                      pariwisata: pariwisata,
                    )));
      },
      child: Card(
        child: ListTile(
          title: Text(pariwisata.accomodation!),
          subtitle: Text(pariwisata.rate.toString()),
          trailing: Text(pariwisata.room!),
        ),
      ),
    );
  }
}
