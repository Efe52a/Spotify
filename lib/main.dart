import 'package:flutter/material.dart';
import 'detaysayfasi.dart'; 

void main() {
  // Uygulamayı başlatan ana fonksiyondur
  runApp(const MyApp());
}

// Uygulamanın genel temasını ve ana ayarlarını barındıran koddur
class MyApp extends StatelessWidget {
  const MyApp(); 

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Spotify Klonu',
      // Sağ üstteki hata ayıklama kodunu gizler
      debugShowCheckedModeBanner: false,
      // Uygulamanın genel koyu renk temasını ayarlar
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFF121212),
        primaryColor: Colors.green,
      ),
      // Uygulama açıldığında ilk yüklenecek olan ana sayfa widgetdır
      home: const AnaSayfa(),
    );
  }
}

// Durumu dinamik olarak değişebilen (Sayfa değiştirme, şarkı oynatma) Ana Sayfa kodudur
class AnaSayfa extends StatefulWidget {
  const AnaSayfa();

  @override
  State<AnaSayfa> createState() => _AnaSayfaState();
}

// Ana Sayfa'nın durumunu ve arayüz elemanlarını yöneten koddur
class _AnaSayfaState extends State<AnaSayfa> {
  int aktifSayfa = 0;      
  int sarkiCaliyor = 0;     // Şarkının durumunu tutar (0: Durduruldu, 1: Oynatılıyor) anlamına geliyor
  String aktifSarkiAdi = "Dilsiz Sırdaşım";
  String aktifSanatci = "Yüzyüzeyken Konuşuruz";
  String aktifResim = "https://images.unsplash.com/photo-1514525253161-7a46d19cd819?w=150&q=80";
  String aramaMetni = "";   // TextField içine yazılan arama kelimesini aklında tutmasına yarayan koddur

