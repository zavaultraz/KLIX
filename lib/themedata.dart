import 'package:flutter/material.dart';

final ThemeData appTheme = ThemeData(
  primaryColor: Color(0xFFF2C94C), // Warna kuning sebagai warna utama
  hintColor: Color(0xFFF2C94C), // Warna sekunder untuk elemen aksen
  scaffoldBackgroundColor: Color(0xFF221F1E), // Latar belakang gelap
  textTheme: TextTheme(
    bodyLarge: TextStyle(color: Colors.white), // Teks utama putih
    bodyMedium: TextStyle(color: Colors.white70), // Teks sekunder abu-abu terang
    titleLarge: TextStyle(fontWeight: FontWeight.bold, fontSize: 24, color: Colors.white), // Judul besar
    bodySmall: TextStyle(color: Colors.white.withOpacity(0.8)), // Teks dengan transparansi rendah
  ),
  iconTheme: IconThemeData(
    color: Colors.white, // Ikon putih
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    selectedItemColor: Color(0xFFF2C94C), // Ikon aktif berwarna kuning
    unselectedItemColor: Colors.white70, // Ikon tidak aktif abu-abu
    backgroundColor: Color(0xFF221F1E), // Background bawah gelap
  ),
);
