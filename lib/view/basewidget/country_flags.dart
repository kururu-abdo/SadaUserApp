import 'package:eamar_user_app/provider/phone_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class CountryFlags extends StatefulWidget {
  const CountryFlags({super.key});

  @override
  State<CountryFlags> createState() => _CountryFlagsState();
}

class _CountryFlagsState extends State<CountryFlags> {
    int _counter = 0;
  
  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }
  @override
  Widget build(BuildContext context) {
    var provider =Provider.of<PhoneNumberProvider>(context);
    return  AlertDialog(
      title: const Text('Select Country code'),
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20))),
      actions: <Widget>[
        TextButton(
          child: const Text('CANCEL'),
         
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        TextButton(
          child: const Text('OK'),
          // materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          // textColor: Theme.of(context).accentColor,
          onPressed: () {
            // provider.confirmSelection();
            Navigator.pop(context);
          },
        ),
      ],
      content: SingleChildScrollView(
        child: SizedBox(
          width: double.maxFinite,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const Divider(),

               TextFormField(

              
 style: const TextStyle(
        color: Color(0xFFBAC3D2) , 
        fontSize: 16 , 
        fontWeight: FontWeight.w700
      ),
onChanged: (str){
  provider.search(str);
},
              decoration: const InputDecoration(

hintText: 'Search',

hintStyle:  TextStyle(
        color: Color(0xFFBAC3D2) , 
        fontSize: 14 , 
        fontWeight: FontWeight.w700
      ),
                suffixIcon: Icon(Icons.search) ,

                 border: UnderlineInputBorder(
    
     borderSide: BorderSide(
      color: Color(0xFF717E95) , 
     
      width: 1
     )
     ),  
     
     enabledBorder: UnderlineInputBorder(
     borderSide: BorderSide(
      color: Color(0xFF717E95) , 
     
      width: 1
     )
     ),  
     focusedBorder: UnderlineInputBorder(
     borderSide: BorderSide(
      color: Color(0xFF717E95) , 
     
      width: 1
     )
     ), 
              ),
              ),
              ConstrainedBox(
                constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.height * 0.4,
                ),
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: provider.searchCountries.length,
                    itemBuilder: (BuildContext context, int index) {
                      return RadioListTile.adaptive(
                          title: Row(

                            mainAxisSize: MainAxisSize.min,
                            children: [
 

SvgPicture.asset(
  provider.searchCountries[index].flag!, 

  height: 20 ,width: 30,
)
,
const SizedBox(width: 5,),
Text(provider.searchCountries[index].countryCode!) ,
const SizedBox(width: 5,),
Text(provider.searchCountries[index].name!) ,



                            ],
                          ),
                          value: index,
                          groupValue: provider.selectedCountryIndex,
                          onChanged: (value) {
                            // setState(() {
                            //   _selected = index;
                            // });

                            provider.setSelecedIndex(value!);
                          });
                    }),
              ),
              // const Divider(),
              // const TextField(
              //   autofocus: false,
              //   maxLines: 1,
              //   style: TextStyle(fontSize: 18),
              //   decoration: InputDecoration(
              //     border: InputBorder.none,
              //     hintText: "hint",
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}


