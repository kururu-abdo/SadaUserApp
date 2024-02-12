import 'package:eamar_user_app/data/model/response/category.dart';
import 'package:flutter/material.dart';

class FilterDialogUser extends StatefulWidget {
 final List<SubSubCategory>?  cats;
  FilterDialogUser({Key? key, this.cats}) : super(key: key);

  @override
  State<FilterDialogUser> createState() => _FilterDialogUserState();
}

class _FilterDialogUserState extends State<FilterDialogUser> {
  Map<String, List<String>> filters = {};
  bool needRefresh = false;
  List<bool> isClickedCountry =[];

 List<FilterItem> children=[] ;
  @override
  void initState() {
    super.initState();
    // filters = widget.initialState;
    isClickedCountry = List.filled(widget.cats!.length, false);
   widget.cats!.forEach((element) {
      children.add(
        FilterItem(element.name,
        // subitems: element.map((e) => FilterItem(e.name ,)).toList()
        )
      );

    });
  }

  
  // Building a dialog box with filters.
  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
        title: const Text('Filters',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 25,
              // fontFamily: 'SuisseIntl',
            )),
        contentPadding: const EdgeInsets.all(16),

        // Defining parameters for filtering.
        children: [
          Column(
            children: children.map(
              (e) {
                final int index = children.indexOf(e);
                return Column(
                  children: [
                    InkWell(
                      onTap: () async {
                        setState(() {
                          isClickedCountry[index] = !isClickedCountry[index];
                        });
                      },
                      child: Row(
                        children: [
                           isClickedCountry[index]
                              ? const Icon(Icons.arrow_circle_up)
                              : const Icon(Icons.arrow_circle_down),
                          
                          Text(e.text!),
                          const Spacer(),
                         Checkbox.adaptive(
                            value: e.selected,
                            onChanged: (value) => setState(() {
                              e.subitems.forEach((element) =>
                                  element.selected = value as bool?);
                              e.selected = value as bool?;
                            }),
                          ),
                        ],
                      ),
                    ),
                    if (e.subitems.isNotEmpty)
                      !isClickedCountry[index]
                          ? Container()
                          : Padding(
                              padding: const EdgeInsets.fromLTRB(30, 0, 0, 0),
                              child: Column(
                                children: e.subitems.map((e) {
                                  return Row(children: [
                                    Checkbox(
                                      value: e.selected,
                                      onChanged: (value) => setState(() {
                                        e.selected = value as bool?;
                                      }),
                                    ),
                                    Text(e.text!),
                                  ]);
                                }).toList(),
                              ),
                            )
                  ],
                );
              },
            ).toList(),
          ),
        ]);
  }
}





class FilterItem {
  final String? text;
  bool? selected;
  List<FilterItem> subitems;

  FilterItem(
    this.text, {
    this.selected = false,
    this.subitems = const [],
  });
}
