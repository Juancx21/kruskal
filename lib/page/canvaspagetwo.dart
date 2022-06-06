import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kruskal/controllers/kruskalroute.dart';
import 'package:kruskal/helpers/drawline.dart';
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
  late int name;
  late bool showMenuBar;

  final kruskalRoute = Get.put(KruskalRoute());

  @override
  void initState() {
    super.initState();
    showMenuBar = true;
    name = 96;
  }

  @override
  void dispose() {
    super.dispose();
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
            GestureDetector(
              onDoubleTap: () {},
              onDoubleTapDown: (TapDownDetails details) =>
                  kruskalRoute.addNode(details),
              child: Container(
                width: size.width,
                height: size.height,
                color: UiColors.cUiBackground(false),
                child: Obx(
                  () => Stack(children: [
                    ...kruskalRoute.aristcs.map((e) {
                      return CustomPaint(
                        size: Size.infinite,
                        painter: Drawline(
                          aristc: e,
                        ),
                      );
                    }).toList(),
                    ...kruskalRoute.nodes
                        .map((e) => Transform.translate(
                              offset: e.offset,
                              child: GestureDetector(
                                onTap: () => setState(() {
                                  // nodes.remove(e);
                                  if (kruskalRoute.boolDelete.value) {
                                    debugPrint("SE PUEDE ELIMINAR");
                                  }
                                }),
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
                                          color: kruskalRoute.nodeColor.value,
                                          borderRadius:
                                              BorderRadius.circular(25)),
                                      child: Center(
                                        child: Text(
                                          e.name,
                                          style: UiFonts.txtSubtitle1(
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
                  },
                ))
          ],
        ),
      ),
    );
  }
}
