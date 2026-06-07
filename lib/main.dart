import 'package:flutter/material.dart';
import 'detaysayfasi.dart'; 

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp(); 

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Spotify Klonu',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFF121212),
        primaryColor: Colors.green,
      ),
      home: const AnaSayfa(),
    );
  }
}

class AnaSayfa extends StatefulWidget {
  const AnaSayfa();

  @override
  State<AnaSayfa> createState() => _AnaSayfaState();
}

class _AnaSayfaState extends State<AnaSayfa> {
  int aktifSayfa = 0;
  int sarkiCaliyor = 0; 
  String aktifSarkiAdi = "Dilsiz Sırdaşım";
  String aktifSanatci = "Yüzyüzeyken Konuşuruz";
  String aktifResim = "https://images.unsplash.com/photo-1514525253161-7a46d19cd819?w=150&q=80";
  String aramaMetni = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF121212),
        elevation: 0,
        automaticallyImplyLeading: false, 
        title: const Text("Spotify", style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold, fontSize: 26)),
      ),
      body: Column(
        children: [
          Expanded(child: _sayfaIceriginiGetir()),
          // Alt Mini Çalar alanı
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(color: const Color(0xFF282828), borderRadius: BorderRadius.circular(8)),
            child: Row(
              children: [
                CircleAvatar(radius: 20, backgroundImage: NetworkImage(aktifResim)),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(aktifSarkiAdi, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14)),
                      Text(aktifSanatci, style: const TextStyle(color: Colors.grey, fontSize: 12)),
                    ],
                  ),
                ),
                IconButton(
                  icon: Icon(sarkiCaliyor == 1 ? Icons.pause_circle_filled : Icons.play_circle_filled, color: Colors.green, size: 32),
                  onPressed: () {
                    setState(() {
                      sarkiCaliyor = sarkiCaliyor == 0 ? 1 : 0;
                    });
                  },
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(0xFF191919),
        currentIndex: aktifSayfa,
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.grey,
        onTap: (index) => setState(() => aktifSayfa = index),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Ana Sayfa"),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: "Ara"),
          BottomNavigationBarItem(icon: Icon(Icons.library_music), label: "Kitaplığın"),
        ],
      ),
    );
  }

  Widget _sayfaIceriginiGetir() {
    if (aktifSayfa == 1) return _araSayfasiIcerigi();
    if (aktifSayfa == 2) return _kitapligimSayfasiIcerigi();
    return _anaSayfaIcerigi();
  }

  Widget _anaSayfaIcerigi() {
    return ListView(
      children: [
        const Padding(padding: EdgeInsets.all(16.0), child: Text("Sık Dinlenenler", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold))),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 3.0,
            children: [
              _kartTasarimi("Yüzyüzeyken", "https://images.unsplash.com/photo-1514525253161-7a46d19cd819?w=150&q=80"),
              _kartTasarimi("Dolu Kadeh", "https://images.unsplash.com/photo-1470225620780-dba8ba36b745?w=150&q=80"),
              _kartTasarimi("Madrigal", "https://images.unsplash.com/photo-1498038432885-c6f3f1b912ee?w=150&q=80"),
              _kartTasarimi("Mor ve Ötesi", "https://images.unsplash.com/photo-1511671782779-c97d3d27a1d4?w=150&q=80"),
            ],
          ),
        ),
        const Padding(padding: EdgeInsets.all(16.0), child: Text("Senin İçin Hazırlandı", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold))),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            children: [
              _albumTasarimi("Akustik Türkçe", "Sakin ve huzurlu tınılar...", "https://images.unsplash.com/photo-1459749411175-04bf5292ceea?w=300&q=80"),
              const SizedBox(width: 15),
              _albumTasarimi("Yol Şarkıları", "Uzun yolların en iyi eşlikçileri", "https://images.unsplash.com/photo-1493225457124-a3eb161ffa5f?w=300&q=80"),
            ],
          ),
        ),
        const SizedBox(height: 20),
        const Divider(color: Colors.grey, thickness: 0.5),
        const Padding(padding: EdgeInsets.all(16.0), child: Text("Popüler Sanatçılar", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold))),
        _listeSatirTasarimi("Yüzyüzeyken Konuşuruz", "1.2 Milyon Dinleyici", "https://images.unsplash.com/photo-1514525253161-7a46d19cd819?w=150&q=80", true, null, null),
        _listeSatirTasarimi("Madrigal", "980 Bin Dinleyici", "https://images.unsplash.com/photo-1498038432885-c6f3f1b912ee?w=150&q=80", true, null, null),
      ],
    );
  }

  Widget _araSayfasiIcerigi() {
    return ListView(
      children: [
        const Padding(padding: EdgeInsets.all(16.0), child: Text("Ara", style: TextStyle(color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold))),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(color: const Color(0xFF242424), borderRadius: BorderRadius.circular(8)),
            child: Row(
              children: [
                const Icon(Icons.search, color: Colors.white),
                const SizedBox(width: 10),
                Expanded(
                  child: TextField(
                    onChanged: (yazi) => setState(() => aramaMetni = yazi),
                    style: const TextStyle(color: Colors.white),
                    decoration: const InputDecoration(hintText: "Sanatçılar, şarkılar...", hintStyle: TextStyle(color: Colors.grey), border: InputBorder.none),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 20),
        if (aramaMetni != "") 
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("\"$aramaMetni\" İçin En İyi Sonuç", style: const TextStyle(color: Colors.grey, fontSize: 14)),
                const SizedBox(height: 10),
                _listeSatirTasarimi(aramaMetni, "Arama ile eşleşen sonuç", "https://images.unsplash.com/photo-1511671782779-c97d3d27a1d4?w=150&q=80", true, null, null),
              ],
            ),
          ),
      ],
    );
  }

  Widget _kitapligimSayfasiIcerigi() {
    return ListView(
      children: [
        const Padding(padding: EdgeInsets.all(16.0), child: Text("Kitaplığın", style: TextStyle(color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold))),
        _kitaplikBuyukKart("Beğenilen Şarkılar", "Çalma Listesi • 142 Şarkı", Icons.favorite, Colors.green),
        _kitaplikBuyukKart("Favori Sanatçılarım", "En Sık Takip Ettiğin İsimler", Icons.star, Colors.orange),
        const Padding(padding: EdgeInsets.all(16.0), child: Text("Son Dinlediklerin", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold))),
        _listeSatirTasarimi("Dilsiz Sırdaşım", "Yüzyüzeyken Konuşuruz", "https://images.unsplash.com/photo-1514525253161-7a46d19cd819?w=150&q=80", false, Icons.music_note, Icons.favorite),
        _listeSatirTasarimi("Seni Dert Etmeler", "Madrigal", "https://images.unsplash.com/photo-1514525253161-7a46d19cd819?w=150&q=80", false, Icons.music_note, Icons.favorite),
      ],
    );
  }

  // TAMAMEN SENİN LİSTENDEN ÜRETİLEN YARDIMCI TASARIMLAR

  Widget _kartTasarimi(String baslik, String resimUrl) {
    return TextButton(
      style: TextButton.styleFrom(padding: EdgeInsets.zero),
      onPressed: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => DetaySayfasi(baslik, resimUrl)));
      },
      child: Container(
        decoration: BoxDecoration(color: const Color(0xFF282828), borderRadius: BorderRadius.circular(4)),
        child: Row(
          children: [
            Container(width: 55, height: 55, decoration: BoxDecoration(borderRadius: BorderRadius.circular(4), image: DecorationImage(image: NetworkImage(resimUrl)))),
            const SizedBox(width: 8),
            Expanded(child: Text(baslik, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12))),
          ],
        ),
      ),
    );
  }

  Widget _albumTasarimi(String baslik, String aciklama, String resimUrl) {
    return TextButton(
      style: TextButton.styleFrom(padding: EdgeInsets.zero),
      onPressed: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => DetaySayfasi(baslik, resimUrl)));
      },
      child: SizedBox(
        width: 150,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(width: 150, height: 120, decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), image: DecorationImage(image: NetworkImage(resimUrl)))),
            const SizedBox(height: 8),
            Text(baslik, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14)),
            Text(aciklama, style: const TextStyle(color: Colors.grey, fontSize: 11)),
          ],
        ),
      ),
    );
  }

  Widget _listeSatirTasarimi(String baslik, String altBaslik, String resimUrl, bool yuvarlakMi, IconData? solIkon, IconData? sagIkon) {
    return TextButton(
      style: TextButton.styleFrom(padding: EdgeInsets.zero),
      onPressed: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => DetaySayfasi(baslik, resimUrl)));
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                if (yuvarlakMi) CircleAvatar(radius: 25, backgroundImage: NetworkImage(resimUrl)),
                if (solIkon != null) Icon(solIkon, color: Colors.green),
                const SizedBox(width: 15),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(baslik, style: const TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold)),
                    Text(altBaslik, style: const TextStyle(color: Colors.grey, fontSize: 12)),
                  ],
                ),
              ],
            ),
            if (sagIkon != null) Icon(sagIkon, color: Colors.green, size: 20),
          ],
        ),
      ),
    );
  }

  Widget _kitaplikBuyukKart(String baslik, String aciklama, IconData ikon, Color ikonRenk) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: TextButton(
        style: TextButton.styleFrom(padding: EdgeInsets.zero),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => DetaySayfasi(baslik, "https://images.unsplash.com/photo-1514525253161-7a46d19cd819?w=150&q=80")));
        },
        child: Container(
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(color: const Color(0xFF1E1E1E), borderRadius: BorderRadius.circular(8)),
          child: Row(
            children: [
              Container(
                width: 50, height: 50,
                decoration: BoxDecoration(color: ikonRenk, borderRadius: BorderRadius.circular(6)),
                child: Icon(ikon, color: Colors.white, size: 28),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(baslik, style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 4),
                    Text(aciklama, style: const TextStyle(color: Colors.grey, fontSize: 13)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
//BU UYGULAMA MOBİL PROGRALAMA DERSİ KAPSAMINDA GELİŞTİRİLMİŞTİR.