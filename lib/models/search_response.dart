// ignore_for_file: sort_constructors_first
class SearchResponse {
  SearchResponse({
    this.preference,
    this.pagination,
    this.data,
    this.info,
    this.config,
    this.query = '',
  });

  dynamic preference;
  Pagination? pagination;
  List<Data>? data;
  Info? info;
  Config? config;
  String query;

  SearchResponse.fromJson(Map<String, dynamic> json, this.query) {
    preference = json['preference'];
    pagination =
        json['pagination'] != null ? Pagination.fromJson(json['pagination']) : null;
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) => data!.add(Data.fromJson(v)));
    }
    info = json['info'] != null ? Info.fromJson(json['info']) : null;
    config = json['config'] != null ? Config.fromJson(json['config']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['preference'] = preference;
    if (pagination != null) {
      data['pagination'] = pagination!.toJson();
    }
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    if (info != null) {
      data['info'] = info!.toJson();
    }
    if (config != null) {
      data['config'] = config!.toJson();
    }
    return data;
  }
}

class Pagination {
  int? total;
  int? limit;
  int? offset;
  int? totalPages;
  int? currentPage;

  Pagination({this.total, this.limit, this.offset, this.totalPages, this.currentPage});

  Pagination.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    limit = json['limit'];
    offset = json['offset'];
    totalPages = json['total_pages'];
    currentPage = json['current_page'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['total'] = total;
    data['limit'] = limit;
    data['offset'] = offset;
    data['total_pages'] = totalPages;
    data['current_page'] = currentPage;
    return data;
  }
}

class Data {
  double? dScore;
  Thumbnail? thumbnail;
  int? id;
  String? imageId;
  String? title;
  String? artistDisplay;
  String? description;
  String? dateDisplay;

  Data({this.dScore, this.thumbnail, this.id, this.imageId, this.title});

  Data.fromJson(Map<String, dynamic> json) {
    dScore = json['_score'];
    thumbnail = json['thumbnail'] != null ? Thumbnail.fromJson(json['thumbnail']) : null;
    id = json['id'];
    imageId = json['image_id'];
    title = json['title'];
    artistDisplay = json['artist_display'];
    description = json['description'];
    dateDisplay = json['date_display'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_score'] = dScore;
    if (thumbnail != null) {
      data['thumbnail'] = thumbnail!.toJson();
    }
    data['id'] = id;
    data['image_id'] = imageId;
    data['title'] = title;
    data['artist_display'] = artistDisplay;
    data['description'] = description;
    data['date_display'] = dateDisplay;
    return data;
  }
}

class Thumbnail {
  String? altText;
  int? width;
  String? lqip;
  int? height;

  Thumbnail({this.altText, this.width, this.lqip, this.height});

  Thumbnail.fromJson(Map<String, dynamic> json) {
    altText = json['alt_text'];
    width = json['width'];
    lqip = json['lqip'];
    height = json['height'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['alt_text'] = altText;
    data['width'] = width;
    data['lqip'] = lqip;
    data['height'] = height;
    return data;
  }
}

class Info {
  String? licenseText;
  List<String>? licenseLinks;
  String? version;

  Info({this.licenseText, this.licenseLinks, this.version});

  Info.fromJson(Map<String, dynamic> json) {
    licenseText = json['license_text'];
    licenseLinks = json['license_links'].cast<String>();
    version = json['version'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['license_text'] = licenseText;
    data['license_links'] = licenseLinks;
    data['version'] = version;
    return data;
  }
}

class Config {
  String? iiifUrl;
  String? websiteUrl;

  Config({this.iiifUrl, this.websiteUrl});

  Config.fromJson(Map<String, dynamic> json) {
    iiifUrl = json['iiif_url'];
    websiteUrl = json['website_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['iiif_url'] = iiifUrl;
    data['website_url'] = websiteUrl;
    return data;
  }
}
