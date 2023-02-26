import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wuxia/constant.dart';
import 'package:wuxia/partial/filter_manga.dart';

const mangaOrderBy = [
  'title',
  'description',
  'last',
  'next',
  'chapters',
  'url',
];

const readingOrderBy = [
  'progress',
  'last_read',
];

const orderBy = [
  'ASC',
  'DESC',
];

class OrderManga extends StatefulWidget {
  final FilterType filterType;
  final String defaultValue;

  const OrderManga({super.key, required this.filterType, required this.defaultValue});

  @override
  State<OrderManga> createState() => _OrderMangaState();
}

class _OrderMangaState extends State<OrderManga> {
  String _selectedOrder = mangaOrderBy[0];
  String _selectedOrderType = orderBy[0];

  @override
  void initState() {
    final parts = widget.defaultValue.split(':');

    _selectedOrder = parts[0];
    _selectedOrderType = parts[1];

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final orderBy = '$_selectedOrder:$_selectedOrderType';
        (await SharedPreferences.getInstance())
            .setString(widget.filterType == FilterType.manga ? Constants.orderMangaKey : Constants.orderReadingKey, orderBy);

        Navigator.pop(context, orderBy);
        return false;
      },
      child: SingleChildScrollView(
        controller: ModalScrollController.of(context),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Row(
            children: [
              Expanded(
                flex: 2,
                child: DropdownButton(
                  isExpanded: true,
                  value: _selectedOrder,
                  onChanged: (String? value) {
                    setState(() {
                      _selectedOrder = value!;
                    });
                  },
                  items: mangaOrderBy
                      .followedBy(widget.filterType == FilterType.reading ? readingOrderBy : [])
                      .map((value) => DropdownMenuItem(
                            value: value,
                            child: Text(value),
                          ))
                      .toList(),
                ),
              ),
              Expanded(
                child: DropdownButton(
                  isExpanded: true,
                  onChanged: (String? value) {
                    setState(() {
                      _selectedOrderType = value!;
                    });
                  },
                  value: _selectedOrderType,
                  items: const [
                    DropdownMenuItem(
                      value: 'ASC',
                      child: Text('Ascending'),
                    ),
                    DropdownMenuItem(
                      value: 'DESC',
                      child: Text('Descending'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
