import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:v2/constants/demo_data.dart';
import 'package:v2/controllers/my_votes_controller.dart';

class MyVotes extends StatefulWidget {
  _MyVotes createState() => _MyVotes();
}

class _MyVotes extends State<MyVotes> {
  PageController _pictureSliderPageController =
      PageController(initialPage: 0, keepPage: true);
  // PageController _votingButtonsPageContrtoller = PageController(initialPage: 0);
  var pictureSliverPageViewIndex = 1.obs;
  var _currentSliderValue = 20.0.obs;
  var commentText = ''.obs;
  // final _myVotesController = Get.put(MyVotesController());
  final _formState = GlobalKey<FormState>();
  Widget myVotesWidget;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      myVotesWidget = votingButtons();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(child: Obx(() {
        // _myVotesController.isSuccessful.value
        //     ? _myVotesController.getParticipant()
        //     : null;
        
          // print('ddata size ${_myVotesController.data.length}');
          return Column(
            children: [_voting(context), _comments()],
          );
        
        // return Center(child: CircularProgressIndicator());
      })),
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
              child: Text(''),
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
                itemCount: 2,
                pageSnapping: true,
                physics: new NeverScrollableScrollPhysics(),
                onPageChanged: (i) => pictureSliverPageViewIndex.value = i,
                scrollDirection: Axis.horizontal,
                controller: _pictureSliderPageController,
                itemBuilder:
                    (BuildContext context, pictureSliverPageViewIndex) {
                  return Image.network(
                    '',
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
        height: MediaQuery.of(context).size.height * .18,
        child: AnimatedSwitcher(
          duration: Duration(microseconds: 1000),
          child: myVotesWidget,
        ));
  }

  Widget votingButtons() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () {
              // if (_myVotesController.data.length - 1 >=
              //         pictureSliverPageViewIndex.value &&
              //     pictureSliverPageViewIndex.value != 1) {
              //   pictureSliverPageViewIndex.value--;
              //   _pictureSliderPageController.animateToPage(
              //       pictureSliverPageViewIndex.value,
              //       duration: Duration(microseconds: 2000),
              //       curve: Curves.easeIn);
              // }
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
                setState(() {
                  myVotesWidget = _ratingSlider();
                });
                // _votingButtonsPageContrtoller.animateToPage(1,
                //     duration: Duration(milliseconds: 500),
                //     curve: Curves.easeIn);
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
              // print('picture index ${pictureSliverPageViewIndex.value}');
              // if (_myVotesController.data.length - 1 >
              //     pictureSliverPageViewIndex.value) {
              //   pictureSliverPageViewIndex.value++;
              //   _pictureSliderPageController.animateToPage(
              //       pictureSliverPageViewIndex.value,
              //       duration: Duration(microseconds: 2000),
              //       curve: Curves.easeIn);
              //   // print(pictureSliverPageViewIndex);
              // } else {
              //   // print(pictureSliverPageViewIndex);
              // }
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
          Obx(() {
            return Slider(
              value: _currentSliderValue.value,
              min: 0,
              max: 100,
              divisions: 10,
              label: _currentSliderValue.round().toString(),
              onChanged: (double value) {
                _currentSliderValue.value = value;
              },
            );
          }),
          Align(
            alignment: Alignment.bottomRight,
            child: TextButton(
                onPressed: () {
                  // _votingButtonsPageContrtoller.animateToPage(0,
                  //     duration: Duration(milliseconds: 500),
                  //     curve: Curves.easeOut);
                  setState(() {
                    myVotesWidget = votingButtons();
                  });
                },
                child: Text('Submit')),
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
                  } else {
                    commentText.value = value;
                  }
                  return null;
                },
                decoration: InputDecoration(
                    hintText: 'Enter your comment here',
                    contentPadding: const EdgeInsets.all(5.0),
                    suffixIcon: InkWell(
                      onTap: () {
                        if (_formState.currentState.validate()) {
                          // _myVotesController.comment(
                          //     _myVotesController.data[
                          //         pictureSliverPageViewIndex.value - 1]['id'],
                          //     commentText.value);
                          _formState.currentState.reset();
                        }
                      },
                      child: Icon(
                        Icons.send,
                        color: Colors.grey,
                      ),
                    ),
                    border:
                        OutlineInputBorder(borderSide: BorderSide(width: 2))),
              )),
          false
              ? Container(
                  padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                  child: ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: 0,
                      itemBuilder: (context, index) {
                        return Container(
                          padding: const EdgeInsets.all(5.0),
                          decoration: BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(
                                      width: 2, color: Colors.grey[200]))),
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
                                    '',
                                    style: Theme.of(context).textTheme.caption,
                                  ),
                                  Text(
                                    '',
                                    style:
                                        Theme.of(context).textTheme.subtitle1,
                                  )
                                ],
                              ),
                              Text(
                                '',
                                style: Theme.of(context).textTheme.overline,
                              )
                            ],
                          ),
                        );
                      }),
                )
              : Text(
                  'No Comments yet! Be the first one',
                  style: Theme.of(context)
                      .textTheme
                      .headline6
                      .copyWith(color: Colors.grey[350]),
                )
        ],
      ),
    );
  }
}
