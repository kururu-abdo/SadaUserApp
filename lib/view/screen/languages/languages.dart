import 'package:eamar_user_app/localization/language_constrants.dart';
import 'package:eamar_user_app/provider/localization_provider.dart';
import 'package:eamar_user_app/provider/splash_provider.dart';
import 'package:eamar_user_app/utill/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LanguagePage extends StatefulWidget {
  const LanguagePage({super.key});

  @override
  State<LanguagePage> createState() => _LanguagePageState();
}

class _LanguagePageState extends State<LanguagePage> {
  @override
  Widget build(BuildContext context) {

    _title(String val) {
      switch (val) {
        case 'en':
          return Text(
            'English',
            style: TextStyle(fontSize: 16.0),
          );
        case 'ar':
          return Text(
            'العربية',
            style: TextStyle(fontSize: 16.0),
          );

        case 'es':
          return Text(
            'Spanish',
            style: TextStyle(fontSize: 16.0),
          );

        case 'it':
          return Text(
            'Italian',
            style: TextStyle(fontSize: 16.0),
          );

        default:
          return Text(
            'English',
            style: TextStyle(fontSize: 16.0),
          );
      }
    }

     List<Locale> _locals = [];
    AppConstants.languages.forEach((language) {
      _locals.add(Locale(language.languageCode!, language.countryCode));
    });
    return   Consumer<LocalizationProvider>(builder: (context, provider, snapshot) {
      var lang = provider.locale ?? Localizations.localeOf(context);



return Scaffold( extendBodyBehindAppBar: true,
      backgroundColor: Colors.black,
       
appBar: PreferredSize(
  preferredSize: Size.fromHeight(150),
  child:   Hero(
    tag: 'bar',
    child: GestureDetector(
      onTap: (){
        Navigator.pop(context);
      },
      child: AppBar(
        leading: SizedBox.shrink(),
        flexibleSpace: Center(
          child: Image.asset('assets/images/logo_with_name.png'  , color: Colors.white ,),
        ),
      backgroundColor: Color(0xFFe69211),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(100)
          )
        ),
      ),
    ),
  ),
),

     body: Center(
child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                getTranslated("select_lang", context)!+":" ,
              
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w500,color: Colors.white
                ),
              ),
              SizedBox(height:85.0),
              Container(
                padding: EdgeInsets.all(5), 
                width: 300,
                decoration: BoxDecoration(
                  color: Colors.grey , 
                  borderRadius: BorderRadius.circular(20)
                ),
                child: DropdownButton(
                    value: lang,
                    
                    onChanged: (Locale? val) {
                      provider.setLanguage(val!);
              
              context.read<SplashProvider>().disableFirstTime();
              Navigator.pop(context);
              
              
              
                    },
                    items: _locals
                        .map((e) => DropdownMenuItem(
                      value: e,
                      child: _title(e.languageCode),

                      
                    ))
                        .toList()),
              )
            ],
          ),
     )
);
    });
  }
}