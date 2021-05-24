import 'package:flutter/material.dart';

class ChallengeDetails extends StatefulWidget {
  ChallengeDetails({Key key}) : super(key: key);
  _ChallengeDetails createState() => _ChallengeDetails();
}

class _ChallengeDetails extends State<ChallengeDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Challenge Details'),
      ),
      body: _bodySection(),
    );
  }

  Widget _bodySection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(8.0, 10.0, 8.0, 8.0),
          child: Text('THEME:', style: Theme.of(context).textTheme.bodyText1,),
        ),
        Container(
          padding: const EdgeInsets.all(10.0),
          margin: const EdgeInsets.all(0),
          color: Colors.blueGrey[100],
          width: double.infinity,
          child: Text('SCHOOL TOILET CLEANLINESS COMPETITION', style: Theme.of(context).textTheme.headline6,),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(8.0, 10.0, 8.0, 8.0),
          child: Text('CHALLENGE NAME:', style: Theme.of(context).textTheme.bodyText1,),
        ),
        Container(
          padding: const EdgeInsets.all(10.0),
          margin: const EdgeInsets.all(0),
          color: Colors.blueGrey[100],
          width: double.infinity,
          child: Text('To what percent is this school toilet clean? 2019', style: Theme.of(context).textTheme.subtitle2,),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(8.0, 10.0, 8.0, 8.0),
          child: Text('CRITERIA & REWARD:', style: Theme.of(context).textTheme.bodyText1,),
        ),
        Container(
          padding: const EdgeInsets.all(10.0),
          margin: const EdgeInsets.all(0),
          color: Colors.blueGrey[100],
          width: double.infinity,
          child: RichText(text: TextSpan(text: 'during the Renaissance. The first line of Lorem Ipsum, "Lorem ipsum dolor sit amet..", comes from a line in section 1.10.32. The standard chunk of Lorem Ipsum used since the 1500s is reproduced below for those interested. Sections 1.10.32 and 1.10.33 from "de Finibus Bonorum et Malorum" by Cicero are also reproduced in their exact original form, accompanied by English versions from the 1914 translation by H. Rackham.', style: Theme.of(context).textTheme.bodyText2)),
        ),
      ],
    );
  }
}
