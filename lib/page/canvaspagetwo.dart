import 'package:flutter/material.dart';
import 'package:kruskal/domain/entities/aristc.dart';
import 'package:kruskal/domain/entities/node.dart';
import 'package:kruskal/helpers/drawline.dart';
import 'package:kruskal/shared/utils/others/enums.dart';
import 'package:kruskal/shared/utils/styles/uicolors.dart';
import 'package:kruskal/shared/utils/styles/uifonts.dart';
import 'package:kruskal/shared/widgets/buttons/simple_button.dart';
import 'package:kruskal/shared/widgets/lateral_bar/lateralbarwidget.dart';

class CanvasPageTwo extends StatefulWidget {
  const CanvasPageTwo({Key? key}) : super(key: key);

  @override
  State<CanvasPageTwo> createState() => _CanvasPageTwoState();
}

class _CanvasPageTwoState extends State<CanvasPageTwo>
    with SingleTickerProviderStateMixin {
  late bool showMenuBar;
  late AnimationController animationController;
  late Animation<double> animation;
  late int name;
  late List<Node> nodes;
  late List<Aristc> aristcs;
  late addAction add;
  late deleteAction delete;

  @override
  void initState() {
    super.initState();
    showMenuBar = true;
    name = 96;
    nodes = [];
    aristcs = [];
    add = addAction.actived;
    delete = deleteAction.notactivate;
    animationController = AnimationController(
        duration: const Duration(milliseconds: 300), vsync: this);
    animation =
        Tween<double>(begin: 368, end: 0.0).animate(animationController);
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

  void removeNode(Node e) {
    setState(() {
      nodes.remove(e);
    });
    for (var item in aristcs) {
      if (e == item.origin || e == item.destiny) {
        removeArch(item);
      }
    }
  }

  void removeArch(Aristc a) {
    setState(() {
      aristcs.remove(a);
    });
  }

  @override
  void dispose() {
    super.dispose();
    animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: UiColors.cUiBackground(false),
      body: SizedBox(
        width: size.width,
        child: Stack(
          children: [
            AnimatedBuilder(
              animation: animationController,
              builder: (context, child) => GestureDetector(
                onTapDown: (TapDownDetails details) =>
                    add == addAction.actived ? addNode(details, context) : null,
                child: Container(
                  width: size.width - animation.value,
                  height: size.height,
                  color: UiColors.cUiBackground(false),
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
                                onTap: () => delete == deleteAction.actived
                                    ? setState(() {
                                        nodes.remove(e);
                                      })
                                    : null,
                                onPanUpdate: (DragUpdateDetails details) {
                                  setState(() {
                                    e.offset += details.delta;
                                  });
                                },
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(25),
                                  child: Container(
                                      height: 50,
                                      width: 50,
                                      decoration: BoxDecoration(
                                          color: Colors.blue,
                                          borderRadius:
                                              BorderRadius.circular(25)),
                                      child: Center(
                                        child: Text(
                                          e.name,
                                          style: UiFonts.txtCaption1(
                                              UiColors.white),
                                        ),
                                      )),
                                ),
                              ),
                            ))
                        .toList(),
                  ]),
                ),
              ),
            ),
            LateralBarWidget(
              showlateralbar: showMenuBar,
              nodes: nodes,
              archs: aristcs,
              arch: (value) => setState(() {
                aristcs.add(value);
              }),
              statusAdd: (val) => setState(() {
                add = val;
                print(val);
              }),
              statusDelete: (val) => setState(() {
                delete = val;
                print(val);
              }),
            ),
            Positioned(
                top: 32,
                right: 24,
                child: SimpleButton(
                  text: showMenuBar ? "Close" : "Open",
                  icon: showMenuBar ? "cross" : "menu-burger",
                  bold: true,
                  bgcolor: UiColors.white,
                  textColor: UiColors.outline2Color(false),
                  ontap: () {
                    setState(() {
                      showMenuBar = !showMenuBar;
                    });
                    if (showMenuBar == false) {
                      animationController.forward();
                    } else {
                      animationController.reverse();
                    }
                  },
                ))
          ],
        ),
      ),
    );
  }
}
