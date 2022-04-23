import 'package:flutter/material.dart';
import 'package:kruskal/domain/entities/aristc.dart';
import 'package:kruskal/domain/entities/node.dart';
import 'package:kruskal/helpers/drawline.dart';
import 'package:kruskal/page/addaristcpage.dart';
import 'package:kruskal/shared/utils/styles/uicolors.dart';
import 'package:kruskal/shared/utils/styles/uifonts.dart';
import 'package:kruskal/shared/widgets/custom_snackbar.dart';

enum Status {
  nothing,
  routing,
  finished,
}

class CanvasPage extends StatefulWidget {
  const CanvasPage({Key? key}) : super(key: key);

  @override
  State<CanvasPage> createState() => _CanvasPageState();
}

class _CanvasPageState extends State<CanvasPage> {
  late int name;
  late List<Node> nodes;
  late List<Aristc> aristcs;
  late Status status;
  Node? firstNode;

  @override
  void initState() {
    super.initState();
    nodes = [];
    aristcs = [];
    name = 96;
    status = Status.nothing;
  }

  void addNode(TapDownDetails details, BuildContext context) {
    if (name <= 122) {
      name = name + 1;
    }
    final RenderBox box = context.findRenderObject() as RenderBox;
    final Offset offset = box.globalToLocal(details.globalPosition);
    setState(() {
      nodes.add(Node(
        name: String.fromCharCode(name).toUpperCase(),
        offset: Offset(offset.dx - 25, offset.dy - 25),
      ));
    });
    debugPrint("${nodes.length}");
  }

  void addAristc(BuildContext context) async {
    if (nodes.length >= 2) {
      final response = await Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => AddAristcPage(
                    nodes: nodes,
                    aristcs: aristcs,
                  )));
      if (response != null) {
        setState(() {
          aristcs.add(response);
        });
        print(aristcs);
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(CustomSnackBar.errorSnackBar(
          text: "No cuenta los los nodos suficientes..."));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTapDown: (TapDownDetails details) => addNode(details, context),
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: Colors.white,
          child: Stack(children: [
            ...aristcs
                .map((e) => CustomPaint(
                      size: Size.infinite,
                      painter: Drawline(aristc: e),
                      child: Text(e.weight.toString()),
                    ))
                .toList(),
            ...nodes
                .map((e) => Transform.translate(
                      offset: e.offset,
                      child: GestureDetector(
                        onTap: () {},
                        onPanUpdate: (DragUpdateDetails details) {
                          setState(() {
                            e.offset += details.delta;
                          });
                        },
                        child: Container(
                            height: 50,
                            width: 50,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.circular(25)),
                            child: Text(
                              e.name,
                              style: UiFonts.txtCaption1(UiColors.white),
                            )),
                      ),
                    ))
                .toList(),
          ]),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => addAristc(context),
        tooltip: "Añadir arista",
        child: const Icon(Icons.add),
      ),
    );
  }
}
