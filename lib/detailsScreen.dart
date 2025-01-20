import 'package:filmku/Cubit/creditmovie_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:filmku/Service/credits_service.dart';
import 'package:filmku/Cubit/detailmovie_cubit.dart'; // Import cubit untuk state management
import 'package:google_fonts/google_fonts.dart'; // Import untuk font Poppins

class DetailMovieScreen extends StatelessWidget {
  final int movieId; // ID film yang diterima dari parameter

  // Konstruktor untuk menerima movieId
  DetailMovieScreen({required this.movieId});

  @override
  Widget build(BuildContext context) {

    // Memanggil fetchDetailMovie untuk mengambil data film berdasarkan movieId
    Future.microtask(() {
      context.read<DetailMovieCubit>().fetchDetailMovie(movieId);
    });

    return Scaffold(
      backgroundColor: Color(0xFF221F1E), // Warna latar belakang utama
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            BlocBuilder<DetailMovieCubit, DetailMovieState>(
              builder: (context, state) {
                if (state is DetailMovieLoading) {
                  return Center(child: CircularProgressIndicator());
                } else if (state is DetailMovieLoaded) {
                  final detailMovie = state.detailMovie;

                  return SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(
                      children: [
                        // Menggunakan Stack untuk menumpuk backdrop dan poster
                        Stack(
                          children: [
                            // Backdrop Image
                            Container(
                              width: double.infinity,
                              height: 300,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: NetworkImage(
                                    'https://image.tmdb.org/t/p/w500${detailMovie.backdropPath}',
                                  ),
                                  fit: BoxFit.cover,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.5), // Shadow gelap
                                    offset: Offset(0, 4), // Posisi shadow
                                    blurRadius: 10, // Jarak blur
                                  ),
                                ],
                              ),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(0.4), // Opacity untuk backdrop
                                ),
                              ),
                            ),

                            // Tombol Back dan Bagikan di atas gambar (dalam lingkaran putih)
                            Positioned(
                              top: 40, // Posisi dari atas layar
                              left: 16, // Jarak dari sisi kiri
                              child: Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle, // Bentuk lingkaran
                                  color: Colors.white, // Latar belakang putih
                                ),
                                child: IconButton(
                                  icon: Icon(CupertinoIcons.back, color: Colors.black),
                                  onPressed: () {
                                    Navigator.pop(context); // Aksi untuk tombol kembali
                                  },
                                ),
                              ),
                            ),

                            Positioned(
                              top: 40, // Posisi dari atas layar
                              right: 16, // Jarak dari sisi kanan
                              child: Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle, // Bentuk lingkaran
                                  color: Colors.white, // Latar belakang putih
                                ),
                                child: IconButton(
                                  icon: Icon(Icons.share, color: Colors.black),
                                  onPressed: () {
                                    // Tambahkan logika untuk membagikan film
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),

                        // Konten lainnya di bawah backdrop dan poster
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Poster Path di dalam Row, berada di samping informasi lainnya
                              ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Image.network(
                                  'https://image.tmdb.org/t/p/w500${detailMovie.posterPath}',
                                  width: 150,
                                  height: 225,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              SizedBox(width: 16), // Jarak antara poster dan konten lainnya

                              // Kolom untuk Title, Tagline, Genre, dan Adult Badge
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Judul Film
                                    Text(
                                      detailMovie.title ?? "No Title",
                                      style: GoogleFonts.poppins(
                                        fontSize: 28,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                    SizedBox(height: 8),

                                    // Tagline
                                    if (detailMovie.tagline != null) ...[
                                      Text(
                                        '“${detailMovie.tagline}”',
                                        style: GoogleFonts.poppins(
                                          fontSize: 18,
                                          fontStyle: FontStyle.italic,
                                          color: Colors.white70,
                                        ),
                                      ),
                                      SizedBox(height: 7,),
                                      Row(
                                        children: [
                                          Icon(CupertinoIcons.clock,color: Colors.white70,size: 16,),
                                          SizedBox(width: 5,),
                                          Text(
                                            '${detailMovie.runtime?? "N/A"} Minutes',
                                            style: GoogleFonts.poppins(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.white70,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 4,),
                                      Text(
                                        'Release Date: ${detailMovie.releaseDate?.toLocal().toString().split(' ')[0] ?? "N/A"}',
                                        style: GoogleFonts.poppins(
                                          fontSize: 16,
                                          color: Colors.white70,
                                        ),
                                      ),
                                    ],
                                    SizedBox(height: 5,),
                                    // Genre & Adult Badge
                                    Row(
                                      children: [
                                        // Genre
                                        Wrap(
                                          spacing: 8,
                                          children: (detailMovie.genres?.take(2).map((genre) {
                                            return Chip(
                                              label: Text(
                                                genre.name ?? "No Genre",
                                                style: GoogleFonts.poppins(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.w600
                                                ),
                                              ),
                                              backgroundColor: Color(0xFFF2C94C), // Kuning
                                            );
                                          }).toList() ?? []),
                                        ),
                                        Spacer(),
                                        // Adult Badge
                                        if (detailMovie.adult ?? false)
                                          Container(
                                            padding: EdgeInsets.symmetric(
                                              horizontal: 10,
                                              vertical: 5,
                                            ),
                                            decoration: BoxDecoration(
                                              color: Colors.red,
                                              borderRadius: BorderRadius.circular(12),
                                            ),
                                            child: Text(
                                              'Adult',
                                              style: GoogleFonts.poppins(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    'Watch Trailer',
                                    style: GoogleFonts.poppins(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                                Icon(Icons.play_circle_fill_rounded)
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 10,),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Overview:',
                                style: GoogleFonts.poppins(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(height: 8),
                              Text(
                                detailMovie.overview ?? "No Overview Available.",
                                style: GoogleFonts.poppins(
                                  fontSize: 16,
                                  color: Colors.white,
                                ),
                                textAlign: TextAlign.justify,
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    'Production',
                                    style: GoogleFonts.poppins(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 16.0),
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal, // Membuat scroll horizontal
                                  child: Row(
                                    children: detailMovie.productionCompanies?.map((company) {
                                      return Container(
                                        margin: EdgeInsets.symmetric(horizontal: 8),
                                        width: 100,
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            // Logo dengan box shape bulat putih
                                            Container(
                                              width: 75, // Ukuran lebar bulatan
                                              height: 75, // Ukuran tinggi bulatan
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle, // Bentuk bulat
                                                color: Colors.white, // Warna latar belakang putih
                                              ),
                                              child: company.logoPath != null
                                                  ? ClipOval(
                                                child: Image.network(
                                                  'https://image.tmdb.org/t/p/w500${company.logoPath!}',
                                                ),
                                              )
                                                  : Container(width: 50, height: 50), // Placeholder jika logo tidak ada
                                            ),
                                            SizedBox(height: 8),
                                            // Nama perusahaan produksi
                                            Text(
                                              company.name ?? "No Name",
                                              textAlign: TextAlign.center,
                                              style: GoogleFonts.poppins(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                              ),
                                              maxLines: 1,


                                            ),
                                          ],
                                        ),
                                      );
                                    }).toList() ?? [],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 16),
                      ],
                    ),
                  );
                } else if (state is DetailMovieError) {
                  return Center(child: Text('Error: ${state.message}', style: GoogleFonts.poppins(color: Colors.white)));
                } else {
                  return Container();
                }
              },
            ),

          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.read<DetailMovieCubit>().fetchDetailMovie(movieId);
        },
        backgroundColor: Colors.grey[800],
        child: Icon(Icons.refresh, color: Colors.white),
      ),
    );
  }
}
