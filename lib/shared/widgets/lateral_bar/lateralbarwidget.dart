import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
  final List<Node> nodes;
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
  late List<Node> nodes;
  late GlobalKey<FormState> key;
  late TextEditingController controller;
  late AnimationController animationController;
  late Animation<double> animation;

  late addAction activateAdd;
  late deleteAction activateDelete;
  Node? origin;
  Node? destiny;
  @override
  void initState() {
    super.initState();
    nodes = widget.nodes;
    origin = nodes.isNotEmpty ? nodes[0] : null;
    destiny = nodes.isNotEmpty
        ? nodes.length >= 2
            ? nodes[1]
            : nodes[0]
        : null;
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
          child: SingleChildScrollView(
            padding: UiSpacing.xMacrosmall(),
            child: Column(
              children: [
                TitleWidget(
                  text: "Settings",
                  color: UiColors.white,
                ),
                const TitleWidget(
                  type: "subtitle",
                  text: "Arch",
                ),
                Row(
                  children: [
                    CustomDropDown(
                      dropdown: DropdownButton(
                        value: origin,
                        icon: SvgPicture.asset(
                          "${iconpath}angle-down.svg",
                          width: 16,
                        ),
                        items: nodes
                            .map((e) =>
                                DropdownMenuItem(value: e, child: Text(e.name)))
                            .toList(),
                        onChanged: (Node? e) => setState(() {
                          origin = e;
                        }),
                      ),
                    ),
                    Container(
                      margin: UiSpacing.xMicrolarge(),
                      child: Text(
                        "CONNECT TO",
                        style:
                            UiFonts.txtCaption2(UiColors.outline2Color(false)),
                      ),
                    ),
                    CustomDropDown(
                      dropdown: DropdownButton(
                        value: destiny,
                        icon: SvgPicture.asset(
                          "${iconpath}angle-down.svg",
                          width: 16,
                        ),
                        items: nodes
                            .map((e) =>
                                DropdownMenuItem(value: e, child: Text(e.name)))
                            .toList(),
                        onChanged: (Node? e) => setState(() {
                          destiny = e;
                        }),
                      ),
                    ),
                  ],
                ),
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
                        if (origin == null || widget.nodes.length < 2) {
                          ScaffoldMessenger.of(context).hideCurrentSnackBar();
                          ScaffoldMessenger.of(context).showSnackBar(
                              CustomSnackBar.errorSnackBar(
                                  text: "Necesitas al menos 2 nodos ..."));
                          return;
                        } else if (origin == destiny) {
                          ScaffoldMessenger.of(context).hideCurrentSnackBar();
                          ScaffoldMessenger.of(context).showSnackBar(
                              CustomSnackBar.errorSnackBar(
                                  text:
                                      "Los nodos no pueden ser los mismos ..."));
                          return;
                        }

                        bool mayor = origin!.name.codeUnitAt(0) >
                            destiny!.name.codeUnitAt(0);

                        Node nodeOrigin = mayor ? destiny! : origin!;
                        Node nodeDestiny = mayor ? origin! : destiny!;

                        Aristc aristc = Aristc(
                            origin: nodeOrigin,
                            destiny: nodeDestiny,
                            weight: int.parse(controller.text));

                        if (widget.archs.isNotEmpty) {
                          for (var item in widget.archs) {
                            if (item.destiny == aristc.destiny &&
                                item.origin == aristc.origin) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  CustomSnackBar.errorSnackBar(
                                      text:
                                          "Ya hay una arista entre los nodos ..."));
                              return;
                            }
                          }
                        }
                        if (widget.arch != null) {
                          widget.arch!(aristc);
                        }
                      }
                    },
                  ),
                ),
                activateOptions(true, styleItemRadio, false),
                activateOptions(false, styleItemRadio, false),
              ],
            ),
          ),
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
