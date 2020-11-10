import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masterstudy_app/main.dart';
import 'package:masterstudy_app/theme/theme.dart';
import 'package:masterstudy_app/ui/bloc/course/course_bloc.dart';
import 'package:masterstudy_app/ui/bloc/course/course_event.dart';
import 'package:masterstudy_app/ui/bloc/course/course_state.dart';
import 'package:masterstudy_app/ui/screen/plans/plans_screen.dart';

class PurchaseDialog extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return PurchaseDialogState();
  }
}

class PurchaseDialogState extends State<PurchaseDialog> {
  CourseBloc _bloc;

  int selectedId = -1;

  @override
  void initState() {
    super.initState();
    _bloc = BlocProvider.of<CourseBloc>(context);
    selectedId = _bloc.selectedPaymetId;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: _bloc,
      builder: (context, state) {
        if (state is LoadedCourseState) return _buildPrices(state);
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  _buildPrices(LoadedCourseState state) {
    List<Widget> list = List();
    list.add(_buildDefaultItem(
        (selectedId == -1),
        localizations.getLocalization("one_time_payment"),
        "${localizations.getLocalization("course_regular_price")} ${state.courseDetailResponse.price.price}",
        state.courseDetailResponse.price.price, () {
      setState(() {
        selectedId = -1;
      });
    }));

    if (state.userPlans.isNotEmpty) {
      state.userPlans.forEach((value) {
        list.add(_buildPriceItem(
            (selectedId == int.parse(value.subscription_id)),
            localizations.getLocalization("enroll_with_membership"),
            value.name,
            value.quotas_left, () {
          setState(() {
            selectedId = int.parse(value.subscription_id);
          });
        }));
      });
    } else if (_bloc.availablePlans.isNotEmpty) {
      _bloc.availablePlans.forEach((value) {
        list.add(_buildPriceItem(
            (selectedId == int.parse(value.id)),
            "${localizations.getLocalization("available_in_plan")} \"${value.name}\"",
            value.name,
            value.quotas_left, () {
          setState(() {
            selectedId = int.parse(value.id);
          });
        }));
      });
    }
    list.add(
      Padding(
        padding: const EdgeInsets.only(top: 20.0),
        child: MaterialButton(
          minWidth: double.infinity,
          color: mainColor,
          onPressed: () {
            if (state is LoadedCourseState && state.userPlans.isNotEmpty) {
              _bloc.add(PaymentSelectedEvent(
                  selectedId, state.courseDetailResponse.id));
              Navigator.pop(
                context,
              );
            } else {
              if (selectedId != -1) {
                var future = Navigator.of(context).pushNamed(
                  PlansScreen.routeName,
                );
                future.then((value){
                  Navigator.pop(context,"update");
                });
              } else {
                _bloc.add(PaymentSelectedEvent(
                    selectedId, state.courseDetailResponse.id));
                Navigator.pop(
                  context,
                );
              }
            }
          },
          child: Text(
            localizations.getLocalization("select_payment_button"),
            textScaleFactor: 1.0,
          ),
          textColor: Colors.white,
        ),
      ),
    );

    return Padding(
      padding:
          const EdgeInsets.only(bottom: 35.0, top: 35.0, left: 16, right: 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: list,
      ),
    );
  }

  _buildDefaultItem(selected, title, subtitle, value, onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          SizedBox(
            height: 50,
            child: Stack(
              children: <Widget>[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      selected ? Icons.check_circle : Icons.panorama_fish_eye,
                      color:
                          selected ? secondColor : Colors.grey,
                      size: 40,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "$title",
                            textScaleFactor: 1.0,
                            style: TextStyle(fontSize: 18),
                          ),
                          Text(
                            "$subtitle ",
                            textScaleFactor: 1.0,
                            style: TextStyle(fontSize: 12),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                Positioned(
                  right: 0,
                  top: 0,
                  bottom: 0,
                  child: Center(
                      child: Text(
                    "$value",
                        textScaleFactor: 1.0,
                    style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: secondColor
                    ),
                  )),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  _buildPriceItem(selected, title, subtitle, value, onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          SizedBox(
            height: 50,
            child: Stack(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Icon(
                      selected ? Icons.check_circle : Icons.panorama_fish_eye,
                      color:
                          selected ? secondColor : Colors.grey,
                      size: 40,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Text(
                            "$title",
                            textScaleFactor: 1.0,
                            style: TextStyle(fontSize: 18),
                          ),
                          Text(
                            "$subtitle ",
                            textScaleFactor: 1.0,
                            style: TextStyle(fontSize: 12),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                Visibility(
                  visible: value != null,
                  child: Positioned(
                    right: 0,
                    top: 0,
                    bottom: 0,
                    child: Center(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Text(
                          "$value",
                          textScaleFactor: 1.0,
                          style: TextStyle(
                              fontSize: 26,
                              fontWeight: FontWeight.bold,
                              color: secondColor
                          ),
                        ),
                        Text(
                          localizations.getLocalization("plan_count_left"),
                          textScaleFactor: 1.0,
                          style: TextStyle(
                              fontSize: 9, color: secondColor
                          ),
                        )
                      ],
                    )),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  _buildMembershipItem(selected, title, subtitle) {}
}
