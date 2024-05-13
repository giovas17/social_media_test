import 'dart:convert';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:social_media_test/domain/models/post_result.dart';
import '../../../domain/utils/results_utils.dart';

abstract class PostRepository {
  Future<Object> fetchPosts(int idProfile);
}

class PostRepositoryImpl extends PostRepository {
  @override
  Future<Object> fetchPosts(int idProfile) async {
    try {
      String data = await rootBundle.loadString('assets/posts_$idProfile.json');
      await Future.delayed(const Duration(seconds: 1)); // just mock the time for call
      final result = PostResult.fromJson(json.decode(data));
      return Success(code: 200, response: result);
    } on FormatException {
      return Failure(code: 101, errorResponse: "Invalid format");
    } on HttpException {
      return Failure(code: 102, errorResponse: "Error on Http call");
    } catch (e) {
      return Failure(code: 103, errorResponse: "Unknown error");
    }
  }

}