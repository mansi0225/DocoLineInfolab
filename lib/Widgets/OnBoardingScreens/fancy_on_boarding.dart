library fancy_on_boarding;

import 'dart:async';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:newdocolineproject/Widgets/OnBoardingScreens/fancy_page.dart';
import 'package:newdocolineproject/Widgets/OnBoardingScreens/page_dragger.dart';
import 'package:newdocolineproject/Widgets/OnBoardingScreens/page_model.dart';
import 'package:newdocolineproject/Widgets/OnBoardingScreens/page_reveal.dart';
import 'package:newdocolineproject/Widgets/OnBoardingScreens/pager_indicator.dart';

class FancyOnBoarding extends StatefulWidget {
  final List<PageModel> pageList;
  final VoidCallback onDoneButtonPressed;
  final VoidCallback? onSkipButtonPressed;
  final String doneButtonText;
  final ShapeBorder? doneButtonShape;
  final ShapeBorder? skipButtonShape;
  final TextStyle? doneButtonTextStyle;
  final Color? doneButtonBackgroundColor;
  final String skipButtonText;
  final TextStyle? skipButtonTextStyle;
  final Color? skipButtonColor;
  final bool showSkipButton;

  FancyOnBoarding({
    required this.pageList,
    required this.onDoneButtonPressed,
    this.onSkipButtonPressed,
    this.doneButtonText = "Done",
    this.doneButtonShape,
    this.skipButtonShape,
    this.doneButtonTextStyle,
    this.doneButtonBackgroundColor,
    this.skipButtonText = "Skip",
    this.skipButtonTextStyle,
    this.skipButtonColor,
    this.showSkipButton = true,
  }) : assert(pageList.length != 0 && onDoneButtonPressed != null);

  @override
  _FancyOnBoardingState createState() => _FancyOnBoardingState();
}

class _FancyOnBoardingState extends State<FancyOnBoarding>
    with TickerProviderStateMixin {
  late StreamController<SlideUpdate> slideUpdateStream;
  late AnimatedPageDragger animatedPageDragger;
  late List<PageModel> pageList;
  int activeIndex = 0;
  int nextPageIndex = 0;
  SlideDirection slideDirection = SlideDirection.none;
  double slidePercent = 0.0;

  bool get isRTL => ui.window.locale.languageCode.toLowerCase() == "ar";

  @override
  void initState() {
    super.initState();
    this.pageList = widget.pageList;
    this.slideUpdateStream = StreamController<SlideUpdate>();
    _listenSlideUpdate();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        FancyPage(
          model: pageList[activeIndex],
          percentVisible: 1.0,
        ),
        PageReveal(
          revealPercent: slidePercent,
          child: FancyPage(
            model: pageList[nextPageIndex],
            percentVisible: slidePercent,
          ),
        ),
        Positioned(
          bottom: 8.0,
          child: PagerIndicator(
            isRtl: isRTL,
            viewModel: PagerIndicatorViewModel(
              pageList,
              activeIndex,
              slideDirection,
              slidePercent,
            ),
          ),
        ),
        PageDragger(
          pageLength: pageList.length - 1,
          currentIndex: activeIndex,
          canDragLeftToRight: activeIndex > 0,
          canDragRightToLeft: activeIndex < pageList.length - 1,
          slideUpdateStream: this.slideUpdateStream,
        ),
        Positioned(
          bottom: 16,
          right: isRTL ? null : 8,
          left: isRTL ? 8 : null,
          child: Opacity(
            opacity: _getOpacity(),
            child: FlatButton(
              padding: EdgeInsets.all(8),
              shape: widget.doneButtonShape ??
                  RoundedRectangleBorder(
                      borderRadius:  BorderRadius.only(
                          topLeft: Radius.circular(5.0),
                          topRight: Radius.circular(24.0),
                          bottomLeft: Radius.circular(24.0),
                          bottomRight: Radius.circular(5.0))
                  ),
              color:
                  widget.doneButtonBackgroundColor ?? const Color(0xFF08364B),
              child: Text(
                widget.doneButtonText,
                style: widget.doneButtonTextStyle ??
                    const TextStyle(
                        color: Colors.white,
                        fontSize: 22.0,
                        fontWeight: FontWeight.w800),
              ),
              onPressed:
                  _getOpacity() == 1.0 ? widget.onDoneButtonPressed : () {},
            ),
          ),
        ),
        // widget.showSkipButton
        //     ? Positioned(
        //         top: MediaQuery.of(context).padding.top,
        //         right: isRTL ? null : 10,
        //         left: isRTL ? 0 : null,
        //         child: FlatButton(
        //        //   color: widget.skipButtonColor,
        //           shape: widget.skipButtonShape ??
        //               RoundedRectangleBorder(
        //                   borderRadius: BorderRadius.circular(16.0)),
        //           color:
        //           widget.skipButtonColor ?? const Color(0xFFF4CC1F),
        //           child: Text(
        //             widget.skipButtonText,
        //             style: widget.skipButtonTextStyle ??
        //                 const TextStyle(
        //                   color: Colors.black,
        //                   fontSize: 18.0,
        //                   fontWeight: FontWeight.w800,
        //                 ),
        //           ),
        //           onPressed: widget.onSkipButtonPressed,
        //         ),
        //       )
        //     : Offstage()
      ],
    );
  }

  _listenSlideUpdate() {
    slideUpdateStream.stream.listen((SlideUpdate event) {
      setState(() {
        if (event.updateType == UpdateType.dragging) {
          slideDirection = event.direction;
          slidePercent = event.slidePercent;

          if (slideDirection == SlideDirection.leftToRight) {
            nextPageIndex = activeIndex - 1;
          } else if (slideDirection == SlideDirection.rightToLeft) {
            nextPageIndex = activeIndex + 1;
          } else {
            nextPageIndex = activeIndex;
          }
        } else if (event.updateType == UpdateType.doneDragging) {
          if (slidePercent > 0.5) {
            animatedPageDragger = AnimatedPageDragger(
              slideDirection: slideDirection,
              transitionGoal: TransitionGoal.open,
              slidePercent: slidePercent,
              slideUpdateStream: slideUpdateStream,
              vsync: this,
            );
          } else {
            animatedPageDragger = AnimatedPageDragger(
              slideDirection: slideDirection,
              transitionGoal: TransitionGoal.close,
              slidePercent: slidePercent,
              slideUpdateStream: slideUpdateStream,
              vsync: this,
            );
            nextPageIndex = activeIndex;
          }

          animatedPageDragger.run();
        } else if (event.updateType == UpdateType.animating) {
          slideDirection = event.direction;
          slidePercent = event.slidePercent;
        } else if (event.updateType == UpdateType.doneAnimating) {
          activeIndex = nextPageIndex;

          slideDirection = SlideDirection.none;
          slidePercent = 0.0;

          animatedPageDragger.dispose();
        }
      });
    });
  }

  double _getOpacity() {
    if (pageList.length - 2 == activeIndex &&
        slideDirection == SlideDirection.rightToLeft) return slidePercent;
    if (pageList.length - 1 == activeIndex &&
        slideDirection == SlideDirection.leftToRight) return 1 - slidePercent;
    if (pageList.length - 1 == activeIndex) return 1.0;
    return 0.0;
  }

  @override
  void dispose() {
    slideUpdateStream.close();
    super.dispose();
  }
}
