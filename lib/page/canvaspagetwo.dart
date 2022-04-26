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
  late bool showMenuBar;
  late AnimationController animationController;
  late Animation<double> animation;
  late int name;

  final kruskalRoute = Get.put(KruskalRoute());

  @override
  void initState() {
    super.initState();
    showMenuBar = true;
    name = 96;

    animationController = AnimationController(
        duration: const Duration(milliseconds: 300), vsync: this);
    animation =
        Tween<double>(begin: 368, end: 0.0).animate(animationController);
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
            GestureDetector(
              onDoubleTap: () {},
              onDoubleTapDown: (TapDownDetails details) =>
                  kruskalRoute.addNode(details),
              child: Container(
                width: size.width - animation.value,
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
