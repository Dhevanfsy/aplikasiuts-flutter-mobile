import 'package:flutter/material.dart';

class KontakPage extends StatelessWidget {
  const KontakPage({super.key});

  final List<Map<String, String>> kontakList = const [
    {'nama': 'Dhevan', 'telepon': '081234567890'},
    {'nama': 'Kevin', 'telepon': '081223344556'},
    {'nama': 'Yuval', 'telepon': '081278945612'},
    {'nama': 'Tegar', 'telepon': '081323456789'},
    {'nama': 'Rama', 'telepon': '081298765432'},
    {'nama': 'Rizki', 'telepon': '081212345678'},
    {'nama': 'Yusuf', 'telepon': '081345678901'},
    {'nama': 'Andi', 'telepon': '081223344550'},
    {'nama': 'Akram', 'telepon': '081298765499'},
    {'nama': 'Prima', 'telepon': '081234567899'},
    {'nama': 'Vember', 'telepon': '081298765400'},
    {'nama': 'Rena', 'telepon': '081278945600'},
    {'nama': 'Agus', 'telepon': '081345678922'},
    {'nama': 'Putri', 'telepon': '081298765488'},
    {'nama': 'Rudi', 'telepon': '081234567801'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftar Kontak'),
        backgroundColor: Colors.blue,
      ),
      body: ListView.builder(
        itemCount: kontakList.length,
        itemBuilder: (context, index) {
          final kontak = kontakList[index];
          return Card(
            elevation: 2,
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.blue.shade100,
                child: const Icon(Icons.person, color: Colors.blue),
              ),
              title: Text(kontak['nama']!),
              subtitle: Text(kontak['telepon']!),
            ),
          );
        },
      ),
    );
  }
}
