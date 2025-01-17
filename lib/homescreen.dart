import 'package:filmku/Cubit/soonmovie_cubit.dart';
import 'package:filmku/Cubit/topmovie_cubit.dart';
import 'package:filmku/Model/movie.dart';
import 'package:filmku/component/cardPopular.dart';
import 'package:filmku/component/nowPlaying.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:filmku/Cubit/movie_cubit.dart'; // Import MovieCubit

class Homescreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Trigger fetchPopularMovies when the screen loads
    Future.microtask(() {
      context.read<MovieCubit>().fetchPopularMovies();
      context.read<TopmovieCubit>().fetchTopMovies();
      context.read<SoonmovieCubit>().fetchSoonMovies();
    });

    return Scaffold(
      appBar: AppBar(
        title: Text('Filmku'),
        leading: Icon(Icons.menu),
        centerTitle: true,
        actions: [
          Icon(Icons.search_rounded),
          SizedBox(width: 10),
          Icon(Icons.notifications),
          SizedBox(width: 10)
        ],
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            NowPlayingCarousel(),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Popular Movies',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ],
              ),
            ),
            BlocBuilder<MovieCubit, MovieState>(
              builder: (context, state) {
                if (state is MovieInitial) {
                  return Center(child: CircularProgressIndicator());
                } else if (state is MovieLoaded) {
                  final movies = state.movies; // List<Movie> here

                  return SingleChildScrollView(
                    scrollDirection: Axis.horizontal, // Horizontal scroll
                    child: Row(
                      children: List.generate(
                        movies.length, // Now using List<Movie>
                        (index) {
                          final movie = movies[index];

                          return Container(
                            width: 180,
                            height: 250,
                            margin: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 8),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.2),
                                  blurRadius: 15,
                                  offset: Offset(0, 2), // Shadow position
                                ),
                              ],
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(
                                  16), // Rounded corners for the whole container
                              child: Stack(
                                children: [
                                  // Image with shadow effect
                                  Positioned.fill(
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(16),
                                      child: Image.network(
                                        'https://image.tmdb.org/t/p/w500/${movie.poster}', // Full image URL
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  // Gradient overlay for readability
                                  Positioned.fill(
                                    child: Container(
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                          begin: Alignment.topCenter,
                                          end: Alignment.bottomCenter,
                                          colors: [
                                            Colors.transparent,
                                            Colors.black.withOpacity(
                                                0.5), // Dark overlay for text contrast
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  // Title and movie info overlay
                                  Positioned(
                                    bottom: 20,
                                    left: 10,
                                    right: 10,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        // Movie Title
                                        Text(
                                          movie.title ?? 'No Title',
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                            color: Colors.white,
                                          ),
                                        ),
                                        SizedBox(height: 5),
                                        // Movie Description (shortened if needed)
                                        Text(
                                          movie.overview ??
                                              'No Description Available',
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                            color:
                                                Colors.white.withOpacity(0.8),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  );
                } else if (state is MovieError) {
                  return Center(child: Text('Error: ${state.message}'));
                } else {
                  return Center(child: Text('No data available.'));
                }
              },
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Coming Soon',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ],
              ),
            ),
            BlocBuilder<SoonmovieCubit, SoonmovieState>(
              builder: (context, state) {
                if (state is SoonmovieInitial) {
                  return Center(child: CircularProgressIndicator());
                } else if (state is SoonmovieLoaded) {
                  final movies = state.movies; // List<Movie> here



                        return SingleChildScrollView(
                          scrollDirection: Axis.horizontal, // Horizontal scroll
                          child: Row(
                            children: List.generate(
                              movies.length ?? 0, // Menampilkan daftar film
                                  (index) {
                                final movie = movies[index];

                                return Container(
                                  margin: EdgeInsets.symmetric(horizontal: 8), // Jarak antar elemen
                                  width: 160, // Lebar kontainer per item
                                  height: 300, // Tinggi kontainer
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12), // Sudut melengkung
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.center, // Memusatkan konten
                                    children: [
                                      // Gambar film
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(12), // Sudut melengkung pada gambar
                                        child: Image.network(
                                          'https://image.tmdb.org/t/p/w500/${movie.poster}', // URL gambar film
                                          width: 160,  // Lebar gambar
                                          height: 220, // Tinggi gambar
                                          fit: BoxFit.cover, // Agar gambar memenuhi kontainer
                                        ),
                                      ),
                                      SizedBox(height: 8), // Jarak antara gambar dan judul
                                      // Judul film
                                      Text(
                                        movie.title ?? 'No Title', // Menampilkan judul film
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18, // Ukuran font
                                          color: Colors.black, // Warna teks
                                        ),
                                        textAlign: TextAlign.center, // Memusatkan teks
                                        overflow: TextOverflow.ellipsis, // Jika terlalu panjang, dipotong
                                        maxLines: 2, // Maksimal dua baris
                                      ),
                                    ],
                                  ),
                                );

                                  },
                            ),
                          ),
                        );



                } else if (state is SoonmovieError) {
                  return Center(child: Text('Error: ${state.message}'));
                } else {
                  return Center(child: Text('No data available.'));
                }
              },
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Top Movies',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            BlocBuilder<TopmovieCubit, TopmovieState>(
              builder: (context, state) {
                if (state is TopmovieInitial) {
                  return Center(
                      child: CircularProgressIndicator()); // Loading state
                } else if (state is TopmovieLoaded) {
                  final movies = state.movies;
                  return Column(
                    children: [
                      // Daftar film terbatas (5 item pertama)
                      _buildLeaderboardItem(1, movies[0]),
                      _buildLeaderboardItem(2, movies[1]),
                      _buildLeaderboardItem(3, movies[2]),
                    ],
                  );

                } else if (state is TopmovieError) {
                  return Center(
                      child: Text('Error: ${state.message}')); // Error state
                } else {
                  return Center(child: Text('No data available.'));
                }
              },
            ),
          ],
        ),
      ),
    );

  }
  Widget _buildLeaderboardItem(int rank, Movie movie) {
    return Center(
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30), // Membuat bentuk kapsul
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12), // Padding lebih kecil
          child: Row(
            children: [
              // Left side: Image with rank
              ClipRRect(
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(20),
                  topRight: Radius.circular(20),
                ), // Bentuk kapsul
                child: Image.network(
                  'https://image.tmdb.org/t/p/w500/${movie.image}',
                  width: 150,  // Ukuran gambar
                  height: 100, // Ukuran gambar
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(width: 12),
              // Right side: Movie title, rating, genre, release date
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Peringkat dan judul film di baris yang sama
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Column untuk judul dan rating
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Movie title, bisa dua baris
                              Text(
                                movie.title ?? 'No Title',
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 18,
                                  color: Colors.black87,
                                ),
                                maxLines: 2, // Maksimal dua baris untuk judul
                                overflow: TextOverflow.ellipsis, // Jika panjang, akan dipotong
                              ),
                              SizedBox(height: 4),
                              // Rating
                              Row(
                                children: [
                                  Icon(
                                    Icons.star,
                                    color: Colors.yellow,
                                    size: 16,
                                  ),
                                  SizedBox(width: 4),
                                  Text(
                                    movie.rating?.toStringAsFixed(1) ?? '0.0',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black87,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        // Rank di sebelah kanan
                        Text(
                          '$rank', // Menampilkan peringkat
                          style: TextStyle(
                            fontSize: 30, // Ukuran font untuk peringkat
                            fontWeight: FontWeight.bold,
                            color: Colors.grey,
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
      ),
    );
  }


}
