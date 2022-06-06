import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:kruskal/controllers/kruskalroute.dart';
import 'package:kruskal/domain/entities/node.dart';
import 'package:kruskal/shared/utils/others/globalvariables.dart';
import 'package:kruskal/shared/utils/styles/uicolors.dart';
import 'package:kruskal/shared/utils/styles/uifonts.dart';
import 'package:kruskal/shared/utils/styles/uispacing.dart';
import 'package:kruskal/shared/widgets/buttons/color_button.dart';
import 'package:kruskal/shared/widgets/buttons/simple_button.dart';
import 'package:kruskal/shared/widgets/buttons/swtich_button.dart';
import 'package:kruskal/shared/widgets/lateral_bar/customdropdown.dart';
import 'package:kruskal/shared/widgets/lateral_bar/footer.dart';
import 'package:kruskal/shared/widgets/lateral_bar/titlewidget.dart';

class LateralBarWidget extends StatefulWidget {
  final bool showlateralbar;

  const LateralBarWidget({
    Key? key,
    this.showlateralbar = true,
  }) : super(key: key);

  @override
  State<LateralBarWidget> createState() => _LateralBarWidgetState();
}

class _LateralBarWidgetState extends State<LateralBarWidget>
    with SingleTickerProviderStateMixin {
  late List<NodeKruskal> nodes;
  late GlobalKey<FormState> key;
  late TextEditingController controller;
  late AnimationController animationController;
  late Animation<double> animation;

  NodeKruskal? origin;
  NodeKruskal? destiny;

  final kruskalRoute = Get.find<KruskalRoute>();

  @override
  void initState() {
    super.initState();

    key = GlobalKey<FormState>();
    controller = TextEditingController();
    animationController = AnimationController(
        duration: const Duration(milliseconds: 300), vsync: this);
    animation =
        Tween<double>(begin: 0.0, end: 368).animate(animationController);
  }

  @override
  void didUpdateWidget(covariant LateralBarWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.showlateralbar == false) {
      animationController.forward();
    } else {
      animationController.reverse();
    }
  }

  @override
  void dispose() {
    super.dispose();
    animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    OutlineInputBorder outline = OutlineInputBorder(
      borderSide: BorderSide(color: UiColors.container2Color(false)),
      borderRadius: BorderRadius.circular(6),
    );

    OutlineInputBorder outlineError = OutlineInputBorder(
      borderSide: BorderSide(color: UiColors.container2Color(false)),
      borderRadius: BorderRadius.circular(6),
    );

    return AnimatedBuilder(
      animation: animationController,
      builder: (context, child) => Positioned(
        top: 24,
        right: 24 - animation.value,
        child: Container(
          width: 320,
          height: size.height - 48,
          decoration: BoxDecoration(
              color: UiColors.white, borderRadius: BorderRadius.circular(12)),
          child: Column(
            children: [
              const SizedBox(
                height: 76,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height - 156,
                child: SingleChildScrollView(
                  padding: UiSpacing.xMacrosmall(),
                  child: Column(
                    children: [
                      const TitleWidget(
                        type: "subtitle",
                        text: "Arch",
                      ),
                      Obx(() {
                        return Row(
                          children: [
                            CustomDropDown(
                              dropdown: DropdownButton<NodeKruskal>(
                                value: origin,
                                icon: SvgPicture.asset(
                                  "${iconpath}angle-down.svg",
                                  width: 16,
                                ),
                                items: kruskalRoute.getNodes(),
                                onChanged: (val) {
                                  if (val != null) {
                                    setState(() {
                                      origin = val;
                                    });
                                  }
                                },
                              ),
                            ),
                            Container(
                              margin: UiSpacing.xMicrolarge(),
                              child: Text(
                                "CONNECT TO",
                                style: UiFonts.txtCaption2(
                                    UiColors.outline2Color(false)),
                              ),
                            ),
                            CustomDropDown(
                              dropdown: DropdownButton<NodeKruskal>(
                                value: destiny,
                                icon: SvgPicture.asset(
                                  "${iconpath}angle-down.svg",
                                  width: 16,
                                ),
                                items: kruskalRoute.getNodes(),
                                onChanged: (NodeKruskal? e) => setState(() {
                                  destiny = e;
                                }),
                              ),
                            ),
                          ],
                        );
                      }),
                      Container(
                        margin: UiSpacing.yMicrolarge(),
                        child: Form(
                            key: key,
                            child: TextFormField(
                              controller: controller,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Empty field";
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: UiColors.white,
                                hoverColor: UiColors.white,
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 0,
                                    horizontal: UiSpacing.microSpaceMedium),
                                focusedBorder: outline,
                                enabledBorder: outline,
                                errorBorder: outlineError,
                                focusedErrorBorder: outlineError,
                                border: outline,
                                labelText: "Weight",
                                labelStyle: UiFonts.txtSubtitle2(
                                    UiColors.outline2Color(false)),
                                counter: const Offstage(),
                              ),
                            )),
                      ),
                      Container(
                        margin: UiSpacing.bottomMacronormal(),
                        child: SimpleButton(
                          text: "Add",
                          icon: "plus",
                          ontap: () {
                            if (key.currentState!.validate()) {
                              kruskalRoute.addAristc(
                                  origin, destiny, controller.text);
                            }
                          },
                        ),
                      ),
                      const TitleWidget(
                        type: "subtitle",
                        text: "General",
                      ),
                      Container(
                        margin: UiSpacing.bottomMacrosmall(),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Delete",
                              style: UiFonts.txtSubtitle2(
                                  UiColors.outline2Color(false)),
                            ),
                            SwitchButton(
                              state: (value) =>
                                  kruskalRoute.boolDelete.value = value,
                              height: 16,
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: UiSpacing.bottomMacrosmall(),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Font size",
                              style: UiFonts.txtSubtitle2(
                                  UiColors.outline2Color(false)),
                            ),
                            Row(
                              children: [
                                GestureDetector(
                                  onTap: () => debugPrint("hola"),
                                  child: Container(
                                    height: 24,
                                    width: 24,
                                    margin: UiSpacing.leftMicromedium(),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      color: UiColors.container2Color(false),
                                    ),
                                    alignment: Alignment.center,
                                    child: const Text(
                                      "+",
                                      style: TextStyle(
                                        height: 1,
                                        fontSize: 24,
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                    margin: UiSpacing.leftMicromedium(),
                                    child: Text("1")),
                                GestureDetector(
                                  onTap: () => debugPrint("hola"),
                                  child: Container(
                                    height: 24,
                                    width: 24,
                                    margin: UiSpacing.leftMicromedium(),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      color: UiColors.container2Color(false),
                                    ),
                                    alignment: Alignment.center,
                                    child: const Text(
                                      "-",
                                      style: TextStyle(
                                        height: 1,
                                        fontSize: 24,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      Container(
                        margin: UiSpacing.bottomMacrosmall(),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Node color",
                              style: UiFonts.txtSubtitle2(
                                  UiColors.outline2Color(false)),
                            ),
                            Row(
                              children: [
                                Row(
                                  children: [
                                    ColorButton(
                                        function: (value) => kruskalRoute
                                            .nodeColor.value = value,
                                        color: "red"),
                                    ColorButton(
                                        function: (value) => kruskalRoute
                                            .nodeColor.value = value,
                                        color: "green"),
                                    ColorButton(
                                        function: (value) => kruskalRoute
                                            .nodeColor.value = value,
                                        color: "purple"),
                                    ColorButton(
                                        function: (value) => kruskalRoute
                                            .nodeColor.value = value,
                                        color: "blue"),
                                  ],
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      Container(
                        margin: UiSpacing.bottomMacrosmall(),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Aristc color",
                              style: UiFonts.txtSubtitle2(
                                  UiColors.outline2Color(false)),
                            ),
                            Row(
                              children: [
                                ColorButton(
                                    function: (value) =>
                                        kruskalRoute.nodeColor.value = value,
                                    color: "red"),
                                ColorButton(
                                    function: (value) =>
                                        kruskalRoute.nodeColor.value = value,
                                    color: "green"),
                                ColorButton(
                                    function: (value) =>
                                        kruskalRoute.nodeColor.value = value,
                                    color: "purple"),
                                ColorButton(
                                    function: (value) =>
                                        kruskalRoute.nodeColor.value = value,
                                    color: "blue"),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: UiSpacing.bottomMacronormal(),
                        child: SimpleButton(
                          text: "Execute kruskal",
                          icon: "rocket-lunch",
                          ontap: () {
                            if (key.currentState!.validate()) {
                              kruskalRoute.kruskalAlgorithm();
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const FooterWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
