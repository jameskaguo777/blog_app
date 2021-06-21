import 'package:flutter/material.dart';
import 'package:v2/constants/demo_data.dart';

class MyVotes extends StatefulWidget {
  _MyVotes createState() => _MyVotes();
}

class _MyVotes extends State<MyVotes> {
  PageController _pictureSliderPageController =
      PageController(initialPage: 0, keepPage: true);
  PageController _votingButtonsPageContrtoller = PageController(initialPage: 0);
  int pictureSliverPageViewIndex = 0;
  double _currentSliderValue = 20;
  final _formState = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        child: Column(
          children: [_voting(context), _comments()],
        ),
      ),
    );
  }

  Widget _voting(BuildContext context) => Container(
        width: double.infinity,
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Challenge:'),
            Container(
              width: double.infinity,
              margin: const EdgeInsets.fromLTRB(0, 8.0, 0, 8.0),
              padding: const EdgeInsets.all(8.0),
              child: Text('To what percent is this school toilet clean? 2019'),
              color: Colors.white,
            ),
            _pictureSlider(context)
          ],
        ),
      );

  Widget _pictureSlider(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.width,
            child: PageView.builder(
                itemCount: CHALLECHES['challenges'].length,
                pageSnapping: true,
                physics: new NeverScrollableScrollPhysics(),
                onPageChanged: (i) => pictureSliverPageViewIndex = i,
                scrollDirection: Axis.horizontal,
                controller: _pictureSliderPageController,
                itemBuilder:
                    (BuildContext context, pictureSliverPageViewIndex) {
                  return Image.network(
                    CHALLECHES['challenges'][pictureSliverPageViewIndex],
                    loadingBuilder: (context, widget, events) {
                      return events == null
                          ? widget
                          : Center(
                              child: Wrap(
                              children: [
                                CircularProgressIndicator(),
                                Text(
                                    'Downloaded ${events.cumulativeBytesLoaded}/${events.expectedTotalBytes}'),
                              ],
                            ));
                    },
                  );
                }),
          ),
          _votingButtonsPager(),
        ],
      ),
    );
  }

  Widget _votingButtonsPager() {
    return Container(
      height: MediaQuery.of(context).size.height*.18,
      child: PageView(
          scrollDirection: Axis.vertical,
          controller: _votingButtonsPageContrtoller,
          physics: new NeverScrollableScrollPhysics(),
          children: <Widget>[_votingButtons(), _ratingSlider()],
        ),
    );
  }

  Widget _votingButtons() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () {
              if (CHALLECHES['challenges'].length >=
                      pictureSliverPageViewIndex &&
                  pictureSliverPageViewIndex != 0) {
                pictureSliverPageViewIndex--;
                _pictureSliderPageController.animateToPage(
                    pictureSliverPageViewIndex,
                    duration: Duration(microseconds: 2000),
                    curve: Curves.easeIn);
              }
            },
            style: ButtonStyle(
                elevation:
                    MaterialStateProperty.resolveWith<double>((states) => 0),
                shape: MaterialStateProperty.resolveWith<OutlinedBorder>(
                    (states) => RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)))),
            child: Container(
              width: MediaQuery.of(context).size.width * 0.2,
              height: MediaQuery.of(context).size.width * 0.1,
              child: Icon(Icons.arrow_back),
            ),
          ),
          ElevatedButton(
              onPressed: () async {
                _votingButtonsPageContrtoller.animateToPage(1,
                    duration: Duration(milliseconds: 500),
                    curve: Curves.easeIn);
              },
              style: ButtonStyle(
                  elevation:
                      MaterialStateProperty.resolveWith<double>((states) => 0),
                  shape: MaterialStateProperty.resolveWith<OutlinedBorder>(
                      (states) => CircleBorder(
                          side: BorderSide(
                              color: Colors.grey[200], width: 3.0)))),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.2,
                height: MediaQuery.of(context).size.width * 0.2,
                alignment: Alignment.center,
                child: Text(
                  'Vote',
                  style: Theme.of(context)
                      .textTheme
                      .headline5
                      .copyWith(color: Colors.white),
                ),
              )),
          ElevatedButton(
            onPressed: () {
              if (CHALLECHES['challenges'].length >
                  pictureSliverPageViewIndex) {
                pictureSliverPageViewIndex++;
                _pictureSliderPageController.animateToPage(
                    pictureSliverPageViewIndex,
                    duration: Duration(microseconds: 2000),
                    curve: Curves.easeIn);
                print(pictureSliverPageViewIndex);
              } else {
                print(pictureSliverPageViewIndex);
              }
            },
            style: ButtonStyle(
                elevation:
                    MaterialStateProperty.resolveWith<double>((states) => 0),
                shape: MaterialStateProperty.resolveWith<OutlinedBorder>(
                    (states) => RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)))),
            child: Container(
              width: MediaQuery.of(context).size.width * 0.2,
              height: MediaQuery.of(context).size.width * 0.1,
              child: Icon(Icons.arrow_forward),
            ),
          ),
        ],
      ),
    );
  }

  Widget _ratingSlider() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Text('Slide the slider to rate the picture in % higher the better.'),
          Text('Current value $_currentSliderValue%'),
          Slider(
            value: _currentSliderValue,
            min: 0,
            max: 100,
            divisions: 10,
            label: _currentSliderValue.round().toString(),
            onChanged: (double value) {
              setState(() {
                _currentSliderValue = value;
              });
            },
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: TextButton(onPressed: () {
              _votingButtonsPageContrtoller.animateToPage(0,
                      duration: Duration(milliseconds: 500),
                      curve: Curves.easeOut);
            }, child: Text('Submit')),
          )
        ],
      ),
    );
  }

  Widget _comments() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
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
            padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
            child: ListView.builder(
              
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                  itemCount: COMMENTSLIISTS.length,
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
                  COMMENTSLIISTS[index]['name'],
                  style: Theme.of(context).textTheme.caption,
                ),
                Text(
                  COMMENTSLIISTS[index]['comment'],
                  style: Theme.of(context).textTheme.subtitle1,
                )
              ],
            ),
            Text(
              COMMENTSLIISTS[index]['date'],
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
