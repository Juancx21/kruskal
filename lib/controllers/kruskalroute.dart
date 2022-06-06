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

  RxBool boolDelete = false.obs;

  Rx<Color> nodeColor = const Color(0xFF7B61FF).obs;

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

  void optionDelete(bool active){
    boolDelete.value = active;
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

  void kruskalAlgorithm() {
    List<dynamic> result = [];
    List<NodeKruskal> parent = [];
    parent.addAll(nodes);
    aristcs.sort(((a, b) => a.weight.compareTo(b.weight)));
    if (aristcs.isEmpty) {
      return;
    }

    // for (var item in aristcs) {
    //   debugPrint(item.origin.name + "-------${item.weight}-------" + item.destiny.name);
    // }
    // debugPrint("-----***************************************");
    List<Aristc> quemado = [];
    quemado.addAll(aristcs);
    for (var i = 0; i < nodes.length - 1; i++) {
      // NodeKruskal origin = aristcs[i].origin;
      // NodeKruskal destiny = aristcs[i].destiny;
      // int weight = aristcs[i].weight;
      
      List<Aristc> buscarArista = quemado.where((a) => a.origin == parent[i]).toList();
      // for (var item in buscarArista) {
      //   debugPrint(item.origin.name + " " + item.destiny.name);
      // }
      List<NodeKruskal> nodosDestino = buscarArista.map((e) => e.destiny).toList();
      // debugPrint(buscarArista.length.toString());
      if (buscarArista.length < 2) {
        continue;
      }
      for (var ia in buscarArista) {
        print(ia.origin.name + " " + ia.weight.toString() + " " +ia.destiny.name);
      }
      print("----------------------");
      nodosDestino.sort((a,b)=> a.name.codeUnitAt(0).compareTo(b.name.codeUnitAt(0)));
      
      for (var j = 0; j < nodosDestino.length; j++) {
        for (var k = j+1; k < nodosDestino.length; k++) {
          final searchAristc = quemado.where((element) => element.origin == nodosDestino[j] && element.destiny == nodosDestino[k],).toList();
          if (searchAristc.isNotEmpty) {
            buscarArista.add(searchAristc.first);
            buscarArista.sort(((a, b) => a.weight.compareTo(b.weight)));
            quemado.removeWhere((element) => element == buscarArista.last);
          }
          // quemado.removeWhere((element) => element == Aristc(origin: nodosDestino[j], destiny: nodosDestino[k], weight: weight),)
          // print(nodosDestino[j].name + "------" + nodosDestino[k].name);
          // print(searchAristc.origin.name + "------" + searchAristc.destiny.name);
        }
      }
      // for (var item in aristastest) {
      //   debugPrint(item.origin.name + "-------${item.weight}-------" + item.destiny.name);
      // }
      // debugPrint("*****");
      // aristcs[i].active = true;
      // aristcs.refresh();

    }
    quemado.length = nodes.length - 1;
    for (var i = 0; i < aristcs.length; i++) {
      final request = quemado.where((element) => element == aristcs[i]); 
      if (request.isNotEmpty) {
        aristcs[i].active = true;
      }else{
        aristcs[i].active = false;
      }
    }
    // int e= 0;
    // int i = 0;

    // while (e < nodes.length -1){
    //   e++;
    // } 

    // for (var item in aristcs) {
    //   debugPrint(item.origin.name + "-------${item.weight}-------" + item.destiny.name);
    // }
  }

  // NodeKruskal find(List<NodeKruskal> parent, NodeKruskal node , int i){
  //   if (parent[i] == node) {
  //     return parent[i];
  //   }
  //   return find(parent, node, i);
  // }
}
