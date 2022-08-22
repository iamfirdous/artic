import 'dart:convert';

import 'package:artic/models/artwork_response.dart';
import 'package:artic/models/search_response.dart';
import 'package:http/http.dart' as http;

class ArtworkRepository {
  static ArtworkRepository? _instance;
  static ArtworkRepository get instance {
    _instance = _instance ?? ArtworkRepository();
    return _instance!;
  }

  static const String API_URL = 'https://api.artic.edu/api/v1/artworks';
  static const String ENDPOINT_SEARCH = 'search';
  static const String PARAM_Q = 'q';
  static const String PARAM_FROM = 'from';
  static const String PARAM_SEARCH_FIELDS = 'fields=id,title,image_id,thumbnail,artist_display,description,date_display';
  static const String PARAM_ARTWORK_FIELDS = 'fields=publication_history,exhibition_history,provenance_text';

  Future<SearchResponse> search(String query, int from) async {
    try {
      final uri = Uri.parse('$API_URL/$ENDPOINT_SEARCH?$PARAM_Q=$query&$PARAM_FROM=$from&$PARAM_SEARCH_FIELDS');
      final response = await http.get(uri);
      if (response.statusCode == 200) {
        return SearchResponse.fromJson(jsonDecode(response.body), query);
      } else {
        throw Exception(getErrorMessage(response.statusCode));
      }
    } catch (e) {
      print('error on search' + e.toString());
      rethrow;
    }
  }

  Future<ArtworkResponse> getArtwork(int id) async {
    try {
      final uri = Uri.parse('$API_URL/$id');
      final response = await http.get(uri);
      if (response.statusCode == 200) {
        return ArtworkResponse.fromJson(jsonDecode(response.body));
      } else {
        throw Exception(getErrorMessage(response.statusCode));
      }
    } catch (e) {
      print('error on getArtwork' + e.toString());
      rethrow;
    }
  }

  String getErrorMessage(int statusCode) {
    if (statusCode.toString().startsWith('4')) {
      return 'Something wrong with the request';
    }
    if (statusCode.toString().startsWith('5')) {
      return 'Something wrong on the server';
    }
    return 'Unknown error';
  }
}
