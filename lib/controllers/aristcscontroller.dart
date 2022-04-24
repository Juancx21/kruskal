import 'package:get/get.dart';
import 'package:kruskal/domain/entities/aristc.dart';
import 'package:kruskal/domain/entities/node.dart';

class AristcsController extends GetxController {
  RxList<Aristc> aristcs = <Aristc>[].obs;
  RxMap response = {"msg": null, "error": false}.obs;

  void add(NodeKruskal? origin, NodeKruskal? destiny, String text) {
    if (origin != null && destiny != null) {
      bool mayor = origin.name.codeUnitAt(0) > destiny.name.codeUnitAt(0);
      NodeKruskal nodeOrigin = mayor ? destiny : origin;
      NodeKruskal nodeDestiny = mayor ? origin : destiny;
      Aristc aristc = Aristc(
          origin: nodeOrigin, destiny: nodeDestiny, weight: int.parse(text));
      if (aristcs.isNotEmpty) {
        for (var i in aristcs) {
          if (i.destiny == aristc.destiny && i.origin == aristc.origin) {
            response["error"] = true;
            response["msg"] = "Ya hay una arista entre los nodos";
            return;
          }
        }
      }
      aristcs.add(aristc);
    }
  }

  void delete() {}
}