  @override
  Widget build(BuildContext context) {
    // Scaffold: Sayfa iskeletini, AppBar'ı ve BottomNavigationBar'ı bir arada tutan ana yapıdır
    return Scaffold(
      // AppBar: Sayfanın en üstünde yer alan başlık alanı
      appBar: AppBar(
        backgroundColor: const Color(0xFF121212),
        elevation: 0, // AppBar'ın altındaki gölgeyi sıfırlar
        automaticallyImplyLeading: false, // Geri butonunun otomatik çıkmasını engeller
        title: const Text("Spotify", style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold, fontSize: 26)),
      ),
      // Body: Sayfanın ana içerik alanı Dikey hizalama için Column kullandım
      body: Column(
        children: [
          // Expanded: Sayfa içeriğinin (ListView  kalan tüm boş alanı kaplamasını sağlaadım
          Expanded(child: _sayfaIceriginiGetir()),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(color: const Color(0xFF282828), borderRadius: BorderRadius.circular(8)),
            child: Row(
              children: [
                // Şarkı kapağını yuvarlak gösteren widgettir
                CircleAvatar(radius: 20, backgroundImage: NetworkImage(aktifResim)),
                const SizedBox(width: 12), // Resim ile yazı arasındaki boşluktur
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min, // İçeriği kadar dikey yer kaplar
                    children: [
                      Text(aktifSarkiAdi, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14)),
                      Text(aktifSanatci, style: const TextStyle(color: Colors.grey, fontSize: 12)),
                    ],
                  ),
                ),
                // Oynat/Durdur işlevini yapan ikonlu butondur
                IconButton(
                  icon: Icon(sarkiCaliyor == 1 ? Icons.pause_circle_filled : Icons.play_circle_filled, color: Colors.green, size: 32),
                  onPressed: () {
                    // setState: Ekranın anlık olarak güncellenmesini ve ikonun değişmesini tetikler
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
      // BottomNavigationBar: Sayfanın en altındaki sekmeli menü yapısıdır
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(0xFF191919),
        currentIndex: aktifSayfa, // O an hangi menünün seçili olduğunu belirtir
        selectedItemColor: Colors.green, // Seçili olan menünün rengi
        unselectedItemColor: Colors.grey, // Seçili olmayan menülerin rengi
        onTap: (index) => setState(() => aktifSayfa = index), // Menüye tıklandığında sayfayı değiştirir
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Ana Sayfa"),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: "Ara"),
          BottomNavigationBarItem(icon: Icon(Icons.library_music), label: "Kitaplığın"),
        ],
      ),
    );
  }
  // Alt menüden seçilen değere göre ekrana gelecek arayüzü seçmesini sağlar
  Widget _sayfaIceriginiGetir() {
    if (aktifSayfa == 1) return _araSayfasiIcerigi();
    if (aktifSayfa == 2) return _kitapligimSayfasiIcerigi();
    return _anaSayfaIcerigi(); // Eğer index 0 ise Ana Sayfa gelir
  }
  Widget _anaSayfaIcerigi() {
    // ListView: Ekranın aşağı doğru kaydırılabilir olmasını sağladım
    return ListView(
      children: [
        const Padding(padding: EdgeInsets.all(16.0), child: Text("Sık Dinlenenler", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold))),
        
        // GridView: Kartları 2'li yan yana ızgara şeklinde listelemek için kullandım
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: GridView.count(
            shrinkWrap: true, // GridView'ın ListView içinde hata vermeden çalışmasını sağladım
            physics: const NeverScrollableScrollPhysics(), // Kaydırma özelliğini ListView'a devrettim
            crossAxisCount: 2, // Yan yana kaç adet kart olacağını belirledim
            crossAxisSpacing: 10, // Yatay boşluk
            mainAxisSpacing: 10,  // Dikey boşluk
            childAspectRatio: 3.0, // Kartların en-boy oranını ayarladım
            children: [
              _kartTasarimi("Yüzyüzeyken", "https://images.unsplash.com/photo-1514525253161-7a46d19cd819?w=150&q=80"),
              _kartTasarimi("Dolu Kadeh", "https://images.unsplash.com/photo-1470225620780-dba8ba36b745?w=150&q=80"),
              _kartTasarimi("Madrigal", "https://images.unsplash.com/photo-1498038432885-c6f3f1b912ee?w=150&q=80"),
              _kartTasarimi("Mor ve Ötesi", "https://images.unsplash.com/photo-1511671782779-c97d3d27a1d4?w=150&q=80"),
            ],
          ),
        ),
        
        const Padding(padding: EdgeInsets.all(16.0), child: Text("Senin İçin Hazırlandı", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold))),
        
