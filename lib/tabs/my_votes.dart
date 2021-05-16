import 'package:flutter/material.dart';
import 'package:v2/constants/demo_data.dart';

class MyVotes extends StatefulWidget {
  _MyVotes createState() => _MyVotes();
}

class _MyVotes extends State<MyVotes> {
  PageController _pictureSliderPageController =
      PageController(initialPage: 0, keepPage: true);
  int pictureSliverPageViewIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          _voting(),
        ],
      ),
    );
  }

  Widget _voting() => Container(
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
            _pictureSlider()
          ],
        ),
      );

  Widget _pictureSlider() {
    return Container(
      child: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.width,
            child: PageView.builder(
                itemCount: CHALLECHES['challenges'].length,
                pageSnapping: true,
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
                              child: Text(
                                  'Downloaded ${events.cumulativeBytesLoaded}/${events.expectedTotalBytes}'),
                            );
                    },
                  );
                }),
          ),
          Row(
            children: [
              IconButton(
                  icon: Icon(Icons.arrow_back),
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
                  }),
              IconButton(
                  icon: Icon(Icons.arrow_forward),
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
                  }),
            ],
          )
        ],
      ),
    );
  }
}
