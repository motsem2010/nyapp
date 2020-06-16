import 'dart:core';

import 'package:flutter/material.dart';

class Article {
  int id, asset_id;
  String uri,
      url,
      source, //used
      published_date,
      updated,
      section,
      subsection,
      nytdsection,
      adx_keywords,
      column,
      byline, //used
      type,
      title, //used
      abstract;
  List<String> des_facet; //used
  List<String> org_facet;
  List<String> per_facet;
  List<String> geo_facet;

  Article({this.id,
    this.asset_id,
    this.uri,
    this.url,
    this.source,
    this.published_date,
    this.updated,
    this.section,
    this.subsection,
    this.nytdsection,
    this.adx_keywords,
    this.column,
    this.byline,
    this.type,
    this.title,
    this.abstract,
    this.des_facet,
    this.org_facet,
    this.per_facet,
    this.geo_facet}
      );

  @override
  String toString() {
    return 'Article{id: $id, asset_id: $asset_id, uri: $uri, url: $url, source: $source, published_date: $published_date, updated: $updated, section: $section, subsection: $subsection, nytdsection: $nytdsection, adx_keywords: $adx_keywords, column: $column, byline: $byline, type: $type, title: $title, abstract: $abstract, des_facet: $des_facet, org_facet: $org_facet, per_facet: $per_facet, geo_facet: $geo_facet}';
  }

//  media [],
//  eta_id 0

  factory Article.fromJson(Map<String, dynamic> json) {

    return Article(
      id: json['id'] as int,asset_id:json['asset_id'] as int,
      uri: json['uri'] as String,url:json['url'] as String,
    source: json['source'] as String,
    published_date: json['published_date'] as String,
    updated: json['updated'] as String,
    section: json['section'] as String,
    subsection: json['subsection'] as String,
    nytdsection: json['nytdsection'] as String,
    adx_keywords: json['adx_keywords'] as String,
    column: json['column'] as String,
    byline: json['byline'] as String,
    type: json['type'] as String,
    title: json['title'] as String,
    abstract: json['abstract'] as String,
      des_facet:parseArry(json['des_facet']), //used
     org_facet:parseArry(json['org_facet']),
     per_facet:parseArry(json['per_facet']),
    geo_facet:parseArry(json['geo_facet'])
    );
  }

  static List<String> parseArry(placesJson) {
    List<String> placesList = new List<String>.from(placesJson);
    return placesList;
  }
}
