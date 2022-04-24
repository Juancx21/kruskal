import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kruskal/domain/entities/node.dart';

class NodesController extends GetxController {
  RxList<NodeKruskal> nodes = <NodeKruskal>[].obs;

  int point = 0;
  int nameASCII = 65;

  void add(TapDownDetails details){
    if (nameASCII <= 90) {
      Offset offset = details.globalPosition;
      nodes.add(NodeKruskal(name: String.fromCharCode(point == 0 ? nameASCII : point).toUpperCase(),
        offset: Offset(offset.dx - 25, offset.dy - 25),));
      point = 0;
      nameASCII++;
    }
  }

  void delete(NodeKruskal node){
    point = int.parse(node.name);
    nodes.remove(node);
  }
}