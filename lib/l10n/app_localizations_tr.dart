// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Turkish (`tr`).
class AppLocalizationsTr extends AppLocalizations {
  AppLocalizationsTr([String locale = 'tr']) : super(locale);

  @override
  String get appTitle => 'Travli';

  @override
  String get home => 'Ana Sayfa';

  @override
  String get search => 'Ara';

  @override
  String get settings => 'Ayarlar';

  @override
  String get searchForCity => 'Şehir ara...';

  @override
  String get searchResults => 'Arama Sonuçları';

  @override
  String get recentSearches => 'Son Aramalar';

  @override
  String get noRecentSearches => 'Son arama yok';

  @override
  String get clearHistory => 'Geçmişi Temizle';

  @override
  String get recentTrips => 'Son Geziler';

  @override
  String get recentlyViewed => 'Son Görüntülenenler';

  @override
  String get noRecentTrips => 'Henüz gezi yok';

  @override
  String get noRecentlyViewed => 'Son görüntülenen şehir yok';

  @override
  String get preferences => 'Tercihler';

  @override
  String get theme => 'Tema';

  @override
  String get themeLight => 'Açık';

  @override
  String get themeDark => 'Koyu';

  @override
  String get themeSystem => 'Sistem';

  @override
  String get colorScheme => 'Renk Şeması';

  @override
  String get materialYou => 'Material You';

  @override
  String get themeColor => 'Tema Rengi';

  @override
  String get language => 'Dil';

  @override
  String get units => 'Birimler';

  @override
  String get metric => 'Metrik';

  @override
  String get imperial => 'İngiliz';

  @override
  String get account => 'Hesap';

  @override
  String get profile => 'Profil';

  @override
  String get signIn => 'Giriş Yap';

  @override
  String get signOut => 'Çıkış Yap';

  @override
  String get about => 'Hakkında';

  @override
  String get version => 'Sürüm';

  @override
  String get privacyPolicy => 'Gizlilik Politikası';

  @override
  String get termsOfService => 'Kullanım Şartları';

  @override
  String get places => 'Yerler';

  @override
  String get selectPlaces => 'Ziyaret edilecek yerleri seçin';

  @override
  String get generateRoute => 'Rota Oluştur';

  @override
  String get optimizedRoute => 'Optimize Edilmiş Rota';

  @override
  String get saveRoute => 'Rotayı Kaydet';

  @override
  String get shareRoute => 'Rotayı Paylaş';

  @override
  String get noCitiesFound => 'Şehir bulunamadı';

  @override
  String get clearSelection => 'Temizle';

  @override
  String get placesSelected => 'yer seçildi';

  @override
  String get generatingRoute => 'Optimize edilmiş rota oluşturuluyor...';

  @override
  String get loadMore => 'Daha Fazla Yer Yükle';

  @override
  String showingPlaces(int count) {
    return '$count yer gösteriliyor';
  }
}
