import 'package:artic/util/constants.dart';
import 'package:flutter/material.dart';

class AppTitleBar extends StatelessWidget {
  const AppTitleBar({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 24.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: Row(
              children: [
                if (Navigator.canPop(context)) ...[
                  InkWell(
                    onTap: () => Navigator.pop(context),
                    child: Image.asset(Images.arrow_left, width: 24.0),
                  ),
                  const SizedBox(width: 16.0),
                ],
                Flexible(
                  child: Text(
                    title,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.headline4,
                  ),
                ),
              ],
            ),
          ),
          Hero(tag: Images.logo, child: Image.asset(Images.logo, width: 42.0))
        ],
      ),
    );
  }
}
