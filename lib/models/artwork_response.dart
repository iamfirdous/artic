// ignore_for_file: sort_constructors_first
class ArtworkResponse {
  ArtworkResponse({this.artwork, this.info, this.config});

  Artwork? artwork;
  Info? info;
  Config? config;

  ArtworkResponse.fromJson(Map<String, dynamic> json) {
    artwork = json['data'] != null ? Artwork.fromJson(json['data']) : null;
    info = json['info'] != null ? Info.fromJson(json['info']) : null;
    config = json['config'] != null ? Config.fromJson(json['config']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (artwork != null) {
      data['data'] = artwork!.toJson();
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

class Artwork {
  String? publicationHistory;
  String? exhibitionHistory;
  String? provenanceText;

  Artwork({this.publicationHistory, this.exhibitionHistory, this.provenanceText});

  Artwork.fromJson(Map<String, dynamic> json) {
    publicationHistory = json['publication_history'];
    exhibitionHistory = json['exhibition_history'];
    provenanceText = json['provenance_text'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['publication_history'] = publicationHistory;
    data['exhibition_history'] = exhibitionHistory;
    data['provenance_text'] = provenanceText;
    return data;
  }
}

class Thumbnail {
  String? lqip;
  int? width;
  int? height;
  String? altText;

  Thumbnail({this.lqip, this.width, this.height, this.altText});

  Thumbnail.fromJson(Map<String, dynamic> json) {
    lqip = json['lqip'];
    width = json['width'];
    height = json['height'];
    altText = json['alt_text'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['lqip'] = lqip;
    data['width'] = width;
    data['height'] = height;
    data['alt_text'] = altText;
    return data;
  }
}

class Color {
  int? h;
  int? l;
  int? s;
  double? percentage;
  int? population;

  Color({this.h, this.l, this.s, this.percentage, this.population});

  Color.fromJson(Map<String, dynamic> json) {
    h = json['h'];
    l = json['l'];
    s = json['s'];
    percentage = json['percentage'];
    population = json['population'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['h'] = h;
    data['l'] = l;
    data['s'] = s;
    data['percentage'] = percentage;
    data['population'] = population;
    return data;
  }
}

class SuggestAutocompleteAll {
  List<String>? input;
  Contexts? contexts;
  int? weight;

  SuggestAutocompleteAll({this.input, this.contexts, this.weight});

  SuggestAutocompleteAll.fromJson(Map<String, dynamic> json) {
    input = json['input'].cast<String>();
    contexts = json['contexts'] != null ? Contexts.fromJson(json['contexts']) : null;
    weight = json['weight'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['input'] = input;
    if (contexts != null) {
      data['contexts'] = contexts!.toJson();
    }
    data['weight'] = weight;
    return data;
  }
}

class Contexts {
  List<String>? groupings;

  Contexts({this.groupings});

  Contexts.fromJson(Map<String, dynamic> json) {
    groupings = json['groupings'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['groupings'] = groupings;
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
