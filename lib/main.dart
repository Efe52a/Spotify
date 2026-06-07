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
  // Aktif sayfayı takip etmek için kullandığımız koddur
  int aktifSayfa = 0;

  //  (0: çalmıyor 1: çalıyor) anlamına gelior
  int sarkiCaliyor = 0; 
  String aktifSarkiAdi = "Dilsiz Sırdaşım";
  String aktifSanatci = "Yüzyüzeyken Konuşuruz";
  String aktifResim = "https://images.unsplash.com/photo-1514525253161-7a46d19cd819?w=150&q=80";

  // Arama çubuğuna yazılan metni tutan değişkendir
  String aramaMetni = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF121212),
        elevation: 0,
        automaticallyImplyLeading: false, 
        title: const Text(
          "Spotify",
          style: TextStyle(
            color: Colors.green, // İkonik Spotify Yeşili başlığıdır
            fontWeight: FontWeight.bold,
            fontSize: 26,
          ),
        ),
      ),

      body: Column(
        children: [
          //  Yukarıda seçilen sayfanın içeriğini gösteren dinamik alandır
          Expanded(
            child: _sayfaIceriginiGetir(),
          ),

          //  Ekranın altında her zaman sabit duran Mini Çalar  Alanıdır
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: const Color(0xFF282828),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                // Şarkı Küçük Resmidir
                CircleAvatar(
                  radius: 20,
                  backgroundImage: NetworkImage(aktifResim),
                ),
                const SizedBox(width: 12),
                // Şarkı ve Sanatçı İsmi Alanıdır 
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        aktifSarkiAdi,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        aktifSanatci,
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                // Oynat / Durdur Butonudur
                IconButton(
                  icon: Icon(
                    sarkiCaliyor == 1 ? Icons.pause_circle_filled : Icons.play_circle_filled,
                    color: Colors.green,
                    size: 32,
                  ),
                  onPressed: () {
                    // Butona basıldığında çalma durumunu değiştirir ve ekranı günceller
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

      // Sayfalar arası geçiş yaptıran alt menü barıdır
      bottomNavigationBar: Container(
        color: const Color(0xFF191919),
        height: 60,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: Icon(Icons.home, color: aktifSayfa == 0 ? Colors.green : Colors.grey),
              onPressed: () => setState(() => aktifSayfa = 0),
            ),
            IconButton(
              icon: Icon(Icons.search, color: aktifSayfa == 1 ? Colors.green : Colors.grey),
              onPressed: () => setState(() => aktifSayfa = 1),
            ),
            IconButton(
              icon: Icon(Icons.library_music, color: aktifSayfa == 2 ? Colors.green : Colors.grey),
              onPressed: () => setState(() => aktifSayfa = 2),
            ),
          ],
        ),
      ),
    );
  }

  // Seçilen sekmeye göre ekrana basılacak arayüz fonksiyonudur
  Widget _sayfaIceriginiGetir() {
    if (aktifSayfa == 1) {
      return _araSayfasiIcerigi();
    } else if (aktifSayfa == 2) {
      return _kitapligimSayfasiIcerigi();
    } else {
      return _anaSayfaIcerigi();
    }
  }

  //  ANA SAYFA İÇERİĞİ 
  Widget _anaSayfaIcerigi() {
    return ListView(
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Text(
            "Sık Dinlenenler",
            style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),

        // Sık Dinlenenler  Alanıdır
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
              _hizliErisimKarti("Yüzyüzeyken", "https://images.unsplash.com/photo-1514525253161-7a46d19cd819?w=150&q=80"),
              _hizliErisimKarti("Dolu Kadeh", "https://images.unsplash.com/photo-1470225620780-dba8ba36b745?w=150&q=80"),
              _hizliErisimKarti("Madrigal", "https://images.unsplash.com/photo-1498038432885-c6f3f1b912ee?w=150&q=80"),
              _hizliErisimKarti("Mor ve Ötesi", "https://images.unsplash.com/photo-1511671782779-c97d3d27a1d4?w=150&q=80"),
            ],
          ),
        ),

        const SizedBox(height: 20),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            "Senin İçin Hazırlandı",
            style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(height: 10),

        // Albüm Seçenekleri Kartları
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            children: [
              _albumSecenekKarti("Akustik Türkçe", "Sakin ve huzurlu tınılar...", "https://images.unsplash.com/photo-1459749411175-04bf5292ceea?w=300&q=80"),
              const SizedBox(width: 15),
              _albumSecenekKarti("Yol Şarkıları", "Uzun yolların en iyi eşlikçileri", "https://images.unsplash.com/photo-1493225457124-a3eb161ffa5f?w=300&q=80"),
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
            style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(height: 15),
        _sanatciSatiri("Yüzyüzeyken Konuşuruz", "1.2 Milyon Dinleyici", "https://images.unsplash.com/photo-1514525253161-7a46d19cd819?w=150&q=80"),
        _sanatciSatiri("Madrigal", "980 Bin Dinleyici", "https://images.unsplash.com/photo-1498038432885-c6f3f1b912ee?w=150&q=80"),
      ],
    );
  }

  // ARAMA SAYFASI İÇERİĞİ 
  Widget _araSayfasiIcerigi() {
    return ListView(
      children: [
        const Padding(
          padding: EdgeInsets.all(16.0),
          child: Text("Ara", style: TextStyle(color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold)),
        ),
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
                    decoration: const InputDecoration(
                      hintText: "Sanatçılar, şarkılar...",
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
        if (aramaMetni != "")
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("\"$aramaMetni\" İçin En İyi Sonuç", style: const TextStyle(color: Colors.grey, fontSize: 14)),
                const SizedBox(height: 10),
                _sanatciSatiri(aramaMetni, "Arama ile eşleşen sonuç", "https://images.unsplash.com/photo-1511671782779-c97d3d27a1d4?w=150&q=80"),
              ],
            ),
          ),
      ],
    );
  }

  // KİTAPLIĞIM SAYFASI İÇERİĞİ 
  Widget _kitapligimSayfasiIcerigi() {
    return ListView(
      children: [
        const Padding(
          padding: EdgeInsets.all(16.0),
          child: Text(
            "Kitaplığın", 
            style: TextStyle(color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),
          ),
        ),

        //  Beğenilen Şarkılar Bölümüdür
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: GestureDetector(
            onTap: () {
              // Tıklanınca Beğenilen Şarkılar detay sayfasını açması içindir
              Navigator.push(
                context, 
                MaterialPageRoute(
                  builder: (context) => DetaySayfasi(
                    "Beğenilen Şarkılar", 
                    "https://images.unsplash.com/photo-1514525253161-7a46d19cd819?w=150&q=80",
                  ),
                ),
              );
            },
            child: Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: const Color(0xFF1E1E1E), // Hafif gri-siyah şık bir kart rengi
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  // Yeşil zemin üzerine beyaz kalp ikonudur
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: const Icon(Icons.favorite, color: Colors.white, size: 28),
                  ),
                  const SizedBox(width: 15),
                  // Metin Alanlarıdır
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          "Beğenilen Şarkılar",
                          style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 4),
                        Text(
                          "Çalma Listesi • 142 Şarkı",
                          style: TextStyle(color: Colors.grey, fontSize: 13),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),

        // Favori Sanatçılar Bölümüdür
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: GestureDetector(
            onTap: () {
              // Tıklanınca Favori Sanatçılar detay sayfasını açmasını sağlar
              Navigator.push(
                context, 
                MaterialPageRoute(
                  builder: (context) => DetaySayfasi(
                    "Favori Sanatçılarım", 
                    "https://images.unsplash.com/photo-1498038432885-c6f3f1b912ee?w=150&q=80",
                  ),
                ),
              );
            },
            child: Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: const Color(0xFF1E1E1E),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  // Turuncu zemin üzerine yıldız ikonudur
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.orange,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: const Icon(Icons.star, color: Colors.white, size: 28),
                  ),
                  const SizedBox(width: 15),
                  // Metin Alanları
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          "Favori Sanatçılarım",
                          style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 4),
                        Text(
                          "En Sık Takip Ettiğin İsimler",
                          style: TextStyle(color: Colors.grey, fontSize: 13),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),

        const SizedBox(height: 15),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Text(
            "Son Dinlediklerin", 
            style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),

        // Alt kısımdaki güncel şarkı listesi elemanlarıdır
        _kitaplikSarkiSatiri("Dilsiz Sırdaşım", "Yüzyüzeyken Konuşuruz"),
        _kitaplikSarkiSatiri("Seni Dert Etmeler", "Madrigal"),
      ],
    );
  }

  // Fotoğrafları karenin içine tam sığdıran Sık Dinlenenler kod Tasarımıdır
  Widget _hizliErisimKarti(String baslik, String resimUrl) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => DetaySayfasi(baslik, resimUrl)));
      },
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFF282828), 
          borderRadius: BorderRadius.circular(4),
        ),
        child: Row(
          children: [
            Container(
              width: 55,
              height: 55,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4), 
                image: DecorationImage(
                  image: NetworkImage(resimUrl), 
                ),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                baslik,
                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Fotoğraf taşmasını engelleyen Albüm Kartı tasarımıdır
  Widget _albumSecenekKarti(String baslik, String aciklama, String resimUrl) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => DetaySayfasi(baslik, resimUrl)));
      },
      child: SizedBox(
        width: 150,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 150,
              height: 120,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                image: DecorationImage(
                  image: NetworkImage(resimUrl),
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(baslik, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14)),
            Text(aciklama, style: const TextStyle(color: Colors.grey, fontSize: 11)),
          ],
        ),
      ),
    );
  }

  // Popüler Sanatçılar kod Tasarımıdır
  Widget _sanatciSatiri(String ad, String dinleyici, String resimUrl) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => DetaySayfasi(ad, resimUrl)));
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Row(
          children: [
            CircleAvatar(radius: 25, backgroundImage: NetworkImage(resimUrl)),
            const SizedBox(width: 15),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(ad, style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                Text(dinleyici, style: const TextStyle(color: Colors.grey, fontSize: 13)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Kitaplık Şarkı Satırıdır
  Widget _kitaplikSarkiSatiri(String sarkiAdi, String sanatci) {
    return GestureDetector(
      onTap: () {
        // Şarkı satırına tıklanınca sanatçının detay sayfasına girmesini sağladık
        Navigator.push(
          context, 
          MaterialPageRoute(
            builder: (context) => DetaySayfasi(
              sanatci, 
              "https://images.unsplash.com/photo-1514525253161-7a46d19cd819?w=150&q=80",
            ),
          ),
        );
      },
      child: Padding(
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
                    Text(sarkiAdi, style: const TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold)),
                    Text(sanatci, style: const TextStyle(color: Colors.grey, fontSize: 12)),
                  ],
                ),
              ],
            ),
            const Icon(Icons.favorite, color: Colors.green, size: 20),
          ],
        ),
      ),
    );
  }
}