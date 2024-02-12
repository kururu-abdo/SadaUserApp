import 'package:eamar_user_app/view/screen/auth/widget/phone_widget.dart';
import 'package:flutter/material.dart';

class IndexPage extends StatefulWidget {
  const IndexPage({super.key});

  @override
  State<IndexPage> createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(

      body: SizedBox.expand(
        child: Center(child:


          PhoneWidget(

          )
        ),
      ),
    );
  }
}