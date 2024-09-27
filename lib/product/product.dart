import 'package:api_services/modal/product_modal.dart';
import 'package:api_services/providers/data_provider.dart';
import 'package:flutter/material.dart';

class ProductWidgetData extends StatefulWidget {
  const ProductWidgetData({super.key});

  @override
  State<ProductWidgetData> createState() => _ProductWidgetDataState();
}

class _ProductWidgetDataState extends State<ProductWidgetData> {
  // https://api.escuelajs.co/api/v1/products
  final data = Productdataa();
  List<Productdata> productlist = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      productlist = await data.getData();
      print("list of data $productlist");
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
            child: InkWell(
          child: const Text("getdata"),
          onTap: () async {},
        )),
      ),
    );
  }
}
