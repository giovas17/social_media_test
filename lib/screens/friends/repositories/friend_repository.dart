import 'dart:convert';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:social_media_test/domain/models/friend.dart';
import '../../../domain/utils/results_utils.dart';

abstract class FriendsRepository {
  Future<Object> fetchFriends(int idProfile);
}

class FriendsRepositoryImpl extends FriendsRepository {
  @override
  Future<Object> fetchFriends(int idProfile) async {
    try {
      String data = await rootBundle.loadString('assets/friends_$idProfile.json');
      await Future.delayed(const Duration(seconds: 1)); // just mock the time for call
      final listFriends = List<Friend>.empty(growable: true);
      final List<dynamic> list = json.decode(data);
      for (var element in list) { listFriends.add(Friend.fromJson(element)); }
      return Success(code: 200, response: listFriends);
    } on FormatException {
      return Failure(code: 101, errorResponse: "Invalid format");
    } on HttpException {
      return Failure(code: 102, errorResponse: "Error on Http call");
    } catch (e) {
      return Failure(code: 103, errorResponse: "Unknown error");
    }
  }

}