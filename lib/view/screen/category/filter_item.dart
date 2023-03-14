
import 'package:eamar_user_app/data/model/response/category.dart';
import 'package:eamar_user_app/localization/language_constrants.dart';
import 'package:eamar_user_app/provider/product_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FilterDialogUser extends StatefulWidget {
 final List<Category>  cats;
  FilterDialogUser({Key key, this.cats}) : super(key: key);

  @override
  State<FilterDialogUser> createState() => _FilterDialogUserState();
}

class _FilterDialogUserState extends State<FilterDialogUser> {
  Map<String, List<String>> filters = {};
  bool needRefresh = false;
  List<bool> isClickedCountry =[];

 List<FilterItem<Category>> children=[] ;
  @override
  void initState() {
    super.initState();
    // filters = widget.initialState;
    isClickedCountry = List.filled(widget.cats.length, false);
   widget.cats.forEach((element) {
      children.add(
        FilterItem(element.name,
        categoty: element.id
        // subitems: element.subCategories.map((e) => FilterItem(e.name ,)).toList()
        )
      );

    });
  }

  int _selectedIndex=0;
  // Building a dialog box with filters.
  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
        title:  Text(getTranslated('filter_txt', context),
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
                          _selectedIndex=index;
                          isClickedCountry[index] = !isClickedCountry[index];
                        });
                      },
                      child: Row(
                        children: [ 
                          //  isClickedCountry[index]
                          //     ? const Icon(Icons.arrow_circle_up)
                          //     : const Icon(Icons.arrow_circle_down)
                          
                          IconButton(onPressed: (){
                             Provider.of<ProductProvider>(context, listen: false)
                             .filterBrandAndCategoryProductList(context, e.categoty);
setState(() {
  _selectedIndex=index;
});
                          }, icon: Icon( 
index==_selectedIndex?
                               Icons.category
                              : Icons.category

                          )) ,
                          
                          Text(e.text),
                          const Spacer(),

                          TextButton(onPressed: ()async{
 Provider.of<ProductProvider>(context, listen: false).changeProductId(e.categoty);

await
 Provider.of<ProductProvider>(context, listen: false)
                             .filterBrandAndCategoryProductList(context, 
                             e.categoty);
Navigator.pop(context);

                          }, child: Text(getTranslated('show_txt', context)))
                        //  Checkbox(
                        //     value: e.selected,
                        //     onChanged: (value) => setState(() {
                        //       e.subitems.forEach((element) =>
                        //           element.selected = value as bool);
                        //       e.selected = value as bool;
                        //     }),
                        //   ),
                        ],
                      ),
                    ),


                    // if (e.subitems.isNotEmpty)
                    //    _selectedIndex !=index
                    //       ? Container()
                    //       : Padding(
                    //           padding: const EdgeInsets.fromLTRB(30, 0, 0, 0),
                    //           child: Column(
                    //             children: e.subitems.map((e) {
                    //               return Row(children: [
                    //                 Checkbox(
                    //                   value: e.selected,
                    //                   onChanged: (value) => setState(() {
                    //                     e.selected = value as bool;
                    //                   }),
                    //                 ),
                    //                 Text(e.text),
                    //               ]);
                    //             }).toList(),
                    //           ),
                    //         )
                  ],
                );
              },
            ).toList(),
          ),

      

        ],
        
        
        );
  }
}





class FilterItem<T> {
  final String text;
  final int categoty;
  bool selected;
  List<FilterItem> subitems;

  FilterItem(
    this.text, {
      this.categoty,
    this.selected = false,
    this.subitems = const [],
  });
}




/*

 ExpansionTile(
            title: Text("Parent Category 1"),
            leading: Icon(Icons.person), //add icon
            childrenPadding: EdgeInsets.only(left:60), //children padding
            children: [
                  ListTile( 
                      title: Text("Child Category 1"),
                      onTap: (){ 
                        //action on press
                      },
                  ),

                  ListTile( 
                      title: Text("Child Category 2"),
                      onTap: (){ 
                        //action on press
                      },
                  ),

                  //more child menu
            ],
            ),




*/