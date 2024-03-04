import '../data.dart';
import 'package:flutter/material.dart';

class PageList extends StatelessWidget {
  final List<PageURL> pages;
  final ValueChanged<PageURL>? onTap;

  const PageList({
    required this.pages,
    this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) => ListView.builder(
        itemCount: pages.length,
        itemBuilder: (context, index) => ListTile(
          leading: pages[index].icon,
          title: Text(
            pages[index].title,
          ),
          // trailing: const Spacer(),
          onTap: onTap != null ? () => onTap!(pages[index]) : null,
        ),
      );
}
