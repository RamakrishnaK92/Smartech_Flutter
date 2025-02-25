import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:smartechapp/utils/utils.dart';
import 'package:smartech_appinbox/model/smt_appinbox_model.dart';
import 'package:url_launcher/url_launcher.dart';

class SMTSimpleNotificationView extends StatelessWidget {
  final SMTAppInboxMessage inbox;
  const SMTSimpleNotificationView({super.key, required this.inbox});
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: Column(
        children: [
          Padding(
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
                htmlText(inbox.title),
                if (inbox.subtitle.toString() != "") htmlText(inbox.subtitle),
                htmlText(inbox.body),
              ],
            ),
          ),
          inbox.actionButton.isNotEmpty
              ? Container(
                  padding: const EdgeInsets.only(top: 16, bottom: 16),
                  color: const Color.fromRGBO(247, 247, 247, 1),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: inbox.actionButton.map((e) {
                      return Expanded(
                          child: Center(
                              child: e.aTyp == 1
                                  ? InkWell(
                                      onTap: () async {
                                        if (e.actionDeeplink.contains("http")) {
                                          print("navigate to browser with url");
                                          final Uri url =
                                              Uri.parse(e.actionDeeplink);
                                          if (!await launchUrl(url)) {
                                            throw 'Could not launch $url';
                                          }
                                          // await FlutterWebBrowser.openWebPage(url: e.actionDeeplink);
                                        } else if (e.actionDeeplink.contains(
                                            "smartechflutter://profile")) {
                                          //NavigationUtilities.pushRoute(UpdateProfile.route);
                                        } else {
                                          // Map<String, dynamic> dict = HashMap();
                                          // dict["actionDeeplink"] = e.actionDeeplink;
                                          // dict['isFromScreen'] = true;
                                          // NavigationUtilities.pushRoute(
                                          //   DeepLinkScreen.route,
                                          //   args: dict,
                                          // );
                                        }
                                      },
                                      child: Text(
                                        e.actionName.toString(),
                                        style: const TextStyle(
                                            color:
                                                Color.fromRGBO(75, 79, 81, 1),
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    )
                                  : e.aTyp == 2
                                      ? InkWell(
                                          onTap: () async {
                                            print("navigation called");
                                            Clipboard.setData(ClipboardData(
                                                    text: e.configCtxt))
                                                .then((result) {
                                              const snackBar = SnackBar(
                                                content: Text('Copied'),
                                                duration:
                                                    Duration(milliseconds: 500),
                                              );
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                      snackBar); // -> show a notification
                                            });
                                            if (e.actionDeeplink
                                                .contains("https")) {
                                              print(
                                                  "navigate to browser with url");
                                              final Uri url =
                                                  Uri.parse(e.actionDeeplink);
                                              if (!await launchUrl(url)) {
                                                throw 'Could not launch $url';
                                              }
                                              // await FlutterWebBrowser.openWebPage(url: e.actionDeeplink);
                                            } else if (e.actionDeeplink.contains(
                                                "smartechflutter://profile")) {
                                              //NavigationUtilities.pushRoute(UpdateProfile.route);
                                            }
                                          },
                                          child: Text(
                                            e.actionName.toString(),
                                            style: const TextStyle(
                                                color: Color.fromRGBO(
                                                    75, 79, 81, 1),
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        )
                                      : const SizedBox(
                                          height: 0,
                                        )));
                    }).toList(),
                  ),
                )
              : const SizedBox(
                  height: 0,
                ),
        ],
      ),
    );
  }
}
