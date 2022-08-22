import 'dart:convert';

import 'package:artic/blocs/search/search_bloc.dart';
import 'package:artic/ui/pages/artwork_page.dart';
import 'package:artic/ui/widgets/app_title_bar.dart';
import 'package:artic/ui/widgets/search_input.dart';
import 'package:artic/util/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<SearchBloc>(context);
    return BlocProvider.value(
      value: bloc,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: GestureDetector(
            onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
            child: Column(
              children: [
                const AppTitleBar(title: Texts.app_name),
                Expanded(
                  child: Container(
                    color: AppColors.secondary,
                    child: Column(
                      children: [
                        const SizedBox(height: 24.0),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24.0),
                          child: SearchInput(onChanged: (q) => bloc.add(GetResults(q))),
                        ),
                        BlocBuilder<SearchBloc, SearchState>(
                          builder: (context, state) {
                            if (state is SearchLoading) {
                              return const Skelton();
                            }
                            if (state is SearchResults) {
                              return state.data.isEmpty
                                  ? const EmptyPlaceholder(Texts.no_results)
                                  : Results(state);
                            }
                            return const EmptyPlaceholder(Texts.search_artworks_message);
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Results extends StatelessWidget {
  const Results(this.state, {Key? key}) : super(key: key);

  final SearchResults state;

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<SearchBloc>(context);
    return Expanded(
      child: ListView.builder(
        padding: const EdgeInsets.fromLTRB(24.0, 12.0, 24.0, 12.0),
        itemCount: state.data.length + 1,
        itemBuilder: (context, i) {
          if (i == state.data.length) {
            if (state.isLoadingMore) {
              return const Skelton(count: 2, padding: EdgeInsets.all(0.0));
            }
            if (!state.allLoaded) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 12.0),
                  child: TextButton(
                    onPressed: () => bloc.add(GetResults(state.query, true)),
                    child: Text(
                      Texts.load_more.toUpperCase(),
                      style: Theme.of(context).textTheme.subtitle1?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ),
                ),
              );
            } else {
              return const SizedBox();
            }
          }
          final data = state.data[i];
          final image = data.thumbnail?.lqip;
          final placeholder = (image == null
              ? const AssetImage(Images.placeholder)
              : MemoryImage(base64Decode(image.split(',').last))) as ImageProvider;
          return InkWell(
            onTap: () {
              if (data.id == null) return;
              final route = ArtworkPage.route(searchData: data);
              Navigator.push(context, route);
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 12.0),
                Row(
                  children: [
                    if (data.imageId != null) ...[
                      FadeInImage(
                        width: 64.0,
                        height: 64.0,
                        fit: BoxFit.cover,
                        placeholderFit: BoxFit.cover,
                        image: NetworkImage(buildImageUrl(data.imageId!, '64,')),
                        placeholder: placeholder,
                      ),
                    ] else
                      Image(
                        width: 64.0,
                        height: 64.0,
                        fit: BoxFit.cover,
                        image: placeholder,
                      ),
                    const SizedBox(width: 16.0),
                    Flexible(
                      child: Text(
                        data.title ?? '',
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12.0),
                Container(width: double.infinity, height: 1.0, color: AppColors.grey1),
              ],
            ),
          );
        },
      ),
    );
  }
}

class Skelton extends StatelessWidget {
  const Skelton({
    Key? key,
    this.count = 5,
    this.padding = const EdgeInsets.fromLTRB(24.0, 12.0, 24.0, 12.0),
  }) : super(key: key);

  final int count;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: padding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            for (int i = 0; i < count; i++) ...[
              const SizedBox(height: 12.0),
              Row(
                children: [
                  Container(width: 64.0, height: 64.0, color: AppColors.grey1),
                  const SizedBox(width: 16.0),
                  Container(width: 200.0, height: 16.0, color: AppColors.grey1),
                ],
              ),
              const SizedBox(height: 12.0),
              Container(width: double.infinity, height: 1.0, color: AppColors.grey1),
            ],
          ],
        ),
      ),
    );
  }
}

class EmptyPlaceholder extends StatelessWidget {
  const EmptyPlaceholder(this.message, {Key? key}) : super(key: key);

  final String message;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(48.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(Images.canvas, height: 130.0),
            const SizedBox(height: 32.0),
            Text(
              message,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headline5?.copyWith(height: 1.38),
            ),
            const SizedBox(height: 48.0),
          ],
        ),
      ),
    );
  }
}
