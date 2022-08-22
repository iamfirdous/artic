import 'package:flutter/material.dart';

class Fonts {
  static const String Inter = 'Inter';
}

class Texts {
  static const String app_name = 'Art Institute of Chicago';
  static const String search_artworks = 'Search artworks';
  static const String search_artworks_message =
      'Start typing to find the artworks you’re looking for.';
  static const String no_results =
      'No reults found for the query, please try to use different keywords';
  static const String load_more = 'Load more';
  static const String year = 'Year';
  static const String description = 'Description';
  static const String publication_history = 'Publication history';
  static const String exhibition_history = 'Exhibition history';
  static const String provenance = 'Provenance';
}

class Images {
  static const String path = 'assets/images/';
  static const String png = '.png';
  static const String logo = '${path}logo$png';
  static const String add = '${path}add$png';
  static const String arrow_left = '${path}arrow_left$png';
  static const String canvas = '${path}canvas$png';
  static const String remove = '${path}remove$png';
  static const String search = '${path}search$png';
  static const String placeholder = '${path}placeholder$png';
}

class AppColors {
  static const Color primary = Color(0xFFFEFEFD);
  static const Color secondary = Color(0xFF232323);
  static const Color grey1 = Color(0xFF939393);
  static const Color grey2 = Color(0xFFE6E6E6);
}

String buildImageUrl(String id, [String width = '843,']) {
  return 'https://www.artic.edu/iiif/2/$id/full/$width/0/default.jpg';
}
