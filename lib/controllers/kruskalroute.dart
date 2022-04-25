import 'package:get/get.dart';

import 'package:flutter/material.dart';

import 'package:kruskal/domain/entities/aristc.dart';
import 'package:kruskal/domain/entities/node.dart';
import 'package:kruskal/shared/utils/others/enums.dart';
import 'package:kruskal/shared/utils/styles/uicolors.dart';
import 'package:kruskal/shared/utils/styles/uifonts.dart';

class KruskalRoute extends GetxController {
  RxList<Aristc> aristcs = <Aristc>[].obs;
  RxList<NodeKruskal> nodes = <NodeKruskal>[].obs;

  RxString msgError = "".obs;
  Rx<Status> error = Status.notStatus.obs;

  RxBool boolAddNote = false.obs;
  RxBool boolDelete = false.obs;

  int point = 0;
  int nameASCII = 65;

  List<DropdownMenuItem<NodeKruskal>> getNodes() {
    if (nodes.isNotEmpty) {
      return nodes
          .map((node) => DropdownMenuItem(
                value: node,
                child: Text(
                  node.name,
                  style: UiFonts.txtbody1(UiColors.outline1Color(false)),
                ),
              ))
          .toList();
    } else {
      return [const DropdownMenuItem(child: SizedBox())];
    }
  }

  void addNode(TapDownDetails details) {
    if (nameASCII <= 90) {
      Offset offset = details.globalPosition;
      nodes.add(NodeKruskal(
        name: String.fromCharCode(point == 0 ? nameASCII : point).toUpperCase(),
        offset: Offset(offset.dx - 25, offset.dy - 25),
      ));
      point = 0;
      nameASCII++;
    }
  }

  void deleteNode(NodeKruskal node) {
    point = int.parse(node.name);
    nodes.remove(node);
  }

  void addAristc(NodeKruskal? origin, NodeKruskal? destiny, String text) {
    if (origin != null && destiny != null) {
      bool mayor = origin.name.codeUnitAt(0) > destiny.name.codeUnitAt(0);
      NodeKruskal nodeOrigin = mayor ? destiny : origin;
      NodeKruskal nodeDestiny = mayor ? origin : destiny;
      Aristc aristc = Aristc(
          origin: nodeOrigin, destiny: nodeDestiny, weight: int.parse(text));
      if (aristcs.isNotEmpty) {
        for (var i in aristcs) {
          if (i.destiny == aristc.destiny && i.origin == aristc.origin) {
            error.value = Status.error;
            msgError.value = "Ya hay una arista igual";
            return;
          }
        }
      }
      aristcs.add(aristc);
    } else {
      error.value = Status.error;
      msgError.value = "Se debe crear al menos 2 nodos";
    }
  }
}
