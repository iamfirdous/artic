import 'dart:async';

import 'package:artic/util/constants.dart';
import 'package:flutter/material.dart';

class SearchInput extends StatefulWidget {
  const SearchInput({Key? key, required this.onChanged}) : super(key: key);

  final void Function(String) onChanged;

  @override
  State<SearchInput> createState() => _SearchInputState();
}

class _SearchInputState extends State<SearchInput> {
  Timer? debounce;
  String query = '';

  @override
  void dispose() {
    debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const borderSide = BorderSide(color: AppColors.grey1, width: 2.0);
    const border = OutlineInputBorder(borderSide: borderSide);
    final focused = border.copyWith(
      borderSide: borderSide.copyWith(color: AppColors.primary),
    );

    return TextField(
      onChanged: (value) {
        if (debounce?.isActive ?? false) debounce?.cancel();
        debounce = Timer(
          const Duration(milliseconds: 600),
          () {
            if (value != query) {
              widget.onChanged(value);
            }
            query = value;
          },
        );
      },
      maxLines: 1,
      style: Theme.of(context).textTheme.subtitle1,
      cursorColor: AppColors.primary,
      decoration: InputDecoration(
        isDense: true,
        prefixIcon: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14.0),
          child: Image.asset(Images.search, width: 24.0),
        ),
        prefixIconConstraints: const BoxConstraints(minWidth: 0.0, minHeight: 0.0),
        hintText: Texts.search_artworks,
        hintStyle: Theme.of(context).textTheme.subtitle2,
        border: border,
        enabledBorder: border,
        focusedBorder: focused,
      ),
    );
  }
}
