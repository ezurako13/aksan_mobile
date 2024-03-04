import 'package:aksan_mobile/src/routing/route_state.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'page.dart';

final pages = Library()
  ..addPage(
      category: Category.main,
      title: 'Ana Sayfa',
      icon: const Icon(Icons.home_outlined),
      url: '/Home/Index')
  ..addPage(
      category: Category.main,
      title: 'Cari Kartlar',
      icon: const Icon(Icons.copy),
      url: '/CariCard/CariCard')
  ..addPage(
      category: Category.main,
      title: 'Satış Görüşmeleri',
      icon: const Icon(Icons.people),
      url: '/SatisGorusmeleri/SatisGorusmeleri')
  ..addPage(
      category: Category.main,
      title: 'Tahsilatlar',
      icon: const Icon(Icons.money),
      url: '/Tahsilat/TahsilatList')
  ..addPage(
      category: Category.main,
      title: 'Ana Sayfa',
      icon: const Icon(Icons.logout_rounded),
      url: '/Login/LogOut')
  ..addPage(
      category: Category.main,
      title: 'Diğer Sayfalar',
      icon: const Icon(Icons.menu),
      url: '/')
  ..addPage(
      category: Category.raporlar,
      title: 'Görüşme Raporu',
      icon: const Icon(Icons.chat_rounded),
      url: '/SatisRaporu/SatisRaporu')
  ..addPage(
      category: Category.raporlar,
      title: 'Kullanıcı Görüşme Girişleri',
      icon: const Icon(Icons.people_rounded),
      url: '/Rapor/GorusmeSayisi')
  ..addPage(
      category: Category.raporlar,
      title: 'Ciro Raporları',
      icon: const Icon(Icons.file_copy_rounded),
      url: '/CariCiroRaporu/CiroRaporu')
  ..addPage(
      category: Category.sistemYonetimi,
      title: 'Duyurular',
      icon: const Icon(Icons.announcement_rounded),
      url: '/Duyurular/Duyurular')
  ..addPage(
      category: Category.sistemYonetimi,
      title: 'Kullanıcılar',
      icon: const Icon(Icons.people_rounded),
      url: '/Kullanicilar/Kullanicilar')
  ..addPage(
      category: Category.sistemYonetimi,
      title: 'Log Kayıtları',
      icon: const Icon(Icons.data_object_rounded),
      url: '/LogGiris/LogGiris')
  ..addPage(
      category: Category.sistemYonetimi,
      title: 'Firma Personel Transferi',
      icon: const Icon(Icons.swap_horizontal_circle_rounded),
      url: '/SatisGorusmeleri/PersonelGuncelle')
  ..addPage(
      category: Category.tanimlamalar,
      title: 'Bölgeler',
      icon: const Icon(Icons.landscape_rounded),
      url: '/Bolgeler/Bolgeler')
  ..addPage(
      category: Category.tanimlamalar,
      title: 'Görüşme Türleri',
      icon: const Icon(Icons.chat_rounded),
      url: '/GorusmeTurleri/GorusmeTurleri')
  ..addPage(
      category: Category.tanimlamalar,
      title: 'Firma Sınıfı',
      icon: const Icon(Icons.class_rounded),
      url: '/FirmaSinif/FirmaList')
  ..addPage(
      category: Category.tanimlamalar,
      title: 'Kampanyalar',
      icon: const Icon(Icons.campaign_rounded),
      url: '/Kampanya/KampanyaList')
  ..addPage(
      category: Category.tanimlamalar,
      title: 'Markalar(Metal)',
      icon: const Icon(Icons.branding_watermark_sharp),
      url: '/Markalar/MarkaListesi')
  ..addPage(
      category: Category.tanimlamalar,
      title: 'Markalar(Plastik)',
      icon: const Icon(Icons.branding_watermark_rounded),
      url: '/Markalar/MarkaListePlastik')
  ..addPage(
      category: Category.tanimlamalar,
      title: 'Sonuçlar',
      icon: const Icon(Icons.output_rounded),
      url: '/Sonuc/SonucListesi')
  ..addPage(
      category: Category.tanimlamalar,
      title: 'Vergi Daireleri',
      icon: const Icon(Icons.payments_rounded),
      url: '/VergiDaireleri/VergiDairesiList')
  ..addPage(
      category: Category.tanimlamalar,
      title: 'Ödeme Şekli',
      icon: const Icon(Icons.payment_rounded),
      url: '/OdemeSekli/OdemeSekli');

class Library {
  final List<PageURL> allPages = [];

  PageURL get anaSayfa => allPages[0];
  PageURL get cariKartlar => allPages[1];
  PageURL get satisGorusmeleri => allPages[2];
  PageURL get tahsilatlar => allPages[3];
  PageURL get cikis => allPages[4];
  PageURL get diger => allPages[5];

  void addPage({
    required Category category,
    required String title,
    required Icon icon,
    required String url,
  }) {
    var page = PageURL(allPages.length, category, title, icon, url);

    allPages.add(page);
  }

  PageURL? getPage(RouteState routeState) {
    final pathTemplate = routeState.route.pathTemplate;

    PageURL? selectedPage;
    if (pathTemplate == '/anaSayfa') {
      selectedPage = pages.anaSayfa;
    } else if (pathTemplate == '/cariKartlar') {
      selectedPage = pages.cariKartlar;
    } else if (pathTemplate == '/satisGorusmeleri') {
      selectedPage = pages.satisGorusmeleri;
    } else if (pathTemplate == '/tahsilatlar') {
      selectedPage = pages.tahsilatlar;
    } else if (pathTemplate == '/diger') {
      selectedPage = pages.diger;
    } else if (pathTemplate == '/cikis') {
      selectedPage = pages.cikis;
    } else if (pathTemplate == '/page/:pageId') {
      selectedPage = pages.allPages.firstWhereOrNull(
          (b) => b.id.toString() == routeState.route.parameters['pageId']);
    }
    return selectedPage;
  }

  List<PageURL> get raporlar => [
        ...allPages.where((page) => page.category == Category.raporlar),
      ];

  List<PageURL> get sistemYonetimi => [
        ...allPages.where((page) => page.category == Category.sistemYonetimi),
      ];

  List<PageURL> get tanimlamalar => [
        ...allPages.where((page) => page.category == Category.tanimlamalar),
      ];
}
