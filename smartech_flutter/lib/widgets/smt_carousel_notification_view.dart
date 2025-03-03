import 'package:flutter/material.dart';
import 'package:smartechapp/utils/utils.dart';
import 'package:smartech_appinbox/model/smt_appinbox_model.dart';

class SMTCarouselNotificationView extends StatefulWidget {
  final SMTAppInboxMessage inbox;
  const SMTCarouselNotificationView({super.key, required this.inbox});

  @override
  State<SMTCarouselNotificationView> createState() =>
      _SMTCarouselNotificationViewState();
}

class _SMTCarouselNotificationViewState
    extends State<SMTCarouselNotificationView> {
  late PageController _pageController;

  @override
  void initState() {
    _pageController =
        PageController(initialPage: 0, viewportFraction: 1, keepPage: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                widget.inbox.publishedDate!.getTimeAndDayCount(),
                style: const TextStyle(
                    fontSize: 12,
                    color: AppColor.greyColorText,
                    fontWeight: FontWeight.w400),
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            htmlText(widget.inbox.title),
            if (widget.inbox.subtitle.toString() != "")
              htmlText(widget.inbox.subtitle),
            htmlText(widget.inbox.body),
            const SizedBox(
              height: 16,
            ),
            Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
              SizedBox(
                height: 175,
                child: PageView.builder(
                    itemCount: widget.inbox.carousel.length,
                    controller: _pageController,
                    itemBuilder: (BuildContext context, int index) {
                      return InkWell(
                        onTap: () async {
                          Future.delayed(const Duration(milliseconds: 500),
                              () async {
                            // Globle().deepLinkNavigation(widget.inbox.carousel[index].imgDeeplink, {});
                          });
                        },
                        child: Column(
                          children: [
                            Stack(
                              children: [
                                Container(
                                  child: Image.network(
                                    widget.inbox.carousel[index].imgUrl,
                                    width: double.infinity,
                                    height: 120,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Positioned(
                                  left: 0,
                                  bottom: 8,
                                  child: InkWell(
                                    onTap: () {
                                      _pageController.jumpToPage(index - 1);
                                    },
                                    child: Container(
                                      color: Colors.white.withOpacity(0.6),
                                      child: const Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Icon(
                                          Icons.arrow_back_ios_rounded,
                                          size: 26,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  right: 0,
                                  bottom: 8,
                                  child: InkWell(
                                    onTap: () {
                                      if (index !=
                                          widget.inbox.carousel.length - 1) {
                                        _pageController.jumpToPage(index + 1);
                                      }
                                    },
                                    child: Container(
                                      color: Colors.white.withOpacity(0.6),
                                      child: const Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Icon(
                                          Icons.arrow_forward_ios_rounded,
                                          size: 26,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Text(
                              widget.inbox.carousel[index].imgTitle.toString(),
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 14.0,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const SizedBox(
                              height: 4,
                            ),
                            Text(
                              widget.inbox.carousel[index].imgMsg.toString(),
                              style: const TextStyle(
                                color: AppColor.greyColorText,
                                fontSize: 12.0,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
              )
            ]),
          ],
        ),
      ),
    );
  }
}
