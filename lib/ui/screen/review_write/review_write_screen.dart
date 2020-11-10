import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:masterstudy_app/main.dart';
import 'package:masterstudy_app/theme/theme.dart';
import 'package:masterstudy_app/ui/bloc/review_write/bloc.dart';
import 'package:shimmer/shimmer.dart';

class ReviewWriteScreenArgs {
    final int courseId;
    final String courseTitle;

    ReviewWriteScreenArgs(this.courseId, this.courseTitle);
}

class ReviewWriteScreen extends StatelessWidget {
    static const routeName = "reviewWriteScreen";
    final ReviewWriteBloc _bloc;

    const ReviewWriteScreen(this._bloc) : super();

    @override
    Widget build(BuildContext context) {
        final ReviewWriteScreenArgs args = ModalRoute.of(context).settings.arguments;
        return BlocProvider<ReviewWriteBloc>(
            create: (c) => _bloc, child: _ReviewWriteScreenWidget(args.courseId, args.courseTitle));
    }
}

class _ReviewWriteScreenWidget extends StatefulWidget {
    final int courseId;
    final String courseTitle;

    const _ReviewWriteScreenWidget(this.courseId, this.courseTitle);

    @override
    State<StatefulWidget> createState() {
        return _ReviewWriteScreenWidgetState();
    }
}

class _ReviewWriteScreenWidgetState extends State<_ReviewWriteScreenWidget> {
    ReviewWriteBloc _bloc;
    TextEditingController _review = TextEditingController();
    double _rating = 0.0;
    int id = 0;

    @override
    void initState() {
        super.initState();

        id = widget.courseId;
        _bloc = BlocProvider.of<ReviewWriteBloc>(context)..add(FetchEvent(widget.courseId));
    }

    _saveForm() {
        if(this._review.text.isNotEmpty && this._rating != 0) {
            _bloc.add(SaveReviewEvent(this.id, this._rating.toInt(), this._review.text));
        }
    }

    @override
    Widget build(BuildContext context) {
        return Scaffold(
                backgroundColor: HexColor.fromHex("#F3F5F9"),
                appBar: AppBar(
                    backgroundColor: HexColor.fromHex("#273044"),
                    title: Text(
                        localizations.getLocalization("write_a_review_title"),
                        textScaleFactor: 1.0,
                        style: TextStyle(
                            fontSize: 16.0,
                            color: Colors.white
                        ),
                    )
                ),
                body: BlocListener(
                    bloc: _bloc,
                    listener: (context, state) {
                        if (state is ReviewResponseState) {
                            _review.clear();
                            _rating = 0;

                            Scaffold.of(context).showSnackBar(SnackBar(
                                content: Text(state.reviewAddResponse.message,
                                    textScaleFactor: 1.0,),
                                duration: Duration(seconds: 4),
                                action: SnackBarAction(
                                    label: localizations.getLocalization("ok_dialog_button"),
                                    onPressed: () {
                                        Navigator.of(context).pop();
                                    },
                                ),
                            ));
                        }
                    },
                    child: BlocBuilder(
                        bloc: _bloc,
                        builder: (context, state) {
                            return SingleChildScrollView(
                                child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 30.0, right: 30.0),
                                    child: Column(
                                        mainAxisAlignment: MainAxisAlignment
                                            .center,
                                        crossAxisAlignment: CrossAxisAlignment
                                            .center,
                                        mainAxisSize: MainAxisSize.max,
                                        children: <Widget>[
                                            _loadAvatar(state),
                                            Padding(
                                                padding: EdgeInsets.only(
                                                    top: 20.0, bottom: 20.0),
                                                child: Text(
                                                    widget.courseTitle,
                                                    textScaleFactor: 1.0,
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        fontSize: 20.0,
                                                        color: Colors.black,
                                                        fontWeight: FontWeight
                                                            .w600
                                                    )
                                                ),
                                            ),
                                            Padding(
                                                padding: EdgeInsets.only(
                                                    top: 20.0, bottom: 20.0),
                                                child: TextFormField(
                                                    textInputAction: TextInputAction.done,
                                                    controller: _review,
                                                    maxLines: 8,
                                                    textAlignVertical: TextAlignVertical
                                                        .top,
                                                    decoration: InputDecoration(
                                                        border: OutlineInputBorder(),
                                                        labelText:localizations.getLocalization("enter_review"),
                                                        alignLabelWithHint: true,
                                                    ),
                                                )
                                            ),
                                            Padding(
                                                padding: EdgeInsets.only(
                                                    top: 10.0),
                                                child: RatingBar(
                                                    initialRating: _rating,
                                                    minRating: 0,
                                                    direction: Axis.horizontal,
                                                    allowHalfRating: false,
                                                    itemCount: 5,
                                                    itemPadding: EdgeInsets
                                                        .symmetric(
                                                        horizontal: 2.0),
                                                    itemBuilder: (context, _) =>
                                                        Icon(
                                                            Icons.star,
                                                            color: Colors.amber,
                                                        ),
                                                    unratedColor: HexColor
                                                        .fromHex("#D7DAE2"),
                                                    onRatingUpdate: (rating) {
                                                        _rating = rating;
                                                    },
                                                )
                                            ),
                                            Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 50.0, bottom: 20.0),
                                                child: new MaterialButton(
                                                    minWidth: double.infinity,
                                                    color: mainColor,
                                                    onPressed: () {
                                                        _saveForm();
                                                    },
                                                    child: Text(
                                                        localizations.getLocalization("submit_button"),
                                                        textScaleFactor: 1.0,
                                                    ),
                                                    textColor: Colors.white,
                                                ),
                                            ),
                                        ],
                                    )
                                ),
                            );
                        }),)
            );
    }

    _buildAva(String avatarUrl) {
        return Padding(
            padding: const EdgeInsets.only(top: 20.0, bottom: 10.0),
            child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                    ClipRRect(
                        borderRadius: BorderRadius.circular(60.0),
                        child: Image.network(
                            avatarUrl,
                            fit: BoxFit.cover,
                            height: 50.0,
                            width: 50.0,
                        ),
                    )
                ]
            )
        );
    }

    _loadAvatar(ReviewWriteState state) {
        if(state is LoadedReviewWriteState) {
            return _buildAva(state.account.avatar_url);
        }

        if(state is ReviewResponseState) {
            return _buildAva(state.account.avatar_url);
        }

        return SizedBox(
            width: double.infinity,
            height: 80,
            child: Shimmer.fromColors(
                baseColor: Colors.grey[300],
                highlightColor: Colors.grey[200],
                child: Padding(
                    padding: const EdgeInsets.only(top: 20.0, bottom: 10.0),
                    child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                            ClipRRect(
                                borderRadius: BorderRadius.circular(60.0),
                                child: Container(
                                    width: 50,
                                    height: 50,
                                    decoration: BoxDecoration(color: Colors.amber),
                                )),
                        ],
                    ),
                ),
            ),
        );
    }
}