import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:kruskal/controllers/aristcscontroller.dart';
import 'package:kruskal/controllers/nodescontroller.dart';
import 'package:kruskal/domain/entities/aristc.dart';
import 'package:kruskal/domain/entities/node.dart';
import 'package:kruskal/shared/utils/others/enums.dart';
import 'package:kruskal/shared/utils/others/globalvariables.dart';
import 'package:kruskal/shared/utils/styles/uicolors.dart';
import 'package:kruskal/shared/utils/styles/uifonts.dart';
import 'package:kruskal/shared/utils/styles/uispacing.dart';
import 'package:kruskal/shared/widgets/buttons/simple_button.dart';
import 'package:kruskal/shared/widgets/custom_snackbar.dart';
import 'package:kruskal/shared/widgets/lateral_bar/customdropdown.dart';
import 'package:kruskal/shared/widgets/lateral_bar/titlewidget.dart';

class LateralBarWidget extends StatefulWidget {
  final bool showlateralbar;
  final List<NodeKruskal> nodes;
  final List<Aristc> archs;
  final ValueChanged<Aristc>? arch;
  final ValueChanged<addAction>? statusAdd;
  final ValueChanged<deleteAction>? statusDelete;

  const LateralBarWidget(
      {Key? key,
      this.showlateralbar = true,
      this.statusAdd,
      this.statusDelete,
      required this.nodes,
      required this.archs,
      this.arch})
      : super(key: key);

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

  late addAction activateAdd;
  late deleteAction activateDelete;

  NodeKruskal? origin;
  NodeKruskal? destiny;

  final nodeController = Get.put(NodesController());
  final aristController = Get.put(AristcsController());
  @override
  void initState() {
    super.initState();
    nodes = widget.nodes;
    // origin = nodes.isNotEmpty ? nodes[0] : null;
    // destiny = nodes.isNotEmpty
    //     ? nodes.length >= 2
    //         ? nodes[1]
    //         : nodes[0]
    //     : null;
    key = GlobalKey<FormState>();
    controller = TextEditingController();
    animationController = AnimationController(
        duration: const Duration(milliseconds: 300), vsync: this);
    animation =
        Tween<double>(begin: 0.0, end: 368).animate(animationController);

    activateAdd = addAction.actived;
    activateDelete = deleteAction.notactivate;
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

    TextStyle styleItemRadio = TextStyle(
      color: UiColors.outline2Color(false),
      fontSize: 12,
      fontFamily: 'Inter',
      fontWeight: FontWeight.w700,
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
          child: Column(children: [
            const SizedBox(
              height: 64,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height - 112,
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
                              items: nodeController.nodes.isNotEmpty
                                  ? nodeController.nodes
                                      .map((e) => DropdownMenuItem(
                                          value: e, child: Text(e.name)))
                                      .toList()
                                  : [const DropdownMenuItem(child: SizedBox())],
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
                              items: nodeController.nodes.isNotEmpty
                                  ? nodeController.nodes
                                      .map((e) => DropdownMenuItem(
                                          value: e, child: Text(e.name)))
                                      .toList()
                                  : [const DropdownMenuItem(child: SizedBox())],
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
                        ontap: () => key.currentState!.validate()
                            ? aristController.add(
                                origin, destiny, controller.text)
                            : null,
                      ),
                    ),
                    activateOptions(true, styleItemRadio, false),
                    activateOptions(false, styleItemRadio, false),
                  ],
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }

  Widget activateOptions(bool add, TextStyle style, bool dark) {
    return Column(
      children: [
        TitleWidget(
          type: "subtitle",
          text: add ? "Node" : "General",
        ),
        Container(
          margin: UiSpacing.bottomMacrosmall(),
          child: Row(
            children: [
              Text(
                add ? "Add" : "Delete:",
                style: style,
              ),
              const Expanded(child: SizedBox()),
              Radio(
                value: add ? addAction.actived : deleteAction.actived,
                groupValue: add ? activateAdd : activateDelete,
                onChanged: (value) {
                  setState(() {
                    if (add) {
                      activateAdd = value as addAction;
                      if (widget.statusAdd != null) {
                        widget.statusAdd!(activateAdd);
                      }
                    } else {
                      activateDelete = value as deleteAction;
                      if (widget.statusDelete != null) {
                        widget.statusDelete!(activateDelete);
                      }
                    }
                  });
                },
                activeColor: UiColors.coreOutline1Color(dark),
              ),
              Text(
                "Yes",
                style: style,
              ),
              const SizedBox(
                width: UiSpacing.microSpaceMedium,
              ),
              Radio(
                value: add ? addAction.notactivate : deleteAction.notactivate,
                groupValue: add ? activateAdd : activateDelete,
                onChanged: (value) {
                  setState(() {
                    if (add) {
                      activateAdd = value as addAction;
                      if (widget.statusAdd != null) {
                        widget.statusAdd!(activateAdd);
                      }
                    } else {
                      activateDelete = value as deleteAction;
                      if (widget.statusDelete != null) {
                        widget.statusDelete!(activateDelete);
                      }
                    }
                  });
                },
                activeColor: UiColors.coreOutline1Color(dark),
              ),
              Text(
                "No",
                style: style,
              ),
            ],
          ),
        )
      ],
    );
  }
}
