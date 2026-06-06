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

  int sarkiCaliyor = 0; // 0: çalmıyor, 1: çalıyor
  String aktifSarkiAdi = "Dilsiz Sırdaşım";
  String aktifSanatci = "Yüzyüzeyken Konuşuruz";
  String aktifResim = "https://images.unsplash.com/photo-1514525253161-7a46d19cd819?w=150&q=80";

  // Arama sayfasında yazılan metni tutmak içindir
  String aramaMetni = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Başlığı yeşil Spotify yapıldı
      appBar: AppBar(
        backgroundColor: const Color(0xFF121212),
        elevation: 0,
        title: const Text(
          "Spotify",
          style: TextStyle(
            color: Colors.green, 
            fontWeight: FontWeight.bold,
            fontSize: 26,
          ),
        ),
      ),

      
      body: Column(
        children: [
          // Aktif sayfa içeriği üst kısmı kaplar
          Expanded(
            child: _sayfaIceriginiGetir(),
          ),

          // Mini Oynatıcı (Ekranın altında, içeriğin hemen bitiminde yer alır)
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: const Color(0xFF282828),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundImage: NetworkImage(aktifResim),
                ),
                const SizedBox(width: 12),
                // Taşmaları önlemek ve esnek genişlik sağlamak için Expanded kullandım
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        aktifSarkiAdi,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        aktifSanatci,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: Icon(
                    sarkiCaliyor == 1 ? Icons.pause_circle_filled : Icons.play_circle_filled,
                    color: Colors.green,
                    size: 32,
                  ),
                  onPressed: () {
                    setState(() {
                      if (sarkiCaliyor == 0) {
                        sarkiCaliyor = 1;
                      } else {
                        sarkiCaliyor = 0;
                      }
                    });
                  },
                ),
              ],
            ),
          ),
        ],
      ),

      // Sayfalar arası geçiş yaptıran alt menüdür
      bottomNavigationBar: Container(
        color: const Color(0xFF191919),
        height: 60,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: Icon(
                Icons.home, 
                color: aktifSayfa == 0 ? Colors.green : Colors.grey,
              ),
              onPressed: () {
                setState(() {
                  aktifSayfa = 0;
                });
              },
            ),
            IconButton(
              icon: Icon(
                Icons.search, 
                color: aktifSayfa == 1 ? Colors.green : Colors.grey,
              ),
              onPressed: () {
                setState(() {
                  aktifSayfa = 1;
                });
              },
            ),
            IconButton(
              icon: Icon(
                Icons.library_music, 
                color: aktifSayfa == 2 ? Colors.green : Colors.grey,
              ),
              onPressed: () {
                setState(() {
                  aktifSayfa = 2;
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  // Seçilen sekmeye göre ekrana gelecek olan widget yapısıdır
  Widget _sayfaIceriginiGetir() {
    if (aktifSayfa == 1) {
      return _araSayfasiIcerigi();
    } else if (aktifSayfa == 2) {
      return _kitapligimSayfasiIcerigi();
    } else {
      return _anaSayfaIcerigi();
    }
  }

  //  ANA SAYFA İÇERİĞİDİR
  Widget _anaSayfaIcerigi() {
    return ListView(
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Text(
            "Sık Dinlenenler",
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 10),

        // Sık Dinlenenler GridView Yapısıdır
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: SizedBox(
            height: 180,
            child: GridView.count(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              children: [
                _hizliErisimKarti("Yüzyüzeyken", "https://images.unsplash.com/photo-1514525253161-7a46d19cd819?w=150&q=80"),
                _hizliErisimKarti("Dolu Kadeh", "https://images.unsplash.com/photo-1470225620780-dba8ba36b745?w=150&q=80"),
                _hizliErisimKarti("Madrigal", "https://images.unsplash.com/photo-1498038432885-c6f3f1b912ee?w=150&q=80"),
                _hizliErisimKarti("Mor ve Ötesi", "https://images.unsplash.com/photo-1511671782779-c97d3d27a1d4?w=150&q=80"),
              ],
            ),
          ),
        ),

        const SizedBox(height: 20),

        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            "Senin İçin Hazırlandı",
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 10),

        // Yan yana albüm seçenekleridir
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            children: [
              _albumSecenekKarti(
                "Akustik Türkçe",
                "Sakin ve huzurlu tınılar...",
                "https://images.unsplash.com/photo-1459749411175-04bf5292ceea?w=300&q=80",
              ),
              const SizedBox(width: 15),
              _albumSecenekKarti(
                "Yol Şarkıları",
                "Uzun yolların en iyi eşlikçileri",
                "https://images.unsplash.com/photo-1493225457124-a3eb161ffa5f?w=300&q=80",
              ),
            ],
          ),
        ),

        const SizedBox(height: 20),
        const Divider(color: Colors.grey, thickness: 0.5),
        const SizedBox(height: 10),

        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            "Popüler Sanatçılar",
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 15),
        _sanatciSatiri("Yüzyüzeyken Konuşuruz", "1.2 Milyon Dinleyici", "https://images.unsplash.com/photo-1514525253161-7a46d19cd819?w=150&q=80"),
        _sanatciSatiri("Madrigal", "980 Bin Dinleyici", "https://images.unsplash.com/photo-1498038432885-c6f3f1b912ee?w=150&q=80"),
      ],
    );
  }

  //  ARAMA SAYFASI İÇERİĞİDİR
  Widget _araSayfasiIcerigi() {
    return ListView(
      children: [
        const Padding(
          padding: EdgeInsets.all(16.0),
          child: Text(
            "Ara",
            style: TextStyle(
              color: Colors.white,
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),

        // Arama Kutusudur
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              color: const Color(0xFF242424),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                const Icon(Icons.search, color: Colors.white),
                const SizedBox(width: 10),
                Expanded(
                  child: TextField(
                    onChanged: (yazi) {
                      setState(() {
                        aramaMetni = yazi;
                      });
                    },
                    style: const TextStyle(color: Colors.white),
                    decoration: const InputDecoration(
                      hintText: "Sanatçılar, şarkılar veya podcast'ler...",
                      hintStyle: TextStyle(color: Colors.grey),
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),

        const SizedBox(height: 20),

        // Arama Sonuclarıdır
        if (aramaMetni != "")
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "\"$aramaMetni\" İçin En İyi Sonuç",
                  style: const TextStyle(color: Colors.grey, fontSize: 14),
                ),
                const SizedBox(height: 10),
                _sanatciSatiri(aramaMetni, "Arama ile eşleşen sonuçlar", "https://images.unsplash.com/photo-1511671782779-c97d3d27a1d4?w=150&q=80"),
              ],
            ),
          ),

        // Arama Kategorileridir
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
          child: Text(
            "Hepsine Göz At",
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: SizedBox(
            height: 300,
            child: GridView.count(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              children: [
                _aramaKategoriKarti("Türkçe Pop", Colors.pink),
                _aramaKategoriKarti("Rock Müzik", Colors.deepPurple),
                _aramaKategoriKarti("Hip Hop", Colors.orange),
                _aramaKategoriKarti("Yolculuk", Colors.blue),
              ],
            ),
          ),
        ),
      ],
    );
  }

  //  KİTAPLIĞIM SAYFASI İÇERİĞİDİR
  Widget _kitapligimSayfasiIcerigi() {
    return ListView(
      children: [
        const Padding(
          padding: EdgeInsets.all(16.0),
          child: Text(
            "Kitaplığın",
            style: TextStyle(
              color: Colors.white,
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),

        //  Beğenilen Şarkılar Bölümüdür
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Card(
            color: const Color(0xFF282828),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: const [
                      Icon(Icons.favorite, color: Colors.green, size: 30),
                      SizedBox(width: 15),
                      Text(
                        "Beğenilen Şarkılar",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    "6 Şarkı • Listeyi düzenle",
                    style: TextStyle(color: Colors.grey, fontSize: 13),
                  ),
                ],
              ),
            ),
          ),
        ),

        const SizedBox(height: 15),

        //   Favori Sanatçılar Bölümüdür
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Card(
            color: const Color(0xFF282828),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: const [
                      Icon(Icons.star, color: Colors.orange, size: 30),
                      SizedBox(width: 15),
                      Text(
                        "Favori Sanatçılarım",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    "Yüzyüzeyken Konuşuruz, Madrigal, Dolu Kadehi Ters Tut",
                    style: TextStyle(color: Colors.grey, fontSize: 13),
                  ),
                ],
              ),
            ),
          ),
        ),

        const SizedBox(height: 25),

        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            "Son Eklenen Beğeniler",
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),

        const SizedBox(height: 10),

        _kitaplikSarkiSatiri("Dilsiz Sırdaşım", "Yüzyüzeyken Konuşuruz"),
        _kitaplikSarkiSatiri("Seni Dert Etmeler", "Madrigal"),
        _kitaplikSarkiSatiri("Gitme", "Dolu Kadehi Ters Tut"),
      ],
    );
  }

  // Arama sayfasındaki renkli kare kategori kartı tasarımıdır
  Widget _aramaKategoriKarti(String kategoriAdi, Color arkaPlan) {
    return Container(
      decoration: BoxDecoration(
        color: arkaPlan,
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            kategoriAdi,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  // Kitaplığım sekmesindeki basit şarkı satırı yapısıdır
  Widget _kitaplikSarkiSatiri(String sarkiAdi, String sanatci) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              const Icon(Icons.music_note, color: Colors.green),
              const SizedBox(width: 15),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    sarkiAdi,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    sanatci,
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const Icon(Icons.favorite, color: Colors.green, size: 20),
        ],
      ),
    );
  }

  // Sık dinlenenler için ufak Grid kartları widgetıdır
  Widget _hizliErisimKarti(String baslik, String resimUrl) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF282828),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Column(
        children: [
          Container(
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
            ),
            child: Image.network(resimUrl),
          ),
          const SizedBox(height: 5),
          Text(
            baslik,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 11,
            ),
          ),
        ],
      ),
    );
  }

  // Albüm Seçenek Kartıdır
  Widget _albumSecenekKarti(String baslik, String aciklama, String resimUrl) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetaySayfasi(
              baslik,
              resimUrl,
            ),
          ),
        );
      },
      child: Container(
        width: 150,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 120,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
              ),
              child: Image.network(resimUrl),
            ),
            const SizedBox(height: 8),
            Text(
              baslik,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              aciklama,
              style: const TextStyle(
                color: Colors.grey,
                fontSize: 11,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Sanatçı satırı widgetıdır
  Widget _sanatciSatiri(String ad, String dinleyici, String resimUrl) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetaySayfasi(
              ad,
              resimUrl,
            ),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Row(
          children: [
            CircleAvatar(
              radius: 25,
              backgroundImage: NetworkImage(resimUrl),
            ),
            const SizedBox(width: 15),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  ad,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  dinleyici,
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}