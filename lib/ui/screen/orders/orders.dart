import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:masterstudy_app/data/models/OrdersResponse.dart';
import 'package:masterstudy_app/main.dart';
import 'package:masterstudy_app/theme/theme.dart';
import 'package:masterstudy_app/ui/bloc/orders/bloc.dart';
import 'package:transparent_image/transparent_image.dart';

class OrdersScreen extends StatelessWidget {
  static const routeName = "ordersScreen";

  final OrdersBloc bloc;

  const OrdersScreen(this.bloc) : super();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => bloc,
      child: OrdersWidget(),
    );
  }
}

class OrdersWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return OrdersWidgetState();
  }
}

class OrdersWidgetState extends State<OrdersWidget> {
  OrdersBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = BlocProvider.of<OrdersBloc>(context)..add(FetchEvent());
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
              localizations.getLocalization("user_orders_title"),
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
    if (state is LoadedOrdersState)
      return ListView.builder(
          itemCount: state.orders.length,
          itemBuilder: (context, index) {
            return OrderWidget(state.orders[index], index == 0);
          });
    if (state is EmptyOrdersState) return _buildEmptyList();

    return Center(
      child: CircularProgressIndicator(),
    );
  }

  _buildEmptyList() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          SizedBox(
            width: 150,
            height: 150,
            child: SvgPicture.asset(
              "assets/icons/empty_courses.svg",
            ),
          ),
          Text(
            localizations.getLocalization("no_user_orders_screen_title"),
            textScaleFactor: 1.0,
            style: TextStyle(color: HexColor.fromHex("#D7DAE2"), fontSize: 18),
          ),
        ],
      ),
    );
  }
}

class OrderWidget extends StatefulWidget {
  final OrderBean orderBean;
  bool opened;

  OrderWidget(this.orderBean, this.opened) : super();

  @override
  State<StatefulWidget> createState() {
    return OrderWidgetState();
  }
}

class OrderWidgetState extends State<OrderWidget> {
  bool expanded = false;

  @override
  void initState() {
    super.initState();
    expanded = widget.opened;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 3,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[_buildTitle(), _buildContent()],
          ),
        ),
      ),
    );
  }

  _buildTitle() {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            "${widget.orderBean.date_formatted}  id:${widget.orderBean.id}",
            textScaleFactor: 1.0,
            style: TextStyle(fontSize: 20),
          ),
          IconButton(
            onPressed: () {
              setState(() {
                expanded = !expanded;
              });
            },
            icon: Icon(
              expanded ? Icons.arrow_drop_up : Icons.arrow_drop_down,
              color: mainColor,
            ),
          )
        ],
      ),
    );
  }

  _buildContent() {
    return Visibility(
        visible: expanded,
        child: Column(
          children: <Widget>[
            ListView.separated(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                separatorBuilder: (BuildContext context, int index) => Divider(
                      height: 3,
                      thickness: 0.5,
                      color: HexColor.fromHex("#707070"),
                    ),
                itemCount: widget.orderBean.cart_items.length,
                itemBuilder: (context, index) {
                  var item = widget.orderBean.cart_items[index];
                  return _buildCartItem(item);
                }),
            Padding(
              padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
              child: Center(
                child: Text(
                  widget.orderBean.order_key,
                  textScaleFactor: 1.0,
                  style: TextStyle(
                      color: HexColor.fromHex("#999999"), fontSize: 20),
                ),
              ),
            )
          ],
        ));
  }

  _buildCartItem(Cart_itemsBean item) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
      child: Row(
        children: <Widget>[
          Flexible(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: FadeInImage.memoryNetwork(
                  fit: BoxFit.cover,
                  width: 200,
                  height: 100,
                  placeholder: kTransparentImage,
                  image: item.image_url),
            ),
          ),
          Flexible(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Text(
                    item.title,
                    textScaleFactor: 1.0,
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                      item.price_formatted,
                      textScaleFactor: 1.0,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
