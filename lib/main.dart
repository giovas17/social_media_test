import 'package:flutter/material.dart';
import 'package:social_media_test/screens/post_detail/presentation/post_detail_screen.dart';
import 'package:social_media_test/screens/posts/presentation/post_screen.dart';
import 'package:social_media_test/screens/profile/presentation/profile_screen.dart';
import 'screens/friends/presentation/friends_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const ProfileScreen(),
        '/friends': (context) => const FriendsScreen(),
        '/posts': (context) => const PostScreen(),
        '/post_detail': (context) => const PostDetailScreen(),
      },
    );
  }
}