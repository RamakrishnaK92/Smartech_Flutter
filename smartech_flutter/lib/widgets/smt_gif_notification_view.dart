import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smartechapp/utils/utils.dart';
import 'package:smartech_appinbox/model/smt_appinbox_model.dart';

class GIFNotificationView extends StatelessWidget {
  final SMTAppInboxMessage inbox;
  const GIFNotificationView({super.key, required this.inbox});
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
                inbox.publishedDate!.getTimeAndDayCount(),
                style: const TextStyle(
                    fontSize: 12,
                    color: AppColor.greyColorText,
                    fontWeight: FontWeight.w400),
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            htmlText(inbox.title),
            if (inbox.subtitle.toString() != "") htmlText(inbox.subtitle),
            htmlText(inbox.body),
            const SizedBox(
              height: 8,
            ),
            inbox.mediaUrl != ""
                ? Center(
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width - 26,
                      child: CachedNetworkImage(
                        fit: BoxFit.fill,
                        placeholder: (context, url) => const Center(
                          child: CupertinoActivityIndicator(),
                        ),
                        imageUrl: inbox.mediaUrl.toString(),
                      ),
                    ),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
