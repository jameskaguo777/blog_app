import 'package:flutter/material.dart';
import 'package:v2/constants/demo_data.dart';

class Event extends StatefulWidget {
  _Event createState() => _Event();
}

class _Event extends State<Event> {
  final _formState = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Event Name'),
      ),
      body: SafeArea(
          child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Column(
            children: [_topImage(), _bodySection()],
          ),
        ),
      )),
    );
  }

  Widget _topImage() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.width * .8,
      child: Image.network(
        CHALLECHES['challenges'][1],
        fit: BoxFit.cover,
      ),
    );
  }

  Widget _bodySection() {
    return Container(
      margin: const EdgeInsets.all(8.0),
      padding: const EdgeInsets.all(8.0),
      width: double.infinity,
      color: Colors.blueGrey[100],
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Epuka kujigusagusa uso pale unapovaa maski',
            style: Theme.of(context).textTheme.headline6,
          ),
          Text(
            'Epuka kujigusagusa uso pale unapovaa maski. Pale unapo pata dalili zza mafua na ukosaji pumzi basi wasili katika vitu vya afya kw msaada zaidi',
            style: Theme.of(context).textTheme.subtitle1,
          ),
          _comments()
        ],
      ),
    );
  }

  Widget _comments() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 10.0, 0, 0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Comments'),
          SizedBox(
            height: 10,
          ),
          Form(
              key: _formState,
              child: TextFormField(
                keyboardType: TextInputType.text,
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please write a comment before commiting';
                  }
                  return null;
                },
                decoration: InputDecoration(
                    hintText: 'Enter your comment here',
                    contentPadding: const EdgeInsets.all(5.0),
                    suffixIcon: InkWell(
                      onTap: () {
                        if (_formState.currentState.validate()) {}
                      },
                      child: Icon(
                        Icons.send,
                        color: Colors.grey,
                      ),
                    ),
                    border:
                        OutlineInputBorder(borderSide: BorderSide(width: 2))),
              )),
          Container(
            height: MediaQuery.of(context).size.height * 0.5,
            padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
            child: ListView.builder(
                itemCount: 10,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return Container(
                    padding: const EdgeInsets.all(5.0),
                    decoration: BoxDecoration(
                        border: Border(
                            bottom:
                                BorderSide(width: 2, color: Colors.grey[200]))),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Wrap(
                          direction: Axis.vertical,
                          alignment: WrapAlignment.start,
                          crossAxisAlignment: WrapCrossAlignment.start,
                          children: [
                            Text(
                              'Sinyo Mdau',
                              style: Theme.of(context).textTheme.caption,
                            ),
                            Text(
                              'Choo kichafu sana bado',
                              style: Theme.of(context).textTheme.subtitle1,
                            )
                          ],
                        ),
                        Text(
                          'April 25 2021',
                          style: Theme.of(context).textTheme.overline,
                        )
                      ],
                    ),
                  );
                }),
          )
        ],
      ),
    );
  }
}
