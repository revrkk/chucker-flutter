import 'package:chucker_flutter/src/helpers/extensions.dart';
import 'package:chucker_flutter/src/localization/localization.dart';

import 'package:chucker_flutter/src/models/api_response.dart';
import 'package:chucker_flutter/src/view/helper/colors.dart';
import 'package:flutter/material.dart';

///[ApisListingItemWidget] renders the [ApiResponse] items in
///`ApisListingTabView`
class ApisListingItemWidget extends StatelessWidget {
  ///[ApisListingItemWidget] renders the [ApiResponse] items in
  ///1ApisListingTabView`
  const ApisListingItemWidget({
    required this.index,
    required this.baseUrl,
    required this.dateTime,
    required this.method,
    required this.path,
    required this.statusCode,
    required this.onDelete,
    required this.checked,
    required this.onChecked,
    required this.showDelete,
    required this.onPressed,
    Key? key,
  }) : super(key: key);

  ///base url of api request such as `https://www.api.com`
  final String baseUrl;

  final int index;

  ///request path such as `/users`
  final String path;

  ///method type of api request such as GET, PUT, POST, DELETE
  final String method;

  ///status code of api response such as `200` for OK
  final int statusCode;

  ///Creation time of api request
  final DateTime dateTime;

  ///Callback to delete a request
  final void Function(String) onDelete;

  ///Used for selection
  final bool checked;

  ///Callback to select a request
  final void Function(String) onChecked;

  ///Whether to hide or show delete button
  final bool showDelete;

  ///Callback when user presses this instance
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      key: const ValueKey('api_listing_item_widget'),
      onTap: onPressed,
      onLongPress: () {
        onChecked(dateTime.toString());
      },
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 14,
              backgroundColor: Theme.of(context).colorScheme.primary,
              child: Text(
                '${index + 1}',
                style: const TextStyle(color: Colors.white),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          color: statusColor(statusCode),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          statusCode.toString(),
                          textAlign: TextAlign.center,
                          style: context.textTheme.bodySmall!
                              .toBold()
                              .withColor(Colors.white),
                        ),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Text(
                        method,
                        style: context.textTheme.bodySmall!
                            .toBold()
                            .withColor(methodColor(method))
                            .withSize(14),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          path,
                          style: context.textTheme.bodySmall!
                              .toBold()
                              .withSize(14),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    baseUrl.isEmpty ? Localization.strings['nA']! : baseUrl,
                    style: context.textTheme.bodySmall!.withColor(Colors.grey),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    dateTime.toString(),
                    style: context.textTheme.bodySmall!.withColor(Colors.grey),
                  ),
                ],
              ),
            ),
            Visibility(
              visible: showDelete,
              child: IconButton.filledTonal(
                onPressed: () => onDelete(dateTime.toString()),
                icon: const Icon(
                  Icons.clear,
                  color: Colors.red,
                ),
              ),
            ),
            if (checked)
              CircleAvatar(
                backgroundColor: Theme.of(context).colorScheme.primary,
                child: Checkbox(
                  side: BorderSide.none,
                  value: checked,
                  onChanged: (_) => onChecked(dateTime.toString()),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
