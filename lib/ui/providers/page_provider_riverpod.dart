import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:star_wars_app/ui/pages/media_selection_page.dart';

final currentPage = StateProvider<Widget>((ref) {
  return const MediaSelectionPage();
});

final webViewIsActive = StateProvider<bool>((ref) {
  return false;
});

final contentList = StateProvider<List>((ref) {
  return [];
});

class PageProvider {}
