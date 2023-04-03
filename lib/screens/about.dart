import 'package:bug_busters/themes/decoration.dart';
import 'package:bug_busters/widgets/about_card.dart';
import 'package:flutter/material.dart';

class AboutUs extends StatelessWidget {
  final Map<String, String> data = {
    'Quick Prediction': 'Our application can predict the disease within no time without compromising with the accuracy.',
    'Highly Accurate': 'The models are trained in such a way that the predictions do not get biased. All the important features are taken in care for making predictions.',
    'Broad Spectrum': 'This application can work on wide range of diseases including liver, heart, diaabetes, etc.',
  };

  final Map<String, String> applications = {
    'Lack of Doctors': 'India is facing a huge shortage of Doctors. According to the report presented by WHO, there are 0.79 doctors  and 2.09 nurses per present per 1000 people. Thus, our application provide a platform for quick and accurate prediction of disease.',
    'Low Accessibility': 'The physical access to hospitals is still the major barrier to both preventive and curative health services, and also the major differences between the Rural and the Urban India. By making use of web technology and AI people in remote areas can also get access to the health-care',
    'Affordable': 'It is the biggest problem many Poor and marginalised are hit the most as by the government estimates, approx. 63 million people are faced with poverty every year because of their healthcare expenditure. Using the technology in a better way healthcare can be made affordable for everyone.',
    'Frauds': 'Several cases are reported in recent times wheres many frauds have taken place in the name of prediction of disease. This tool can serve as primary tool for confirmation. ',
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'About Us',
        ),
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: data.entries.map((entry) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${entry.key}-',
                    style: kDefaultTextStyle.copyWith(
                      fontFamily: 'Aclonica'
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    '${entry.value}-',
                    style: kDefaultTextStyle,
                    textAlign: TextAlign.justify,
                  ),
                  SizedBox(
                    height: 18.0,
                  ),
                ],
              );
            }).toList()
            ..add(
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 18.0,
                  ),
                  Text(
                    'Why this application?',
                    style: kDefaultTextStyleLarge.copyWith(
                      fontFamily: 'Aclonica',
                    ),
                  ),
                  SizedBox(
                    height: 18.0,
                  ),
                ],
              ),
            )
            ..addAll(
              applications.entries.map((entry) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${entry.key}-',
                    style: kDefaultTextStyle.copyWith(
                      fontFamily: 'Aclonica'
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    '${entry.value}-',
                    style: kDefaultTextStyle,
                    textAlign: TextAlign.justify,
                  ),
                  SizedBox(
                    height: 18.0,
                  ),
                ],
              );
            }).toList()
            ..add(
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 18.0,
                  ),
                  Text(
                    'Team Details-',
                    style: kDefaultTextStyleLarge.copyWith(
                      fontFamily: 'Aclonica',
                    ),
                  ),
                  SizedBox(
                    height: 18.0,
                  ),
                ]
                ..addAll(
                  [0,1,2,3].map((index) {
                    return TeamMemberInfoCard(index);
                  }).toList()
                ),
              ),
            )
            ),
          ),
        ),
      ),
    );
  }
}
