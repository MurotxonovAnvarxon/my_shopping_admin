import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_shopping_admin/items/shopping_cart.dart';

import '../items/item.dart';


class CartListWidget extends StatefulWidget {
  final ShoppingCart cart;

  CartListWidget({required this.cart});

  @override
  State<StatefulWidget> createState() {
    return _CartListWidgetState();
  }
}

class _CartListWidgetState extends State<CartListWidget> {
  static const platform = const MethodChannel('alfianlosari.com/payment');

  Future<void> _checkout() async {
    await platform.invokeMethod('charge', widget.cart.toMap);
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> items = [];

    widget.cart.items.forEach((c) {
      items.add(_CartListItemWidget(
        item: c,
      ));
      items.add(Padding(
        padding: EdgeInsets.only(top: 8.0),
      ));
    });

    return Scaffold(
        appBar: AppBar(
          title: Text('My Cart'),
          actions: <Widget>[
            InkWell(
              onTap: () => this._checkout(),
              child: Container(
                child: Text(
                  "Checkout",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            )
          ],
        ),
        body: Container(
            decoration: BoxDecoration(color: Color(0xfff0eff4)),
            child: Stack(
              children: <Widget>[
                ListView(
                  padding: EdgeInsets.only(bottom: 64),
                  children: items,
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  height: 104,
                  child: _CartListSummaryFooterWidget(
                    totalPrice: widget.cart.formattedTotalPrice,
                  ),
                )
              ],
            )));
  }
}

class _CartListSummaryFooterWidget extends StatefulWidget {
  final String totalPrice;

  _CartListSummaryFooterWidget({required this.totalPrice});

  @override
  State<_CartListSummaryFooterWidget> createState() =>
      _CartListSummaryFooterWidgetState();
}

class _CartListSummaryFooterWidgetState
    extends State<_CartListSummaryFooterWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
            color: Color(0XFFF4F4F4),
            border: Border(top: BorderSide(color: Colors.grey, width: 0.5))),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
              child: Row(
            children: <Widget>[
              const Text(
                'Total sum',
                textAlign: TextAlign.left,
                style: TextStyle(color: Colors.red),
              ),
              Spacer(),
              Text(
                this.widget.totalPrice,
                textAlign: TextAlign.right,
              ),
              Spacer(),
              FloatingActionButton(
                onPressed: () {},
                child: Text("send"),
              ),
              // Spacer()
            ],
          )),
        ));
  }
}

class _CartListItemWidget extends StatefulWidget {
  final Item item;

  _CartListItemWidget({required this.item});

  @override
  State<_CartListItemWidget> createState() => _CartListItemWidgetState();
}

class _CartListItemWidgetState extends State<_CartListItemWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(10)),
          // border: Border(
          //   left: BorderSide(width: 0.5),
          //     right: BorderSide(width: 0.5),
          //     top: BorderSide(color: Colors.grey, width: 0.5),
          //     bottom: BorderSide(color: Colors.grey, width: 0.5))
        ),
        padding: EdgeInsets.all(16.0),
        child: Row(
          children: <Widget>[
            Container(
              height: 64,
              child: AspectRatio(
                aspectRatio: 1,
                child: Image.network(widget.item.imageUrl),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(right: 8.0),
            ),
            Expanded(
                child: Text(
              widget.item.name,
            )),
            Padding(
              padding: EdgeInsets.only(right: 8.0),
            ),
            Text(
              widget.item.formattedPrice,
              textAlign: TextAlign.right,
            )
          ],
        ),
      ),
    );
  }
}
