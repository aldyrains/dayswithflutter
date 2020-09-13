import 'dart:async';
import 'dart:math';

import 'package:day1analogclock/constants.dart';
import 'package:day1analogclock/model/mytheme_provider.dart';
import 'package:day1analogclock/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class Clock extends StatefulWidget {
  
  @override
  _ClockState createState() => _ClockState();
}

class _ClockState extends State<Clock> {
  DateTime _dateTime = DateTime.now();
  @override
  void initState() {
    super.initState();
    Timer.periodic(Duration(seconds: 1), (timer){
        setState(() {
          _dateTime = DateTime.now();
        });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: AspectRatio(
            aspectRatio: 1,
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                shape: BoxShape.circle,
                boxShadow:[
                  BoxShadow(
                    offset: Offset(0,0),
                    color: kShadowColor.withOpacity(0.14),
                    blurRadius: 64,
                  )
                ]
              ),
              child: Transform.rotate(
                angle: -pi/2,
                  child: CustomPaint(
                  painter: ClockPainter(context , _dateTime),
                ),
              ),
            ),
            ),
        ),
        Positioned(
          top: 50,
          left: 0,
          right: 0,
          child: Consumer<MyThemeModel>(
            builder: (context , theme , child) => GestureDetector(
              onTap: () => theme.changeTheme(),
                          child: SvgPicture.asset(
                theme.isLightTheme ?
          'assets/icons/Sun.svg':
          'assets/icons/Moon.svg',
              height: 24,
              width: 24,
              color: Theme.of(context).primaryColor,
        ),
            ),)
        )
      ],
    ); 
  }
}

class ClockPainter extends CustomPainter{
    final BuildContext context;
    final DateTime dateTime;
    ClockPainter(this.context, this.dateTime);
  @override
  void paint(Canvas canvas ,  Size size){
    double centerX = size.width / 2 ;
    double centerY = size.height / 2 ;
    Offset center= Offset(centerX, centerY);

    //minute calculation
    double minX = centerX + size.width * 0.35 * cos((dateTime.minute * 6)* pi /180);
    double minY = centerY + size.width * 0.35 * sin((dateTime.minute * 6)* pi /180);

    //hour Calculation
    double hourX = centerX + size.width * 0.3 * cos((dateTime.hour * 30 + dateTime.minute * 0.5)* pi /180);
    double hourY = centerY + size.width * 0.3 * sin((dateTime.hour * 30 + dateTime.minute * 0.5)* pi /180);

    //second calculation
    //size.width * 0,4 define our line height
    //datetime.second * 6 because 360 / 60 = 6
    double secondX = centerX + size.width * 0.4 * cos((dateTime.second * 6 ) * pi /180);
    double secondY = centerY + size.width * 0.4 * sin((dateTime.second * 6 ) * pi /180);

    //hour line
    canvas.drawLine(center, Offset(hourX,hourY), Paint()
    ..color = Theme.of(context).colorScheme.secondary
    ..style = PaintingStyle.stroke
    ..strokeWidth = 10 ,
    );


    //second line
    canvas.drawLine(center, Offset(secondX, secondY),
    Paint()..color = Theme.of(context).primaryColor
    );

    
    //minute line
    canvas.drawLine(center, Offset(minX, minY), 
    Paint()
    ..color = Theme.of(context).accentColor
    ..style = PaintingStyle.stroke
    ..strokeWidth = 10
    );

    //center dots
    Paint dotPainter = Paint()
    ..color = Theme.of(context).primaryIconTheme.color;
    canvas.drawCircle(center, 24, dotPainter);
    canvas.drawCircle(center, 23, Paint()..color = Theme.of(context).backgroundColor);
    canvas.drawCircle(center, 10, dotPainter);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate){
    return true;

  }
}