        // Row: Albüm önerilerini yan yana dizmek için kullandım
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            children: [
              _albumTasarimi("Akustik Türkçe", "Sakin ve huzurlu tınılar...", "https://images.unsplash.com/photo-1459749411175-04bf5292ceea?w=300&q=80"),
              const SizedBox(width: 15), // İki albüm arasındaki yatay boşluk
              _albumTasarimi("Yol Şarkıları", "Uzun yolların en iyi eşlikçileri", "https://images.unsplash.com/photo-1493225457124-a3eb161ffa5f?w=300&q=80"),
            ],
          ),
        ),
        
        const SizedBox(height: 20),
        // Divider: Sayfaya yatay ince bir çizgi  eklemek için kullandım
        const Divider(color: Colors.grey, thickness: 0.5),
        
        const Padding(padding: EdgeInsets.all(16.0), child: Text("Popüler Sanatçılar", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold))),
        // Alt alta listelenen popüler sanatçı satırları
        _listeSatirTasarimi("Yüzyüzeyken Konuşuruz", "1.2 Milyon Dinleyici", "https://images.unsplash.com/photo-1514525253161-7a46d19cd819?w=150&q=80", true, null, null),
        _listeSatirTasarimi("Madrigal", "980 Bin Dinleyici", "https://images.unsplash.com/photo-1498038432885-c6f3f1b912ee?w=150&q=80", true, null, null),
      ],
    );
  }

  //
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
                const Icon(Icons.search, color: Colors.white), // Arama büyüteç ikonu
                const SizedBox(width: 10),
                Expanded(
                  // TextField: Kullanıcının klavyeden yazı yazmasını sağlayan girdi alanı
                  child: TextField(
                    // onChanged: Kullanıcı yazı yazdıkça tetiklenir ve aramaMetni değişkenini günceller
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
        //  Eğer arama kutusu boş değilse arama sonuç panelini ekrana getirir
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
        // Kitaplık sayfasının üstündeki büyük renkli kutular (Card tasarımları)
        _kitaplikBuyukKart("Beğenilen Şarkılar", "Çalma Listesi • 142 Şarkı", Icons.favorite, Colors.green),
        _kitaplikBuyukKart("Favori Sanatçılarım", "En Sık Takip Ettiğin İsimler", Icons.star, Colors.orange),
        
        const Padding(padding: EdgeInsets.all(16.0), child: Text("Son Dinlediklerin", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold))),
        // Son dinlenen şarkıların alt alta listelendiği satırlar
        _listeSatirTasarimi("Dilsiz Sırdaşım", "Yüzyüzeyken Konuşuruz", "https://images.unsplash.com/photo-1514525253161-7a46d19cd819?w=150&q=80", false, Icons.music_note, Icons.favorite),
        _listeSatirTasarimi("Seni Dert Etmeler", "Madrigal", "https://images.unsplash.com/photo-1514525253161-7a46d19cd819?w=150&q=80", false, Icons.music_note, Icons.favorite),
      ],
    );
  }
  // Sık Dinlenenler bölümündeki küçük 2'li butonlu kart yapısını ekledim
  Widget _kartTasarimi(String baslik, String resimUrl) {
    return TextButton(
      style: TextButton.styleFrom(padding: EdgeInsets.zero),
      onPressed: () {
        // Navigator.push & MaterialPageRoute: Karta tıklandığında Detay Sayfasına veri göndererek geçiş yapar
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

  // Senin İçin Hazırlandı bölümündeki dikey albüm öneri kart yapısının kodudur
  Widget _albumTasarimi(String baslik, String aciklama, String resimUrl) {
    return TextButton(
      style: TextButton.styleFrom(padding: EdgeInsets.zero),
      onPressed: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => DetaySayfasi(baslik, resimUrl)));
      },
      // SizedBox: Elemana sabit bir genişlik vererek taşmaları önleyen koddur
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

  // Listelerdeki (Sanatçı satırları veya Şarkı listeleri) ortak yatay satır şablonudur
  Widget _listeSatirTasarimi(String baslik, String altBaslik, String resimUrl, bool yuvarlakMi, IconData? solIkon, IconData? sagIkon) {
    return TextButton(
      style: TextButton.styleFrom(padding: EdgeInsets.zero),
      onPressed: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => DetaySayfasi(baslik, resimUrl)));
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween, // Sol ve sağ ikonları iki uca yaslar
          children: [
            Row(
              children: [
                // Parametreden gelen duruma göre resmi yuvarlak (Sanatçı) veya ikonlu (Şarkı) yapmasını sağlar
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
            // Eğer sağ tarafa bir etkileşim ikonu  gönderilmişse onu çizmesini sağlar
            if (sagIkon != null) Icon(sagIkon, color: Colors.green, size: 20),
          ],
        ),
      ),
    );
  }

  // Kitaplık sayfasında yer alan büyük kare ikonlu listeleme kartlarını gösteren koddur
  Widget _kitaplikBuyukKart(String baslik, String aciklama, IconData ikon, Color ikonRenk) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: TextButton(
        style: TextButton.styleFrom(padding: EdgeInsets.zero),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => DetaySayfasi(baslik, "https://images.unsplash.com/photo-1514525253161-7a46d19cd819?w=150&q=80")));
        },
        // Card görünümlü Container yapısıdır
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
//BU UYGULAMA MOBİL PROGRAMLAMA DERSİ KAPSAMINDA GELİŞTİRİLMİŞTİR.
