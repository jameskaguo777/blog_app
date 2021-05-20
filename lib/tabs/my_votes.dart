import 'package:flutter/material.dart';
import 'package:v2/constants/demo_data.dart';

class MyVotes extends StatefulWidget {
  _MyVotes createState() => _MyVotes();
}

class _MyVotes extends State<MyVotes> {
  PageController _pictureSliderPageController =
      PageController(initialPage: 0, keepPage: true);
  int pictureSliverPageViewIndex = 0;
  double _currentSliderValue = 20;
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
          Padding(
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
                          duration: Duration(microseconds: 1000),
                          curve: Curves.easeIn);
                    }
                  },
                  style: ButtonStyle(
                      elevation: MaterialStateProperty.resolveWith<double>(
                          (states) => 0),
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
                      return await _showMyDialogVoting(context);
                    },
                    style: ButtonStyle(
                        elevation: MaterialStateProperty.resolveWith<double>(
                            (states) => 0),
                        shape:
                            MaterialStateProperty.resolveWith<OutlinedBorder>(
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
                          duration: Duration(microseconds: 1000),
                          curve: Curves.easeIn);
                      print(pictureSliverPageViewIndex);
                    } else {
                      print(pictureSliverPageViewIndex);
                    }
                  },
                  style: ButtonStyle(
                      elevation: MaterialStateProperty.resolveWith<double>(
                          (states) => 0),
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
          )
        ],
      ),
    );
  }

  Future<String> _showMyDialogVoting(BuildContext context) async {
    return showDialog<String>(
      context: context,
      useSafeArea: true,
      barrierDismissible: false, // user must tap button!
      builder: (context) {
        return AlertDialog(
          title: Text('Rate in percentage'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Please Slide the slider to evaluate in percentage'),
                Text('Then click submit.'),
                Slider(
                  value: _currentSliderValue,
                  min: 0,
                  max: 100,
                  divisions: 5,
                  label: _currentSliderValue.round().toString(),
                  onChanged: (double value) {
                    setState(() {
                      _currentSliderValue = value;
                    });
                  },
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Submit'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
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
              child: TextFormField(
                keyboardType: TextInputType.text,
            decoration: InputDecoration(
                hintText: 'Enter your comment here',
                
                contentPadding: const EdgeInsets.all(5.0),
                suffix: InkWell(
                  onTap: (){},
                  child: Icon(Icons.send, color: Colors.grey,),
                ),
                border: OutlineInputBorder(borderSide: BorderSide(width: 2))),
          )),
          Container(
            height: MediaQuery.of(context).size.height*0.5,
            padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
            child: ListView.builder(
              itemCount: 10,
              itemBuilder: (context, index) {
              return Container(
                padding: const EdgeInsets.all(5.0),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      width: 2,
                      color: Colors.grey[200]
                    )
                  )
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Wrap(
                      direction: Axis.vertical,
                      alignment: WrapAlignment.start,
                      crossAxisAlignment: WrapCrossAlignment.start,
                      children: [
                        Text('Sinyo Mdau', style: Theme.of(context).textTheme.subtitle1,),
                        Text('Choo kichafu sana bado', style: Theme.of(context).textTheme.subtitle2,)
                      ],

                    ),
                    Text('April 25 2021', style: Theme.of(context).textTheme.caption,)
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
