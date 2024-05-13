import 'dart:convert';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:social_media_test/domain/utils/results_utils.dart';
import '../../../domain/models/profile.dart';


abstract class ProfileRepository {
  Future<Object> fetchProfile();
}

class ProfileRepositoryImpl extends ProfileRepository {
  @override
  Future<Object> fetchProfile() async {
    try {
      String data = await rootBundle.loadString('assets/profile.json');
      await Future.delayed(const Duration(seconds: 1)); // just mock the time for call
      final result = Profile.fromJson(json.decode(data));
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