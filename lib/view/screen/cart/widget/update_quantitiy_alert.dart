import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class QuantityAlert extends StatefulWidget {
    final Function(int value) onConfirm;      // <------------|     
  const QuantityAlert({ Key key, this.onConfirm }) : super(key: key);

  @override
  _QuantityAlertState createState() => _QuantityAlertState();
}

class _QuantityAlertState extends State<QuantityAlert> with TickerProviderStateMixin{
   AnimationController controller;
   Animation<double> animation;
 @override
  void initState() {
    super.initState();
    _initScaleAnimation();
  }

  _initScaleAnimation() {
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..addListener(() => setState(() {}));

    animation = Tween<double>(begin: 0, end: 1.0).animate(controller);

    controller.forward();
  }
  var _textController =TextEditingController();
  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: animation,
      // alignment: Alignment.topLeft, // use different alignment
      child:  AlertDialog(
        backgroundColor: Colors.cyanAccent,
        title: Text("Count"),

        content: SizedBox(
          height: 180,
          child: Center(child: SizedBox(
            width: 180,
            child: TextField(
              controller: _textController,
              keyboardType: TextInputType.number ,
             inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            
            decoration: InputDecoration(
          hintText: 'Number' ,
      suffixIcon: CircleIconButton(
        onPressed: () {
          this.setState(() {
            _textController.clear();
          });
        },
      ),
          contentPadding: EdgeInsets.symmetric(
            vertical: 20
          )
            ),
            
            ),
          ),),
        ),
     
     
     

actionsAlignment: MainAxisAlignment.end,
    actions: [
      TextButton(onPressed: (){

      }, child: Text('Submit'))
    ],
     
     
     
      ),
    );
  }
}



class CircleIconButton extends StatelessWidget {
final double size;
final Function onPressed;
final IconData icon;

CircleIconButton({this.size = 30.0, this.icon = Icons.clear, this.onPressed});

@override
Widget build(BuildContext context) {
  return InkWell(
    onTap: this.onPressed,
    child: SizedBox(
        width: size,
        height: size,
        child: Stack(
          alignment: Alignment(0.0, 0.0), // all centered
          children: <Widget>[
            Container(
              width: size,
              height: size,
              decoration: BoxDecoration(
                  shape: BoxShape.circle, color: Colors.grey[300]),
            ),
            Icon(
              icon,
              size: size * 0.6, // 60% width for icon
            )
          ],
        )));
  }
}