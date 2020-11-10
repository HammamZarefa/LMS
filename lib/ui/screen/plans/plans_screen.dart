import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:masterstudy_app/data/models/purchase/UserPlansResponse.dart';
import 'package:masterstudy_app/main.dart';
import 'package:masterstudy_app/theme/theme.dart';
import 'package:masterstudy_app/ui/bloc/plans/bloc.dart';
import 'package:masterstudy_app/ui/screen/web_checkout/web_checkout_screen.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class PlansScreen extends StatelessWidget {
  static const routeName = "plansScreen";
  final PlansBloc bloc;

  const PlansScreen(this.bloc) : super();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (context) => bloc, child: PlansScreenWidget());
  }
}

class PlansScreenWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return PlansScreenWidgetState();
  }
}

class PlansScreenWidgetState extends State<PlansScreenWidget> {
  PlansBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = BlocProvider.of<PlansBloc>(context)..add(FetchEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: _bloc,
      builder: (context, state) {
        return Scaffold(
          backgroundColor: HexColor.fromHex("#F3F5F9"),
          appBar: AppBar(
            centerTitle: true,
            title: Text(
              localizations.getLocalization("membership_plans"),
              textScaleFactor: 1.0,
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          ),
          body: _buildBody(state),
        );
      },
    );
  }

  _buildBody(state) {
    if (state is LoadedPlansState) return _buildList(state.plans);
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  _buildList(List<UserPlansBean> plans) {
    return ListView.builder(
        itemCount: plans.length,
        itemBuilder: (context, index) {
          var item = plans[index];
          return PlanWidget(item,onTap: (){
            _openCheckoutScreen(item);
          },);
        });
  }

  _openCheckoutScreen(UserPlansBean plansBean){
    var future =  Navigator.pushNamed(
      context,
      WebCheckoutScreen.routeName,
      arguments:
      WebCheckoutScreenArgs(plansBean.button.url),
    );
    future.then((value){
      Navigator.pop(context);
    });
  }
}

class PlanWidget extends StatelessWidget {
  final UserPlansBean plansBean;
  final VoidCallback onTap;

  const PlanWidget(this.plansBean,{@required this.onTap}) : super();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 220,
        child: Card(
          elevation: 3,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Flexible(
                  flex: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text(
                        plansBean.name,
                        textScaleFactor: 1.0,
                        style: TextStyle(
                            fontSize: 20,
                            color: HexColor.fromHex("2A3045").withOpacity(0.8)),
                      ),
                      Text(
                        "\$" + plansBean.initial_payment.toString(),
                        textScaleFactor: 1.0,
                        style: TextStyle(
                          fontSize: 40,
                        ),
                      ),
                      Visibility(
                          visible: plansBean.billing_amount != 0,
                          child: Text(
                            "\$" +
                                plansBean.billing_amount.toString() +
                                " ${localizations.getLocalization("plan_per_month")}",
                            textScaleFactor: 1.0,
                            style: TextStyle(
                                color: HexColor.fromHex("2A3045")
                                    .withOpacity(0.8)),
                          )),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: SizedBox(
                          width: 120,
                          child: MaterialButton(
                            minWidth: double.infinity,
                            color: secondColor,
                            onPressed: onTap,
                            child: Text(plansBean.button?.text ?? "GET NOW",
                              textScaleFactor: 1.0,),
                            textColor: Colors.white,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Flexible(
                  child: _buildWebView(plansBean.features),
                  flex: 1,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  _buildWebView(String description) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Html(
          data: description,

        ),
      ],
    );
    return WebView(
      javascriptMode: JavascriptMode.unrestricted,
      initialUrl:
          'data:text/html;base64,${base64Encode(const Utf8Encoder().convert(description))}',
      onPageFinished: (some) async {},
      onWebViewCreated: (controller) async {
        controller.clearCache();
      },
    );
  }
}
