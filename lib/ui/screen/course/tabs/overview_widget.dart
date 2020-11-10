import 'package:flutter/cupertino.dart';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:masterstudy_app/data/models/ReviewResponse.dart';
import 'package:masterstudy_app/data/models/course/CourseDetailResponse.dart';
import 'package:masterstudy_app/theme/theme.dart';
import 'package:masterstudy_app/ui/screen/course/meta_icon.dart';
import 'package:masterstudy_app/ui/screen/review_write/review_write_screen.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../../../main.dart';

class OverviewWidget extends StatefulWidget {
  final CourseDetailResponse response;
  final ReviewResponse reviewResponse;

  const OverviewWidget(this.response, this.reviewResponse) : super();

  @override
  State<StatefulWidget> createState() {
    return _OverviewWidgetState();
  }
}

class _OverviewWidgetState extends State<OverviewWidget> with AutomaticKeepAliveClientMixin{
  bool descTextShowFlag = false;
  bool reviewTextShowFlag = false;
  bool annoncementTextShowFlag = false;
  int reviewsListShowItems = 1;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: <Widget>[
            //Description
            _buildDescription(),
            //Meta
            Column(
              children: widget.response.meta.map((value) {
                return Column(
                  children: <Widget>[
                    InkWell(
                      onTap: () {},
                      child: Padding(
                        padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                MetaIcon(
                                  value.type,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Text(
                                      value.label,
                                    textScaleFactor: 1.0,
                                  ),
                                )
                              ],
                            ),
                            Text(
                              value.text,
                              textScaleFactor: 1.0,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      ),
                    ),
                    Container(
                      height: 2,
                      color: Colors.black.withOpacity(0.1),
                    ),
                  ],
                );
              }).toList(),
            ),
            _buildAnnoncement(widget.response.announcement),
            _buildReviewsStat(widget.response.rating),
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: new MaterialButton(
                minWidth: double.infinity,
                color: mainColor,
                onPressed: () {
                  Navigator.of(context).pushNamed(
                    ReviewWriteScreen.routeName,
                    arguments: ReviewWriteScreenArgs(
                        widget.response.id, widget.response.title),
                  );
                },
                child: Text(
                  localizations.getLocalization("write_review_button"),
                  textScaleFactor: 1.0,
                ),
                textColor: Colors.white,
              ),
            ),
            _buildReviewList( widget.reviewResponse.posts ),
          ],
        ),
      ),
    );
  }

  WebViewController _descriptionWebViewController;
  double descriptionHeight;

  _buildDescription() {
    double webContainerHeight;
    if (descriptionHeight != null && descTextShowFlag) {
      webContainerHeight = descriptionHeight;
    } else {
      webContainerHeight = 160;
    }

    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: <
        Widget>[
      Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
        ConstrainedBox(
          constraints: BoxConstraints(maxHeight: webContainerHeight),
          child: WebView(
            javascriptMode: JavascriptMode.unrestricted,
            initialUrl:
                'data:text/html;base64,${base64Encode(const Utf8Encoder().convert(widget.response.description))}',
            onPageFinished: (some) async {
              double height = double.parse(
                  await _descriptionWebViewController.evaluateJavascript(
                      "document.documentElement.scrollHeight;"));
              setState(() {
                descriptionHeight = height;
              });
            },
            onWebViewCreated: (controller) async {
              controller.clearCache();
              this._descriptionWebViewController = controller;
            },
          ),
        ),
      ]),
      Padding(
        padding: const EdgeInsets.only(top:8.0),
        child: InkWell(
          onTap: () {
            setState(() {
              descTextShowFlag = !descTextShowFlag;
            });
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              descTextShowFlag
                  ? Text(
                    localizations.getLocalization("show_less_button"),
                textScaleFactor: 1.0,
                      style: TextStyle(color: mainColor),
                    )
                  : Text(
                  localizations.getLocalization("show_more_button"),
                  textScaleFactor: 1.0,
                  style: TextStyle(color: mainColor))
            ],
          ),
        ),
      ),
    ]);
  }

  WebViewController _annoncementWebViewController;
  double annoncementHeight;

  _buildAnnoncement(String announcement) {
    if (announcement == null || announcement.isEmpty) return Center();

    double webContainerHeight;
    if (annoncementHeight != null && annoncementTextShowFlag) {
      webContainerHeight = annoncementHeight;
    } else {
      webContainerHeight = 160;
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
              child: Text(
                  localizations.getLocalization("annoncement_title"),
                  textScaleFactor: 1.0,
                  style: Theme.of(context)
                      .primaryTextTheme
                      .title
                      .copyWith(color: dark, fontStyle: FontStyle.normal)),
            )
          ],
        ),
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
          ConstrainedBox(
            constraints: BoxConstraints(maxHeight: webContainerHeight),
            child: WebView(
              javascriptMode: JavascriptMode.unrestricted,
              initialUrl:
                  'data:text/html;base64,${base64Encode(const Utf8Encoder().convert(announcement))}',
              onPageFinished: (some) async {
                double height = double.parse(
                    await _annoncementWebViewController.evaluateJavascript(
                        "document.documentElement.scrollHeight;"));
                setState(() {
                  annoncementHeight = height;
                });
              },
              onWebViewCreated: (controller) async {
                controller.clearCache();
                this._annoncementWebViewController = controller;
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top:8.0),
            child: InkWell(
              onTap: () {
                setState(() {
                  annoncementTextShowFlag = !annoncementTextShowFlag;
                });
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  annoncementTextShowFlag
                      ? Text(
                    localizations.getLocalization("show_less_button"),
                    textScaleFactor: 1.0,
                          style: TextStyle(color: mainColor),
                        )
                      : Text(localizations.getLocalization("show_more_button"),
                      textScaleFactor: 1.0,
                      style: TextStyle(color: mainColor))
                ],
              ),
            ),
          ),
        ]),
      ],
    );
  }

  _buildReviewsStat(RatingBean rating) {
    var total = rating.total;
    var onePercent = total / 100;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
              child: Text(localizations.getLocalization("reviews_title"),
                  textScaleFactor: 1.0,
                  style: Theme.of(context)
                      .primaryTextTheme
                      .title
                      .copyWith(color: dark, fontStyle: FontStyle.normal)),
            )
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Column(
              children: <Widget>[
                _buildStatRow(
                    "5", rating.details.five / onePercent, rating.details.five),
                _buildStatRow(
                    "4", rating.details.four / onePercent, rating.details.four),
                _buildStatRow("3", rating.details.three / onePercent,
                    rating.details.three),
                _buildStatRow(
                    "2", rating.details.two / onePercent, rating.details.two),
                _buildStatRow(
                    "1", rating.details.one / onePercent, rating.details.one),
              ],
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                    height: 140,
                    width: 130,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        color: HexColor.fromHex("#EEF1F7")),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          rating.average.toDouble().toString().substring(0, 3),
                          textScaleFactor: 1.0,
                          style: TextStyle(fontSize: 50),
                        ),
                        RatingBar(
                          initialRating: rating.average.toDouble(),
                          minRating: 0,
                          direction: Axis.horizontal,
                          allowHalfRating: true,
                          itemCount: 5,
                          itemSize: 19,
                          unratedColor: HexColor.fromHex("#CCCCCC"),
                          itemBuilder: (context, index) {
                            return Icon(
                              Icons.star,
                              color: Colors.amber,
                            );
                          },
                          onRatingUpdate: (rating) {
                          },
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text(
                            "(${rating.total} ${localizations.getLocalization("reviews_count")})",
                            textScaleFactor: 1.0,
                            style:
                                TextStyle(color: HexColor.fromHex("#AAAAAA")),
                          ),
                        ),
                      ],
                    ))
              ],
            )
          ],
        )
      ],
    );
  }

  _buildStatRow(stars, double progress, count) {

    return Padding(
      padding: const EdgeInsets.only(bottom: 15.0),
      child: Row(
        children: <Widget>[
          Text(
            "$stars ${localizations.getLocalization("stars_count")}",
            textScaleFactor: 1.0,
            style: TextStyle(
                color: HexColor.fromHex("#777777"),
                fontWeight: FontWeight.bold,
                fontSize: 14),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8.0),
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(30)),
              child: SizedBox(
                width: 105,
                height: 15,
                child: LinearProgressIndicator(
                  value: (!progress.isNaN) ? progress / 100 : 0,
                  backgroundColor: HexColor.fromHex("#F3F5F9"),
                  valueColor: new AlwaysStoppedAnimation<Color>(
                      HexColor.fromHex("#ECA824")),
                ),
              ),
            ),
          ),
          Text(
            "$count",
            textScaleFactor: 1.0,
            style: TextStyle(
                color: HexColor.fromHex("#777777"),
                fontWeight: FontWeight.bold,
                fontSize: 14),
          )
        ],
      ),
    );
  }

  _buildReviewList(List<ReviewBean> reviews) {
    if (reviews == null || reviews.isEmpty) return Center();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        ListView.builder(
            primary: false,
            shrinkWrap: true,
            itemCount: reviewsListShowItems,
            itemBuilder: (context, index) {
              var item = reviews[index];
              return _buildReviewItem(item);
            }),
        (reviews.length != 1) ?
        InkWell(
          onTap: () {
            setState(() {
              reviewsListShowItems == 1
                  ? reviewsListShowItems = reviews.length
                  : reviewsListShowItems = 1;
            });
          },
          child: Padding(
            padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                reviewsListShowItems != 1
                    ? Text(
                  localizations.getLocalization("show_less_button"),
                  textScaleFactor: 1.0,
                  style: TextStyle(color: mainColor),
                )
                    : Text(localizations.getLocalization("show_more_button"),
                    textScaleFactor: 1.0,
                    style: TextStyle(color: mainColor))
              ],
            ),
          ),
        )
            : Center()
      ],
    );
  }

  _buildReviewItem(ReviewBean review) {

    return Padding(
      padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
      child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              color: HexColor.fromHex("#EEF1F7")),
          child: Padding(
              padding: EdgeInsets.only(
                  top: 15.0, right: 20.0, bottom: 15.0, left: 20.0),
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Expanded(
                        flex: 6,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(bottom: 5.0),
                              child: Text(
                                review.user,
                                textScaleFactor: 1.0,
                                style: TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.w600,
                                    color: HexColor.fromHex("#273044")),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(bottom: 5.0),
                              child: Text(
                                review.time,
                                textScaleFactor: 1.0,
                                style: TextStyle(
                                    fontSize: 14.0,
                                    color: HexColor.fromHex("#AAAAAA")),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            RatingBar(
                              initialRating: review.mark.toDouble(),
                              minRating: 0,
                              direction: Axis.horizontal,
                              allowHalfRating: true,
                              itemCount: 5,
                              itemSize: 19,
                              unratedColor: HexColor.fromHex("#CCCCCC"),
                              itemBuilder: (context, index) {
                                return Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                );
                              },
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  Html(
                    data: review.content
                  ),
                ],
              ))),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
