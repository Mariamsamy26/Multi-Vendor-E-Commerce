import 'package:flutter/material.dart';
import 'package:multi_vendor_e_commerce/dammy/data/date_dammy.dart';
import 'package:multi_vendor_e_commerce/dammy/models/SellerModel.dart';


class SellersList {
  SellersList._();

  static List<SellerModel> get sellers {
    final vendors =
        DummyData.products.map((e) => e.vendor).toSet().toList();

    return List.generate(
      vendors.length,
      (index) => SellerModel(
        name: vendors[index],
        imageIndex: '${index + 1}',
        color: index.isEven
            ? Colors.grey.shade300
            : Colors.grey.shade400,
      ),
    );
  }
}