import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:v2/apis.dart';
import 'package:v2/constants/demo_data.dart';
import 'package:v2/controllers/old_api_controller/my_vote_controller.dart';

class MyVotes extends StatefulWidget {
  _MyVotes createState() => _MyVotes();
}

class _MyVotes extends State<MyVotes> {
  PageController _pictureSliderPageController =
      PageController(initialPage: 0, keepPage: true);
  // PageController _votingButtonsPageContrtoller = PageController(initialPage: 0);
  var pictureSliverPageViewIndex = 0.obs;
  var _currentSliderValue = 20.0.obs;
  var commentText = ''.obs;
  // final _myVotesController = Get.put(MyVotesController());
  final _formState = GlobalKey<FormState>();
  Widget myVotesWidget;
  final _myVoteController = Get.put(MyVoteController());

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 1)).then((_) {
      myVotesWidget = votingButtons();
      _myVoteController.getImagesToVote();
      if (_myVoteController.images.isNotEmpty) {
        _myVoteController.getComments(
            _myVoteController.images[pictureSliverPageViewIndex.value]['id']);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
          child: Column(
        children: [
          Obx(() {
            if (_myVoteController.isLoading.value) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              if (_myVoteController.success.value) {

                return _voting(context);
              } else {
                if (_myVoteController.message.value != '') {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(_myVoteController.message.value),
                  ));
                }
                return Center(
                  child: Text('There is some error try again'),
                );
              }
            }
          }),
          Obx(() => _myVoteController.isLoadingComment.value
              ? Center(child: CircularProgressIndicator())
              : _comments()),
        ],
      )),
    );
  }

  Widget _voting(BuildContext context) => Container(
        width: double.infinity,
        padding: const EdgeInsets.all(8.0),
        child: _pictureSlider(context),
      );

  Widget _pictureSlider(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * .855,
      child: PageView.builder(
          itemCount: _myVoteController.images.length,
          pageSnapping: true,
          physics: new NeverScrollableScrollPhysics(),
          onPageChanged: (i) => pictureSliverPageViewIndex.value = i,
          scrollDirection: Axis.horizontal,
          controller: _pictureSliderPageController,
          itemBuilder: (BuildContext context, pictureSliverPageViewIndex) {
            return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Challenge:'),
                  Container(
                    width: double.infinity,
                    margin: const EdgeInsets.fromLTRB(0, 8.0, 0, 8.0),
                    padding: const EdgeInsets.all(8.0),
                    child: Text(_myVoteController.competitionName.value),
                    color: Colors.white,
                  ),
                  Container(
                    width: double.infinity,
                    child: InteractiveViewer(
                      panEnabled: false, // Set it to false
                      boundaryMargin: EdgeInsets.all(100),
                      minScale: 0.5,
                      maxScale: 2,
                      child: Image.network(
                        IMAGE_SOURCE_BASE_URL +
                            _myVoteController.images[pictureSliverPageViewIndex]
                                ['url'],
                        fit: BoxFit.contain,
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
                      ),
                    ),
                  ),
                  _votingButtonsPager(),
                ]);
          }),
    );
  }

  Widget _votingButtonsPager() {
    return Container(
        height: MediaQuery.of(context).size.height * .18,
        child: AnimatedSwitcher(
          switchInCurve: Curves.easeInOut,
          switchOutCurve: Curves.easeInOutExpo,
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
              if (CHALLECHES['challenges'].length >=
                      pictureSliverPageViewIndex.value &&
                  pictureSliverPageViewIndex.value != 0) {
                pictureSliverPageViewIndex--;
                _myVoteController.getComments(_myVoteController
                    .images[pictureSliverPageViewIndex.value]['id']);
                _pictureSliderPageController.animateToPage(
                    pictureSliverPageViewIndex.value,
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
              if (CHALLECHES['challenges'].length >
                  pictureSliverPageViewIndex.value) {
                pictureSliverPageViewIndex++;
                _myVoteController.getComments(_myVoteController
                    .images[pictureSliverPageViewIndex.value]['id']);
                _pictureSliderPageController.animateToPage(
                    pictureSliverPageViewIndex.value,
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
        child: Obx(() {
          return Column(
            children: [
              Text(
                  'Slide the slider to rate the picture in % higher the better.'),
              Text('Current value $_currentSliderValue.value%'),
              Slider(
                value: _currentSliderValue.value,
                min: 0,
                max: 100,
                divisions: 10,
                label: _currentSliderValue.round().toString(),
                onChanged: (double value) {
                  _currentSliderValue.value = value;
                },
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () => {
                      setState(() {
                        myVotesWidget = votingButtons();
                      })
                    },
                    child: Text(
                      'Cancel',
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                  TextButton(
                      onPressed: () {
                        _myVoteController.vote(
                            _currentSliderValue.round().toString(),
                            pictureSliverPageViewIndex.value.toString());
                        setState(() {
                          myVotesWidget = votingButtons();
                        });
                      },
                      child: Text('Submit'))
                ],
              ),
            ],
          );
        }));
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
          _myVoteController.comments.isNotEmpty
              ? Container(
                  padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                  child: ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: _myVoteController.comments.length,
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
                              Flexible(
                                flex: 2,
                                child: Wrap(
                                  direction: Axis.vertical,
                                  alignment: WrapAlignment.start,
                                  crossAxisAlignment: WrapCrossAlignment.start,
                                  children: [
                                    Text(
                                      _myVoteController.comments[index]['name'],
                                      style:
                                          Theme.of(context).textTheme.caption,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    RichText(
                                      text: TextSpan(
                                          text: _myVoteController
                                              .comments[index]['review']),
                                    )
                                  ],
                                ),
                              ),
                              Flexible(
                                flex: 1,
                                child: Text(
                                  _myVoteController.comments[index]
                                      ['created_at'],
                                  style: Theme.of(context).textTheme.overline,
                                ),
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
