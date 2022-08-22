import 'dart:convert';

import 'package:artic/blocs/artwork/artwork_bloc.dart';
import 'package:artic/models/search_response.dart';
import 'package:artic/ui/pages/image_view_page.dart';
import 'package:artic/ui/widgets/app_title_bar.dart';
import 'package:artic/util/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:html/parser.dart';

class ArtworkPage extends StatelessWidget {
  const ArtworkPage(this.searchData, {Key? key}) : super(key: key);

  static Route route({required Data searchData}) {
    return MaterialPageRoute(builder: (_) => ArtworkPage(searchData));
  }

  final Data searchData;

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<ArtworkBloc>(context)..add(GetArtwork(searchData.id!));
    final lqip = searchData.thumbnail?.lqip;
    final placeholder = (lqip == null
        ? const AssetImage(Images.placeholder)
        : MemoryImage(base64Decode(lqip.split(',').last))) as ImageProvider;
    final placeholderImage = Image(
      width: double.infinity,
      height: placeholder is AssetImage ? MediaQuery.of(context).size.width : null,
      fit: BoxFit.contain,
      image: placeholder,
    );
    return BlocProvider.value(
      value: bloc,
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              AppTitleBar(title: searchData.title ?? ''),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.only(bottom: 24.0),
                  child: BlocBuilder<ArtworkBloc, ArtworkState>(
                    builder: (context, state) {
                      if (state is ArtworkLoaded) {
                        return Column(
                          children: [
                            ImageHolder(
                              child: searchData.imageId != null
                                  ? InkWell(
                                      onTap: () => Navigator.push(
                                        context,
                                        ImageViewPage.route(searchData: searchData),
                                      ),
                                      child: FadeInImage(
                                        width: double.infinity,
                                        fit: BoxFit.contain,
                                        placeholderFit: BoxFit.contain,
                                        image: NetworkImage(
                                            buildImageUrl(searchData.imageId!)),
                                        placeholder: placeholder,
                                      ),
                                    )
                                  : placeholderImage,
                            ),
                            Container(
                              constraints: const BoxConstraints(maxWidth: 900.0),
                              child: Column(
                                children: [
                                  ArtistDescription(searchData),
                                  if (state.artwork.publicationHistory != null) ...[
                                    ExpansionPoints(
                                      Texts.publication_history,
                                      state.artwork.publicationHistory!,
                                    ),
                                  ],
                                  if (state.artwork.exhibitionHistory != null) ...[
                                    ExpansionPoints(
                                      Texts.exhibition_history,
                                      state.artwork.exhibitionHistory!,
                                    ),
                                  ],
                                  if (state.artwork.provenanceText != null) ...[
                                    ExpansionPoints(
                                      Texts.provenance,
                                      state.artwork.provenanceText!,
                                    ),
                                  ],
                                ],
                              ),
                            ),
                          ],
                        );
                      }
                      return Column(
                        children: [
                          ImageHolder(child: placeholderImage),
                          Container(
                            constraints: const BoxConstraints(maxWidth: 900.0),
                            child: ArtistDescription(searchData),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ImageHolder extends StatelessWidget {
  const ImageHolder({Key? key, required this.child}) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: AppColors.secondary,
      alignment: Alignment.center,
      child: Container(
        constraints: const BoxConstraints(maxWidth: 500.0, maxHeight: 500.0),
        child: child,
      ),
    );
  }
}

class ArtistDescription extends StatelessWidget {
  const ArtistDescription(this.searchData, {Key? key}) : super(key: key);

  final Data searchData;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 24.0),
          if (searchData.dateDisplay != null) ...[
            SelectableText(
              searchData.dateDisplay!,
              style: Theme.of(context).textTheme.bodyText2,
            ),
            const SizedBox(height: 24.0),
          ],
          if (searchData.artistDisplay != null) ...[
            SelectableText(
              searchData.artistDisplay!,
              style: Theme.of(context).textTheme.bodyText2,
            ),
            const SizedBox(height: 24.0),
          ],
          if (searchData.description != null) ...[
            Text(
              Texts.description.toUpperCase(),
              style: Theme.of(context).textTheme.bodyText2,
            ),
            const SizedBox(height: 4.0),
            SelectableText(
              parse(searchData.description!).documentElement?.text ?? '',
              textAlign: TextAlign.justify,
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ],
        ],
      ),
    );
  }
}

class ExpansionPoints extends StatelessWidget {
  const ExpansionPoints(this.title, this.points, {Key? key}) : super(key: key);

  final String title;
  final String points;

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      childrenPadding: const EdgeInsets.all(24.0),
      tilePadding: const EdgeInsets.symmetric(horizontal: 24.0),
      title: Text(
        title.toUpperCase(),
        style: Theme.of(context).textTheme.bodyText2,
      ),
      children: [
        for (String point in points.split('\n\n')) ...[
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('•', style: Theme.of(context).textTheme.bodyText1),
                const SizedBox(width: 8.0),
                Expanded(
                  child: SelectableText(
                    point,
                    textAlign: TextAlign.justify,
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ),
              ],
            ),
          ),
        ],
      ],
    );
  }
}
