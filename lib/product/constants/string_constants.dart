import 'package:flutter/material.dart';

@immutable
class StringConstants {
  const StringConstants._();
  static const String appName = 'Yuva Bul';
  static const String splashViewTitle = 'Hoşgeldiniz!';
  static const String login = 'Giriş Yap';
  static const String register = 'Üye Ol';
  static const String homeViewTitle = 'Ailenin Yeni Üyesini Bul';
  static const String addViewTitle = 'Yeni Üye Ekle';
  static const String addPhoto = 'Fotoğraf Ekleyiniz';
  static const String addInformation = 'Ev Arayan Dostumuzun ismini giriniz:';
  static const String appViewHome = 'Ana Sayfa';
  static const String appViewAdd = 'Ekle';
  static const String appViewSearch = 'Arama';
  static const String appViewProfil = 'Profil';

  //HomeView
  //kategoriler
  static const String cat = 'Kedi';
  static const String dog = 'Köpek';
  static const String all = 'Hepsi';
  //bulunamadı uyarısı
  static const String notFind = 'Hayvan Bulunamadı.';
  //HomeViewDetails
  static const String searchHintText = 'Arama';
  static const String adopt = 'Sahiplen';

  //AddView
  static const String addviewtitle = 'Yeni Üye Ekle';
  static const String addViewWarning = 'Lütfen tüm bilgileri giriniz.';
  static const String failed = 'Kayıt başarısız';
  static const String save = 'Kaydet';
  //components
  static const String dropdownhint = 'kategori seç';
  static const String textFieldTitle = 'İsim giriniz';
  static const String textfieldsubtitle = 'bilgi giriniz';
  static const String textfieldphonenumber = 'telefon numarası';

  //profilView
  static const String profilViewSubtitle = 'Profil fotoğrafı seç';
  //favoriler
  static const String favorites = 'Favoriler';

  //loginView
  static const String loginError = 'Giriş Hatası';
  static const String dontMatch = 'Şifreler Eşleşmiyor.';
  static const String registerError = 'Kayıt Hatası';
  static const String email = 'email';
  static const String password = 'şifre';
  static const String comeBack = 'Geri Dön';
}
