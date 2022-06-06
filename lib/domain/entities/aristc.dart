import 'package:kruskal/domain/entities/node.dart';

class Aristc {
  NodeKruskal origin;
  NodeKruskal destiny;
  int weight;
  bool active;

  Aristc({required this.origin, required this.destiny, required this.weight, this.active = false});
}
