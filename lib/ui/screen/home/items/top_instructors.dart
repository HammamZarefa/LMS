import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:masterstudy_app/data/models/InstructorsResponse.dart';
import 'package:masterstudy_app/theme/theme.dart';
import 'package:masterstudy_app/ui/screen/detail_profile/detail_profile_screen.dart';

class TopInstructorsWidget extends StatelessWidget {
  final List<InstructorBean> list;
  final String title;

  TopInstructorsWidget(
      this.title,
    this.list, {
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return (list.length != 0) ? Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
            padding: const EdgeInsets.only(top: 30.0, left: 30.0, bottom: 20),
            child: Text(title,
                textScaleFactor: 1.0,
                style: Theme.of(context)
                    .primaryTextTheme
                    .title
                    .copyWith(color: dark, fontStyle: FontStyle.normal))),
        _buildList(context)
      ],
    ) : Center();
  }

  _buildList(context) {
    return Container(
      decoration: BoxDecoration(color: HexColor.fromHex("#eef1f7")),
      child: Padding(
        padding: const EdgeInsets.only(top: 20.0, bottom: 20),
        child: ConstrainedBox(
          constraints: new BoxConstraints(minHeight: 250, maxHeight: 250),
          child: new ListView.builder(
            itemCount: list.length,
            itemBuilder: (context, index) {
              var item = list[index];
              return Padding(
                padding: EdgeInsets.only(left: 15),
                child: _buildCard(
                    context,
                    item.id,
                    item.avatar_url,
                    item.meta.first_name,
                    item.meta.last_name,
                    item.meta.position,
                    item.rating.average,
                    item.rating.total),
              );
            },
            padding: const EdgeInsets.all(8.0),
            scrollDirection: Axis.horizontal,
          ),
        ),
      ),
    );
  }

  _buildCard(
      context,id, avatar, firstName, lastName, position, stars, reviewsCount) {
    return SizedBox(
      width: 160,
      child: InkWell(
        onTap: (){
          Navigator.pushNamed(
            context,
            DetailProfileScreen.routeName,
            arguments: DetailProfileScreenArgs.fromId(id),
          );
        },
        child: Card(
          borderOnForeground: true,
          elevation: 3,
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(60.0),
                    child: Image.network(
                      avatar,
                      width: 70,
                      height: 70,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, left: 8, right: 8),
                  child: Text(
                    "$firstName" + " $lastName",
                    textScaleFactor: 1.0,
                    textAlign: TextAlign.center,
                    style: Theme.of(context)
                        .primaryTextTheme
                        .headline
                        .copyWith(color: dark, fontSize: 18),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 4.0, left: 8, right: 8),
                  child: Text(
                    position,
                    textScaleFactor: 1.0,
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context)
                        .primaryTextTheme
                        .headline
                        .copyWith(color: Colors.grey[600], fontSize: 16),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: RatingBar(
                    initialRating: stars.toDouble(),
                    minRating: 0,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 5,
                    itemSize: 19,
                    itemBuilder: (context, _) => Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    onRatingUpdate: (rating) {
                      print(rating);
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(
                    "$stars ($reviewsCount review)",
                    textScaleFactor: 1.0,
                    style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
