import 'dart:math';

import 'package:flutter/material.dart';

class Rating extends StatefulWidget {
  const Rating({Key? key}) : super(key: key);

  @override
  State<Rating> createState() => _RatingState();
}

class _RatingState extends State<Rating> {
  var _ratingPageController = PageController();
  var _starPosition = 200.0;
  var _rating = 0;
  late String comment;
  var _selectedChipIndex = -1;
  var _isMoreDetailActive = false;
  var _moreDetailFocusNode = FocusNode();
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
      ),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        children: [
          Container(
            height: max(300, MediaQuery.of(context).size.height * 0.3),
            child: PageView(
              controller: _ratingPageController,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                _buildThanksNote(),
                _causeOfRating(),
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              color: Colors.grey[400],
              child: MaterialButton(
                onPressed: _hideDialog,
                child: const Text(
                  'Submit Feedback',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                textColor: Colors.black,
              ),
            ),
          ),
          Positioned(
            right: 0,
            child: MaterialButton(
              onPressed: _hideDialog,
              child: const Text('skip'),
            ),
          ),
          AnimatedPositioned(
            top: _starPosition,
            duration: const Duration(milliseconds: 300),
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                5,
                (index) => IconButton(
                  icon: index < _rating
                      ? const Icon(Icons.star, size: 32)
                      : const Icon(Icons.star_border, size: 32),
                  color: Colors.black,
                  onPressed: () {
                    _ratingPageController.nextPage(
                        duration:const Duration(milliseconds: 300),
                        curve: Curves.easeIn);
                    setState(() {
                      _starPosition = 20.0;
                      _rating = index + 1;
                    });
                  },
                ),
              ),
            ),
          ),
          if (_isMoreDetailActive)
            Positioned(
                left: 0,
                top: 0,
                child: MaterialButton(
                  onPressed: () {
                    setState(() {
                      _isMoreDetailActive = false;
                    });
                  },
                  child: Icon(Icons.arrow_back_ios),
                )),
        ],
      ),
    );
  }

  _buildThanksNote() {
    return const Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Please rate your experience on fyp!',
          style: TextStyle(
            fontSize: 24,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        Text(
            '  We are sad to hear about this. Please tell us more and we will resolve your issue!  '),
      ],
    );
  }

  _causeOfRating() {
    return Stack(
      alignment: Alignment.center,
      children: [
        Visibility(
          visible: !_isMoreDetailActive,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('What could be better?'),
              Wrap(
                spacing: 8.0,
                alignment: WrapAlignment.center,
                children: List.generate(
                  6,
                  (index) => InkWell(
                    onTap: () {
                      setState(() {
                        _selectedChipIndex = index;
                      });
                    },
                    child: Chip(
                      backgroundColor: _selectedChipIndex == index
                          ? Colors.purple
                          : Colors.grey[300],
                      label: Text('text ${index + 1}'),
                    ),
                  ),
                ),
              ),
             const SizedBox(
                height: 16,
              ),
              InkWell(
                onTap: () {
                  _moreDetailFocusNode.requestFocus();
                  setState(() {
                    _isMoreDetailActive = true;
                  });
                },
                child:const Text(
                  'Wanted to tell us more',
                  style: TextStyle(decoration: TextDecoration.underline),
                ),
              )
            ],
          ),
          replacement: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
            const  Text('Tell us more'),
              Chip(
                label: Text('Text ${_selectedChipIndex + 1}'),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: TextField(
                  focusNode: _moreDetailFocusNode,
                  decoration: InputDecoration(
                      hintText: 'Write your review here....',
                      hintStyle: TextStyle(
                        color: Colors.grey[400],
                      ),
                      border: InputBorder.none),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }

  _hideDialog() {
    if (Navigator.canPop(context)) Navigator.pop(context);
  }
}
