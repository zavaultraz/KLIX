import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:filmku/Cubit/movie_cubit.dart';
import 'package:filmku/Model/movie.dart';

class TopMoviesCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Memanggil fetchTopMovies saat widget ini dibangun
    Future.microtask(() {
      context.read<MovieCubit>().fetchPopularMovies();
    });

    return BlocBuilder<MovieCubit, MovieState>(
      builder: (context, state) {
        if (state is MovieInitial) {
          return Center(child: CircularProgressIndicator()); // Loading state
        } else if (state is MovieLoaded) {
          final movies = state.movies;
          return ListView.builder(
            shrinkWrap: true, // Membatasi tinggi ListView agar sesuai ukuran
            itemCount: movies.length ?? 0,
            itemBuilder: (context, index) {
              final movie = movies[index];
              return Center(
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 10,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      // Left side: Image with rank
                      ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Stack(
                          children: [
                            Image.network(
                              'https://image.tmdb.org/t/p/w500/${movie.image}',
                              width: 130,
                              height: 100,
                              fit: BoxFit.cover,
                            ),
                            // Rank (position) on top-right corner
                            Positioned(
                              top: 8,
                              right: 8,
                              child: Container(
                                padding: EdgeInsets.all(6),
                                decoration: BoxDecoration(
                                  color: Colors.blueAccent,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(
                                  '#${index + 1}',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 15),
                      // Right side: Movie title, rating, genre, release date
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(right: 10, top: 10, bottom: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Movie title
                              Text(
                                movie.title ?? 'No Title',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: Colors.black87,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              SizedBox(height: 5),
                              // Rating with Icon
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Icon(Icons.calendar_month_rounded,size: 15,color: Colors.grey,),
                                      SizedBox(width: 4,),
                                      Text(
                                        movie.release ?? 'No Release Date',
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.grey[600],
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(

                                    children: [
                                      Icon(
                                        Icons.star,
                                        color: Colors.yellow,
                                        size: 16,
                                      ),
                                      SizedBox(width: 5),
                                      Text(
                                        movie.rating?.toStringAsFixed(1) ?? '0.0',
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        } else if (state is MovieError) {
          return Center(child: Text('Error: ${state.message}')); // Error state
        } else {
          return Center(child: Text('No data available.'));
        }
      },
    );
  }
}
