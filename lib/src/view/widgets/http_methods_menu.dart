import 'package:chucker_flutter/src/helpers/extensions.dart';
import 'package:chucker_flutter/src/localization/localization.dart';
import 'package:chucker_flutter/src/view/helper/colors.dart';
import 'package:chucker_flutter/src/view/helper/http_methods.dart';
import 'package:flutter/material.dart';

/// Http Methods Chips
class HttpMethodsMenu extends StatelessWidget {
  const HttpMethodsMenu({
    required this.httpMethod,
    required this.onFilter,
    Key? key,
  }) : super(key: key);

  final HttpMethod httpMethod;
  final void Function(HttpMethod) onFilter;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        spacing: 8,
        children: [
          _chip(
            context,
            Localization.strings['all']!,
            HttpMethod.none,
          ),
          _chip(context, 'GET', HttpMethod.get),
          _chip(context, 'POST', HttpMethod.post),
          _chip(context, 'PUT', HttpMethod.put),
          _chip(context, 'PATCH', HttpMethod.patch),
          _chip(context, 'DELETE', HttpMethod.delete),
        ],
      ),
    );
  }

  Widget _chip(
    BuildContext context,
    String label,
    HttpMethod method,
  ) {
    final bool selected = httpMethod == method;

    return ChoiceChip(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusGeometry.circular(32),
      ),
      label: Text(
        label,
        style: context.textTheme.bodyMedium!.withColor(
          selected ? Colors.white : Colors.black,
        ),
      ),
      selected: selected,
      labelPadding: EdgeInsets.all(0),
      selectedColor: methodColor(label),
      backgroundColor: Colors.grey.shade200,
      onSelected: (_) => onFilter(method),
    );
  }
}
