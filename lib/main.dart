import 'package:filmku/Cubit/nowmovie_cubit.dart';
import 'package:filmku/Cubit/soonmovie_cubit.dart';
import 'package:filmku/Cubit/topmovie_cubit.dart';
import 'package:filmku/Service/service.dart';
import 'package:filmku/Cubit/movie_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'homescreen.dart';

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
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Homescreen(),
      ),
    );
  }
}
