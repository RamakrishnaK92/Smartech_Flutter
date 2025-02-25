import 'package:flutter/material.dart';
import 'package:smartechapp/utils/utils.dart';
import 'package:smartechapp/utils/videoplayer.dart';
import 'package:smartech_appinbox/model/smt_appinbox_model.dart';

class SMTVideoNotificationView extends StatefulWidget {
  final SMTAppInboxMessage inbox;
  const SMTVideoNotificationView({super.key, required this.inbox});

  @override
  State<SMTVideoNotificationView> createState() =>
      _SMTVideoNotificationViewState();
}

class _SMTVideoNotificationViewState extends State<SMTVideoNotificationView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
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
                  height: 8,
                ),
                InkWell(
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return VideoPlayerDialog(
                            videoUrl: widget.inbox.mediaUrl,
                          );
                        });
                  },
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(8)),
                      color: AppColor.greyColorText.withOpacity(0.3),
                    ),
                    height: MediaQuery.of(context).size.height / 5,
                    child: const Icon(
                      Icons.play_circle_outline_outlined,
                      size: 66,
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
