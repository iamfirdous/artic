import 'dart:convert';

import 'package:artic/models/search_response.dart';
import 'package:artic/ui/widgets/app_title_bar.dart';
import 'package:artic/util/constants.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class ImageViewPage extends StatelessWidget {
  const ImageViewPage(this.searchData, {Key? key}) : super(key: key);

  static Route route({required Data searchData}) {
    return MaterialPageRoute(builder: (_) => ImageViewPage(searchData));
  }

  final Data searchData;

  @override
  Widget build(BuildContext context) {
    final lqip = searchData.thumbnail?.lqip;
    final placeholder = (lqip == null
        ? const AssetImage(Images.placeholder)
        : MemoryImage(base64Decode(lqip.split(',').last))) as ImageProvider;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            AppTitleBar(title: searchData.title ?? ''),
            Expanded(
              child: PhotoView(
                backgroundDecoration: const BoxDecoration(color: AppColors.secondary),
                enablePanAlways: true,
                enableRotation: true,
                loadingBuilder: (_, e) => Image(fit: BoxFit.fitWidth, image: placeholder),
                imageProvider: NetworkImage(buildImageUrl(searchData.imageId!, 'full')),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
