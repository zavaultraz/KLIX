import 'package:filmku/Cubit/creditmovie_cubit.dart';
import 'package:filmku/Cubit/detailmovie_cubit.dart';
import 'package:filmku/Cubit/image_movie_cubit.dart';
import 'package:filmku/Cubit/nowmovie_cubit.dart';
import 'package:filmku/Cubit/recommendation_cubit.dart';
import 'package:filmku/Cubit/review_cubit.dart';
import 'package:filmku/Cubit/soonmovie_cubit.dart';
import 'package:filmku/Cubit/topmovie_cubit.dart';
import 'package:filmku/Cubit/video_cubit.dart';
import 'package:filmku/Service/credits_service.dart';
import 'package:filmku/Service/details_service.dart';
import 'package:filmku/Service/imageMovie_service.dart';
import 'package:filmku/Service/recomendation_service.dart';
import 'package:filmku/Service/review_service.dart';
import 'package:filmku/Service/service.dart';
import 'package:filmku/Cubit/movie_cubit.dart';
import 'package:filmku/Service/videos_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'homescreen.dart';
import 'detailsScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => MovieCubit(MovieService()),
        ),
        BlocProvider(
          create: (context) => NowmovieCubit(MovieService()),
        ),
        BlocProvider(
          create: (context) => TopmovieCubit(MovieService()),
        ),
        BlocProvider(
          create: (context) => SoonmovieCubit(MovieService()),
        ),
        BlocProvider(
          create: (context) => DetailMovieCubit(DetailsService()),
        ),
        BlocProvider(
          create: (context) => CreditsCubit(CreditsService()),
        ),
        BlocProvider(
          create: (context) => RecommendationCubit(RecommendationService()),
        ),
        BlocProvider(
          create: (context) => ImageMovieCubit(ImageMovieService()),
        ),
        BlocProvider(
          create: (context) => ReviewCubit(ReviewService()),
        ),
        BlocProvider(
          create: (context) => VideoCubit(VideoService()),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Homescreen(),
      ),
    );
  }
}
