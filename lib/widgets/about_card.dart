import 'package:flutter/material.dart';
import 'package:bug_busters/models/app.dart';
import 'package:bug_busters/themes/decoration.dart';
import 'package:bug_busters/widgets/buttons.dart';

class TeamMemberInfoCard extends StatelessWidget {
  TeamMemberInfoCard(this.memberIndex);

  final int memberIndex;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 0.0, vertical: 5.0),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${creators[memberIndex].name}',
              style: kDefaultTextStyleBold,
            ),
            SizedBox(
              height: 10.0,
            ),
            Text(
              '${creators[memberIndex].about}',
              style: TextStyle(
                fontSize: 16.0,
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Text(
              'Role: ${creators[memberIndex].role}',
              style: TextStyle(
                fontSize: 16.0,
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Wrap(
              alignment: WrapAlignment.start,
              children: [
                Visibility(
                  visible: creators[memberIndex].facebook != null,
                  child: SocialMediaButton(
                    icon: 'Facebook',
                    url: creators[memberIndex].facebook,
                  ),
                ),
                Visibility(
                  visible: creators[memberIndex].github != null,
                  child: SocialMediaButton(
                    icon: 'GitHub',
                    url: creators[memberIndex].github,
                  ),
                ),
                Visibility(
                  visible: creators[memberIndex].instagram != null,
                  child: SocialMediaButton(
                    icon: 'Instagram',
                    url: creators[memberIndex].instagram,
                  ),
                ),
                Visibility(
                  visible: creators[memberIndex].linkedin != null,
                  child: SocialMediaButton(
                    icon: 'LinkedIn',
                    url: creators[memberIndex].linkedin,
                  ),
                ),
                Visibility(
                  visible: creators[memberIndex].twitter != null,
                  child: SocialMediaButton(
                    icon: 'Twitter',
                    url: creators[memberIndex].twitter,
                  ),
                ),
                Visibility(
                  visible: creators[memberIndex].youtube != null,
                  child: SocialMediaButton(
                    icon: 'YouTube',
                    url: creators[memberIndex].youtube,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
