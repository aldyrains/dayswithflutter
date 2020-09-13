

import 'package:day1analogclock/screens/component/clock.dart';
import 'package:day1analogclock/screens/component/countryCard.dart';
import 'package:day1analogclock/screens/component/time_in_hour.dart';
import 'package:flutter/material.dart';


class Body extends StatelessWidget {
  const Body({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
          child: SizedBox(
        width: double.infinity,
        child: Column(
          children: [
            Text(
              'Arians , Bandung | Indonesia',
              style: Theme.of(context).textTheme.bodyText1,
            ),
            TimeInHour(),
            Clock(),
            Spacer(),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
                child: Row(
                children: [
                  CountryCard(country: 'New York, USA',
                  iconSrc:"assets/icons/Liberty.svg",
                  priod:"AM" ,
                  time: "12:08",
                  timeZone:"-11 HRS | EST" ,),

                  CountryCard(country: 'Sydney, AUS',
                  iconSrc:"assets/icons/Sydney.svg",
                  priod:"AM" ,
                  time: "5:08",
                  timeZone:"+10 HRS | EST" ,),

                  CountryCard(country: 'Instanbul, Turki',
                  iconSrc:"assets/icons/Liberty.svg",
                  priod:"PM" ,
                  time: "4:08",
                  timeZone:"-4 HRS | EST" ,),
                ],
              ),
            )
          ],
        ), 
      ),
    );
  }
}



