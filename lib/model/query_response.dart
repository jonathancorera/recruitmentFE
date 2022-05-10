// class for storing, accessing, and converting data received from a request to query a list of users


import 'dart:convert';

import 'package:recruitmentclient/model/get_user_list_response.dart';

List<Content> queryResponseFromJson(String str) => List<Content>.from(json.decode(str).map((x) => Content.fromJson(x)));

String queryResponseToJson(List<Content> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));



