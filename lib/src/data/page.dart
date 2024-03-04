import 'package:flutter/material.dart';

class PageURL {
  final int id;
  final Category category;
  final String title;
  final Icon icon;
  final String url;

  PageURL(this.id, this.category, this.title, this.icon, this.url);
}

enum Category {
  main,
  raporlar,
  sistemYonetimi,
  tanimlamalar,
}
