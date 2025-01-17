import 'package:filmku/Cubit/nowmovie_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:carousel_slider/carousel_slider.dart';

import 'package:filmku/Model/movie.dart'; // Import Movie model

class NowPlayingCarousel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Memicu pengambilan data 'Now Playing' saat widget pertama kali dipanggil
    Future.microtask(() {
      context.read<NowmovieCubit>().fetchNowMovies();
    });

    return BlocBuilder<NowmovieCubit, NowmovieState>(
      builder: (context, state) {
        if (state is NowmovieInitial) {
          return Center(child: CircularProgressIndicator());
        } else if (state is NowmovieLoaded) {
          final movies = state.movies;

          return CarouselSlider(
            options: CarouselOptions(
              height: 300, // Menyesuaikan tinggi carousel
              enlargeCenterPage: true,
              autoPlay: true,
              aspectRatio: 16 / 9,
              viewportFraction: 1.0, // Lebar penuh
              enableInfiniteScroll: true,
            ),
            items: movies.map((movie) {
              return Builder(
                builder: (BuildContext context) {
                  return Container(
                    width: MediaQuery.of(context).size.width, // Lebar penuh layar
                    child: Stack(
                      fit: StackFit.expand, // Menjaga agar gambar memenuhi container
                      children: [
                        // Gambar sebagai latar belakang
                        ClipRRect(
                          borderRadius: BorderRadius.only(bottomRight: Radius.circular(20),bottomLeft: Radius.circular(20)),
                          child: Image.network(
                            'https://image.tmdb.org/t/p/w500/${movie.image}',
                            fit: BoxFit.cover, // Gambar menutupi seluruh container
                          ),

                        ),
                        // Teks judul dan deskripsi di atas gambar
                        Positioned(
                          bottom: 20,
                          left: 10,
                          right: 10,
                          child: Container(
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.5), // Transparansi
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Teks Judul
                                Text(
                                  movie.title ?? 'No Title',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                    color: Colors.white,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                SizedBox(height: 4),
                                // Deskripsi film (Overview)
                                Text(
                                  movie.overview ?? 'No Description',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.white,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            }).toList(),
          );
        } else if (state is NowmovieError) {
          return Center(child: Text('Error: ${state.message}'));
        } else {
          return Center(child: Text('No data available.'));
        }
      },
    );
  }
}
