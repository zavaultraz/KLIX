import 'package:filmku/Cubit/soonmovie_cubit.dart';
import 'package:filmku/Cubit/topmovie_cubit.dart';
import 'package:filmku/Model/movie.dart';
import 'package:filmku/component/cardPopular.dart';
import 'package:filmku/component/nowPlaying.dart';
import 'package:filmku/detailsScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:filmku/Cubit/movie_cubit.dart';
import 'package:google_fonts/google_fonts.dart'; // Import MovieCubit

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
      backgroundColor: Color(0xFF221F1E), // Background gelap untuk keselarasan dengan detail screen
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            // NowPlayingCarousel widget untuk film yang sedang diputar
            NowPlayingCarousel(),
            SizedBox(height: 10),

            // Popular Movies Section
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Popular Movies',
                    style: GoogleFonts.lexendDeca(fontWeight: FontWeight.bold, fontSize: 24, color: Colors.white),
                  ),
                ],
              ),
            ),
            BlocBuilder<MovieCubit, MovieState>(builder: (context, state) {
              if (state is MovieInitial) {
                return Center(child: CircularProgressIndicator());
              } else if (state is MovieLoaded) {
                final movies = state.movies;

                return SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: List.generate(movies.length, (index) {
                      final movie = movies[index];

                      return Container(
                        width: 180,
                        height: 250,
                        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              blurRadius: 15,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DetailMovieScreen(movieId: movie.id!.toInt()),
                              ),
                            );
                          },
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: Stack(
                              children: [
                                Positioned.fill(
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(16),
                                    child: Image.network(
                                      'https://image.tmdb.org/t/p/w500/${movie.poster}',
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Positioned.fill(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                        colors: [
                                          Colors.transparent,
                                          Colors.black.withOpacity(0.5),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  bottom: 20,
                                  left: 10,
                                  right: 10,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
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
                                      Text(
                                        movie.overview ?? 'No Description Available',
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.white.withOpacity(0.8),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                );
              } else if (state is MovieError) {
                return Center(child: Text('Error: ${state.message}', style: TextStyle(color: Colors.white)));
              } else {
                return Center(child: Text('No data available.', style: TextStyle(color: Colors.white)));
              }
            }),

            // Coming Soon Section
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Coming Soon',
                    style: GoogleFonts.lexendDeca(fontWeight: FontWeight.bold, fontSize: 24, color: Colors.white),
                  ),
                ],
              ),
            ),
            BlocBuilder<SoonmovieCubit, SoonmovieState>(builder: (context, state) {
              if (state is SoonmovieInitial) {
                return Center(child: CircularProgressIndicator());
              } else if (state is SoonmovieLoaded) {
                final movies = state.movies;

                return SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: List.generate(movies.length ?? 0, (index) {
                      final movie = movies[index];

                      return Container(
                        margin: EdgeInsets.symmetric(horizontal: 8),
                        width: 160,
                        height: 300,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DetailMovieScreen(movieId: movie.id!.toInt()),
                              ),
                            );
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Image.network(
                                  'https://image.tmdb.org/t/p/w500/${movie.poster}',
                                  width: 160,
                                  height: 220,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              SizedBox(height: 8),
                              Text(
                                movie.title ?? 'No Title',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  color: Colors.white,
                                ),
                                textAlign: TextAlign.center,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
                  ),
                );
              } else if (state is SoonmovieError) {
                return Center(child: Text('Error: ${state.message}', style: TextStyle(color: Colors.white)));
              } else {
                return Center(child: Text('No data available.', style: TextStyle(color: Colors.white)));
              }
            }),

            // Top Movies Section
            SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Top Movies',
                        style: GoogleFonts.lexendDeca(fontWeight: FontWeight.bold, fontSize: 24, color: Colors.white),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 15),
            BlocBuilder<TopmovieCubit, TopmovieState>(builder: (context, state) {
              if (state is TopmovieInitial) {
                return Center(child: CircularProgressIndicator());
              } else if (state is TopmovieLoaded) {
                final movies = state.movies;

                return SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: List.generate(movies.length, (index) {
                      final movie = movies[index];

                      return Container(
                        margin: EdgeInsets.symmetric(horizontal: 8),
                        width: 380,
                        height: 210,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DetailMovieScreen(movieId: movie.id!.toInt()),
                              ),
                            );
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Row(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(12),
                                    child: Image.network(
                                      'https://image.tmdb.org/t/p/w500/${movie.image}',
                                      width: 260,
                                      height: 150,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  Text(
                                    '${index + 1}',
                                    style: GoogleFonts.orbitron(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 60,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 8),
                              Text(
                                movie.title ?? 'No Title',
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  color: Colors.white,
                                ),
                                textAlign: TextAlign.center,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
                  ),
                );
              } else if (state is TopmovieError) {
                return Center(child: Text('Error: ${state.message}', style: TextStyle(color: Colors.white)));
              } else {
                return Center(child: Text('No data available.', style: TextStyle(color: Colors.white)));
              }
            }),

            SizedBox(height: 30),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Color(0xFFF2C94C),
        unselectedItemColor: Colors.white70,
        backgroundColor: Color(0xFF221F1E),
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home, size: 40),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.movie, size: 40),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle, size: 40),
            label: '',
          ),
        ],
      ),
    );
  }
}
