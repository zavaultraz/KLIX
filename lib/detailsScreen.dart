import 'package:carousel_slider/carousel_slider.dart';
import 'package:filmku/Cubit/creditmovie_cubit.dart';
import 'package:filmku/Cubit/image_movie_cubit.dart';
import 'package:filmku/Cubit/recommendation_cubit.dart';
import 'package:filmku/Cubit/review_cubit.dart';
import 'package:filmku/Cubit/video_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:filmku/Service/credits_service.dart';
import 'package:filmku/Cubit/detailmovie_cubit.dart'; // Import cubit untuk state management
import 'package:google_fonts/google_fonts.dart';
import 'package:readmore/readmore.dart';
import 'package:url_launcher/url_launcher.dart'; // Import untuk font Poppins

class DetailMovieScreen extends StatelessWidget {
  final int movieId; // ID film yang diterima dari parameter

  // Konstruktor untuk menerima movieId
  DetailMovieScreen({required this.movieId});

  @override
  Widget build(BuildContext context) {
    // Memanggil fetchDetailMovie untuk mengambil data film berdasarkan movieId
    Future.microtask(() {
      context.read<DetailMovieCubit>().fetchDetailMovie(movieId);
      context.read<CreditsCubit>().fetchCredits(movieId);
      context.read<RecommendationCubit>().fetchRecommendations(movieId);
      context.read<ImageMovieCubit>().fetchImages(movieId);
      context.read<ReviewCubit>().fetchReviews(movieId);
      context.read<VideoCubit>().fetchVideos(movieId);
    });


    return Scaffold(
      backgroundColor: Color(0xFF221F1E), // Warna latar belakang utama
      body: Center(
        child: SingleChildScrollView(
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
                                      color: Colors.black
                                          .withOpacity(0.5), // Shadow gelap
                                      offset: Offset(0, 4), // Posisi shadow
                                      blurRadius: 10, // Jarak blur
                                    ),
                                  ],
                                ),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.black.withOpacity(
                                        0.4), // Opacity untuk backdrop
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
                                    icon: Icon(CupertinoIcons.back,
                                        color: Colors.black),
                                    onPressed: () {
                                      Navigator.pop(
                                          context); // Aksi untuk tombol kembali
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
                                    icon:
                                        Icon(Icons.share, color: Colors.black),
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
                                SizedBox(
                                    width:
                                        16), // Jarak antara poster dan konten lainnya

                                // Kolom untuk Title, Tagline, Genre, dan Adult Badge
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                        SizedBox(
                                          height: 7,
                                        ),
                                        Row(
                                          children: [
                                            Icon(
                                              CupertinoIcons.clock,
                                              color: Colors.white70,
                                              size: 16,
                                            ),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Text(
                                              '${detailMovie.runtime ?? "N/A"} Minutes',
                                              style: GoogleFonts.poppins(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600,
                                                color: Colors.white70,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 4,
                                        ),
                                        Text(
                                          'Release Date: ${detailMovie.releaseDate?.toLocal().toString().split(' ')[0] ?? "N/A"}',
                                          style: GoogleFonts.poppins(
                                            fontSize: 16,
                                            color: Colors.white70,
                                          ),
                                        ),
                                      ],
                                      SizedBox(
                                        height: 5,
                                      ),
                                      // Genre & Adult Badge
                                      Row(
                                        children: [
                                          // Genre
                                          Wrap(
                                            spacing: 8,
                                            children: (detailMovie.genres
                                                    ?.take(1)
                                                    .map((genre) {
                                                  return Chip(
                                                    label: Text(
                                                      genre.name ?? "No Genre",
                                                      style:
                                                          GoogleFonts.poppins(
                                                              color:
                                                                  Colors.white,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600),
                                                    ),
                                                    backgroundColor: Color(
                                                        0xFFF2C94C), // Kuning
                                                  );
                                                }).toList() ??
                                                []),
                                          ),
                                          Spacer(),
                                          // Adult Badge
                                          if (detailMovie.adult ?? true)
                                            Container(
                                              padding: EdgeInsets.symmetric(
                                                horizontal: 10,
                                                vertical: 5,
                                              ),
                                              decoration: BoxDecoration(
                                                color: Colors.red,
                                                borderRadius:
                                                    BorderRadius.circular(12),
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
                            padding: const EdgeInsets.symmetric(horizontal: 16.0),
                            child: BlocBuilder<VideoCubit, VideoState>(
                              builder: (context, state) {
                                if (state is VideoLoading) {
                                  return Center(child: CircularProgressIndicator());
                                } else if (state is VideoLoaded) {
                                  final videos = state.videos;

                                  Future<void> _launchUrl(String videoKey) async {
                                    final Uri _url = Uri.parse('https://www.youtube.com/watch?v=$videoKey');
                                    if (!await launchUrl(_url)) {
                                      throw Exception('Could not launch $_url');
                                    }
                                  }
// Ambil key video pertama
                                  if (videos.isNotEmpty) {
                                    final firstVideoKey = videos[0].key;
                                    print("ini link nya : $firstVideoKey");

                                    return Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Expanded(
                                              child: ElevatedButton(
                                                onPressed: _launchUrl(videoKey),
                                                child: Container(
                                                  padding: EdgeInsets.all(10.0), // Padding di dalam tombol
                                                  decoration: BoxDecoration(
                                                    color: Color(0xFFF2C94C), // Warna latar belakang tombol
                                                    borderRadius: BorderRadius.circular(10), // Sudut melengkung
                                                  ),
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.center, // Pusatkan konten
                                                    children: [
                                                      Text(
                                                        'Watch Trailer',
                                                        style: GoogleFonts.poppins(
                                                          fontSize: 18,
                                                          fontWeight: FontWeight.bold,
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                      SizedBox(width: 8), // Jarak antara teks dan ikon
                                                      Icon(Icons.play_circle_fill_rounded, color: Colors.white),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    );
                                  } else {
                                    return Text(
                                      'No videos available.',
                                      style: TextStyle(color: Colors.white),
                                    );
                                  }
                                } else if (state is VideoError) {
                                  return Center(
                                    child: Text('Error: ${state.message}', style: TextStyle(color: Colors.red)),
                                  );
                                } else {
                                  return Container(); // State default
                                }
                              },
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 16.0),
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
                                ReadMoreText(
                                  detailMovie.overview ??
                                      "No Overview Available.",
                                  trimLines: 3,
                                  colorClickableText: Colors.orangeAccent,
                                  trimMode: TrimMode.Line,
                                  trimCollapsedText: ' ...Show more',
                                  trimExpandedText: ' ...Show less',
                                  style: GoogleFonts.poppins(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white,
                                  ),
                                  textAlign: TextAlign.justify,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          BlocBuilder<ImageMovieCubit, ImageMovieState>(
                            builder: (context, state) {
                              if (state is ImageMovieLoading) {
                                return Center(
                                    child: CircularProgressIndicator());
                              } else if (state is ImageMovieLoaded) {
                                final images = state.images
                                    .take(5)
                                    .toList(); // Ambil hanya 5 gambar pertama

                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  child: Column(
                                    children: [
                                      CarouselSlider(
                                        options: CarouselOptions(
                                          autoPlay:
                                              true, // Mengaktifkan autoplay
                                          enlargeCenterPage:
                                              true, // Memperbesar gambar di tengah carousel
                                          aspectRatio: 16 /
                                              9, // Mengatur rasio aspek gambar
                                          viewportFraction:
                                              1.0, // Gambar akan mengisi seluruh lebar layar
                                          onPageChanged: (index, reason) {
                                            // Menambahkan logika untuk memperbarui indikator jika perlu
                                            context
                                                .read<ImageMovieCubit>()
                                                .emit(
                                                  ImageMovieLoaded(images),
                                                );
                                          },
                                        ),
                                        items: images.map((image) {
                                          return Container(
                                            margin: EdgeInsets.symmetric(
                                                horizontal: 8),
                                            width: MediaQuery.of(context)
                                                .size
                                                .width, // Menggunakan lebar layar penuh
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              child: image.image != null
                                                  ? Image.network(
                                                      'https://image.tmdb.org/t/p/w500${image.image!}',
                                                      fit: BoxFit
                                                          .cover, // Menyesuaikan gambar agar memenuhi lebar
                                                    )
                                                  : Container(
                                                      color: Colors
                                                          .grey, // Placeholder jika tidak ada gambar
                                                    ),
                                            ),
                                          );
                                        }).toList(),
                                      ),
                                      SizedBox(height: 8),
                                      // Indikator untuk carousel
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children:
                                            images.asMap().entries.map((entry) {
                                          return GestureDetector(
                                            onTap: () {
                                              // Untuk memperlihatkan gambar tertentu berdasarkan index
                                              // Anda bisa menambahkan logika lain untuk mengubah halaman carousel
                                            },
                                            child: Container(
                                              width: 8.0,
                                              height: 8.0,
                                              margin: EdgeInsets.symmetric(
                                                  horizontal: 4.0),
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Colors.white.withOpacity(entry
                                                            .key ==
                                                        context
                                                            .read<
                                                                ImageMovieCubit>()
                                                            .state
                                                    ? 0.9
                                                    : 0.4), // Membuat indikator aktif lebih terang
                                              ),
                                            ),
                                          );
                                        }).toList(),
                                      ),
                                    ],
                                  ),
                                );
                              } else if (state is ImageMovieError) {
                                return Center(
                                    child: Text('Error: ${state.message}',
                                        style: GoogleFonts.poppins(
                                            color: Colors.white)));
                              } else {
                                return Container();
                              }
                            },
                          ),
                          BlocBuilder<ReviewCubit, ReviewState>(
                            builder: (context, state) {
                              if (state is ReviewLoading) {
                                return Center(
                                    child: CircularProgressIndicator());
                              } else if (state is ReviewLoaded) {
                                final reviews =
                                    state.reviews; // Ambil daftar review

                                return Padding(
                                  padding: const EdgeInsets.all(
                                      16.0), // Padding di sekitar Column
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Reviews',
                                        style: GoogleFonts.poppins(
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                      SizedBox(height: 8),
                                      // Menampilkan semua review
                                      for (var review in reviews) ...[
                                        Card(
                                          margin: EdgeInsets.symmetric(
                                              vertical: 8.0),
                                          color: Color(
                                              0xFF2C2A29), // Warna latar belakang kartu
                                          elevation:
                                              4, // Bayangan untuk efek kedalaman
                                          child: Padding(
                                            padding: const EdgeInsets.all(12.0),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                // Menampilkan nama penulis
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        // Menampilkan gambar profil jika ada, jika tidak tampilkan ClipOval kosong
                                                        review.avatarPath !=
                                                                null
                                                            ? ClipOval(
                                                                child: Image
                                                                    .network(
                                                                  'https://image.tmdb.org/t/p/w500${review.avatarPath!}',
                                                                  width: 50,
                                                                  height: 50,
                                                                  fit: BoxFit
                                                                      .cover,
                                                                ),
                                                              )
                                                            : ClipOval(
                                                                child:
                                                                    Container(
                                                                  width: 40,
                                                                  height: 40,
                                                                  color: Colors
                                                                      .grey, // Placeholder jika tidak ada gambar
                                                                  child: Icon(
                                                                    Icons
                                                                        .person,
                                                                    color: Colors
                                                                        .white,
                                                                  ),
                                                                ),
                                                              ),
                                                        SizedBox(width: 8),
                                                        Text(
                                                          review.author,
                                                          style: GoogleFonts
                                                              .poppins(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 20,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    if (review.rating != null)
                                                      Text(
                                                        '${review.rating!.toString()}/10.0',
                                                        style:
                                                            GoogleFonts.poppins(
                                                          color: Colors.white,
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                        ),
                                                      ),
                                                  ],
                                                ),
                                                SizedBox(height: 8),
                                                // Menampilkan konten review
                                                ReadMoreText(
                                                  review.content,
                                                  trimLines: 3,
                                                  colorClickableText:
                                                      Colors.orangeAccent,
                                                  trimMode: TrimMode.Line,
                                                  trimCollapsedText:
                                                      ' Show more',
                                                  trimExpandedText:
                                                      ' Show less',
                                                  style: GoogleFonts.poppins(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w500,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                                SizedBox(height: 4),
                                                // Menampilkan rating jika ada
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                      // Jika tidak ada review
                                      if (reviews.isEmpty)
                                        Text(
                                          'No reviews available.',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                    ],
                                  ),
                                );
                              } else if (state is ReviewError) {
                                return Center(
                                  child: Text('Error: ${state.message}',
                                      style: TextStyle(color: Colors.red)),
                                );
                              } else {
                                return Container(); // State default
                              }
                            },
                          ),
                          // Menambahkan BlocBuilder untuk kredit film (cast)
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Cast:',
                                  style: GoogleFonts.poppins(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                SizedBox(height: 8),
                                BlocBuilder<CreditsCubit, CreditsState>(
                                  builder: (context, state) {
                                    if (state is CreditsLoading) {
                                      return Center(
                                          child: CircularProgressIndicator());
                                    } else if (state is CreditsLoaded) {
                                      final credits = state.credits;

                                      // Debugging: Pastikan credits adalah List<Credits>
                                      print(
                                          credits); // Memeriksa nilai dan tipe credits

                                      return SingleChildScrollView(
                                        scrollDirection: Axis
                                            .horizontal, // Scroll horizontal untuk cast
                                        child: Row(
                                          children: credits.map((actor) {
                                            return Container(
                                              margin: EdgeInsets.symmetric(
                                                  horizontal: 8),
                                              width: 100,
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Container(
                                                    width: 100,
                                                    height: 100,
                                                    decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      color: Colors.white,
                                                    ),
                                                    child: actor.image != null
                                                        ? ClipRRect(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
                                                            child:
                                                                Image.network(
                                                              'https://image.tmdb.org/t/p/w500${actor.image!}',
                                                              fit: BoxFit.cover,
                                                            ),
                                                          )
                                                        : Container(
                                                            width: 50,
                                                            height: 50,
                                                            child: Icon(
                                                              Icons.person,
                                                              size: 100,
                                                              color:
                                                                  Colors.grey,
                                                            ),
                                                          ),
                                                  ),
                                                  SizedBox(height: 8),
                                                  Text(
                                                    actor.name ?? "No Name",
                                                    textAlign: TextAlign.center,
                                                    style: GoogleFonts.poppins(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                    maxLines: 1,
                                                  ),
                                                  SizedBox(height: 4),
                                                  Text(
                                                    actor.character ??
                                                        "No Character",
                                                    textAlign: TextAlign.center,
                                                    style: GoogleFonts.poppins(
                                                      color: Colors.white70,
                                                      fontSize: 12,
                                                    ),
                                                    maxLines: 1,
                                                  ),
                                                ],
                                              ),
                                            );
                                          }).toList(),
                                        ),
                                      );
                                    } else if (state is CreditsError) {
                                      return Center(
                                          child: Text('Error: ${state.message}',
                                              style: GoogleFonts.poppins(
                                                  color: Colors.white)));
                                    } else {
                                      return Container();
                                    }
                                  },
                                )
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
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 16.0),
                                  child: SingleChildScrollView(
                                    scrollDirection: Axis
                                        .horizontal, // Membuat scroll horizontal
                                    child: Row(
                                      children: detailMovie.productionCompanies
                                              ?.map((company) {
                                            return Container(
                                              margin: EdgeInsets.symmetric(
                                                  horizontal: 8),
                                              width: 100,
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  // Logo dengan box shape bulat putih
                                                  Container(
                                                    width:
                                                        75, // Ukuran lebar bulatan
                                                    height:
                                                        75, // Ukuran tinggi bulatan
                                                    decoration: BoxDecoration(
                                                      shape: BoxShape
                                                          .circle, // Bentuk bulat
                                                      color: Colors
                                                          .white, // Warna latar belakang putih
                                                    ),
                                                    child: company.logoPath !=
                                                            null
                                                        ? ClipOval(
                                                            child:
                                                                Image.network(
                                                              'https://image.tmdb.org/t/p/w500${company.logoPath!}',
                                                            ),
                                                          )
                                                        : Container(
                                                            width: 50,
                                                            height: 50,
                                                            child: Icon(
                                                              CupertinoIcons
                                                                  .video_camera_solid,
                                                              size: 50,
                                                              color:
                                                                  Colors.grey,
                                                            ),
                                                          ), // Placeholder jika logo tidak ada
                                                  ),
                                                  SizedBox(height: 8),
                                                  // Nama perusahaan produksi
                                                  Text(
                                                    company.name ?? "No Name",
                                                    textAlign: TextAlign.center,
                                                    style: GoogleFonts.poppins(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                    maxLines: 1,
                                                  ),
                                                ],
                                              ),
                                            );
                                          }).toList() ??
                                          [],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 16.0),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Same Like This',
                                      style: GoogleFonts.poppins(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                                BlocBuilder<RecommendationCubit,
                                    RecommendationState>(
                                  builder: (context, state) {
                                    if (state is RecommendationLoading) {
                                      return Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          CircularProgressIndicator(),
                                        ],
                                      );
                                    } else if (state is RecommendationLoaded) {
                                      final recommendations =
                                          state.recommendations;

                                      return Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 16.0),
                                        child: SingleChildScrollView(
                                          scrollDirection: Axis
                                              .horizontal, // Scroll horizontal untuk rekomendasi
                                          child: Row(
                                            children:
                                                recommendations.map((rec) {
                                              return Container(
                                                margin: EdgeInsets.symmetric(
                                                    horizontal: 8),
                                                width: 180,
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    GestureDetector(
                                                      onTap: () {
                                                        // Navigasi ke Detail Movie Screen dan mengirimkan ID film
                                                        Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                            builder: (context) =>
                                                                DetailMovieScreen(
                                                                    movieId: rec
                                                                        .id!
                                                                        .toInt()),
                                                          ),
                                                        );
                                                      },
                                                      child: Container(
                                                        width: 200,
                                                        height: 250,
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(8),
                                                        ),
                                                        child: rec.posterPath !=
                                                                null
                                                            ? ClipRRect(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            8),
                                                                child: Image
                                                                    .network(
                                                                  'https://image.tmdb.org/t/p/w500${rec.posterPath!}',
                                                                  fit: BoxFit
                                                                      .cover,
                                                                ),
                                                              )
                                                            : Container(
                                                                color:
                                                                    Colors.grey,
                                                                child: Icon(
                                                                    Icons.movie,
                                                                    color: Colors
                                                                        .white),
                                                              ),
                                                      ),
                                                    ),
                                                    SizedBox(height: 8),
                                                    Text(
                                                      rec.title ?? "No Title",
                                                      textAlign:
                                                          TextAlign.center,
                                                      style:
                                                          GoogleFonts.poppins(
                                                        color: Colors.white,
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                      maxLines: 1,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                  ],
                                                ),
                                              );
                                            }).toList(),
                                          ),
                                        ),
                                      );
                                    } else if (state is RecommendationError) {
                                      return Center(
                                          child: Text('Error: ${state.message}',
                                              style: GoogleFonts.poppins(
                                                  color: Colors.white)));
                                    } else {
                                      return Container();
                                    }
                                  },
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    );
                  } else if (state is DetailMovieError) {
                    return Center(
                        child: Text('Error: ${state.message}',
                            style: GoogleFonts.poppins(color: Colors.white)));
                  } else {
                    return Container();
                  }
                },
              ),
              // posisi builder credits
            ],
          ),
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
