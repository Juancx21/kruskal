import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kruskal/domain/entities/aristc.dart';
import 'package:kruskal/domain/entities/node.dart';
import 'package:kruskal/shared/widgets/custom_snackbar.dart';

class AddAristcPage extends StatefulWidget {
  final List<NodeKruskal> nodes;
  final List<Aristc>? aristcs;
  const AddAristcPage({Key? key, required this.nodes, this.aristcs})
      : super(key: key);

  @override
  State<AddAristcPage> createState() => _AddAristcPageState();
}

class _AddAristcPageState extends State<AddAristcPage> {
  late int weight;
  late NodeKruskal origin;
  late NodeKruskal destiny;

  late TextEditingController controller;

  GlobalKey key = GlobalKey();
  @override
  void initState() {
    super.initState();
    weight = 0;
    origin = widget.nodes[0];
    destiny = widget.nodes[1];
    controller = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: Column(
            children: [
              Container(
                constraints: const BoxConstraints(maxWidth: 400),
                margin: const EdgeInsets.symmetric(vertical: 24),
                child: Row(
                  children: [
                    DropdownButton(
                      value: origin,
                      items: widget.nodes
                          .map((e) =>
                              DropdownMenuItem(value: e, child: Text(e.name)))
                          .toList(),
                      onChanged: (NodeKruskal? e) => setState(() {
                        origin = e as NodeKruskal;
                      }),
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                    DropdownButton(
                      value: destiny,
                      items: widget.nodes
                          .map((e) =>
                              DropdownMenuItem(value: e, child: Text(e.name)))
                          .toList(),
                      onChanged: (NodeKruskal? e) => setState(() {
                        destiny = e as NodeKruskal;
                      }),
                    ),
                  ],
                ),
              ),
              Container(
                constraints: const BoxConstraints(maxWidth: 400),
                margin: const EdgeInsets.only(
                  bottom: 24,
                ),
                child: Row(
                  children: [
                    const Text("Peso de la arista: "),
                    Form(
                      key: key,
                      child: Expanded(
                          child: TextFormField(
                        controller: controller,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                      )),
                    )
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 24),
                child: ElevatedButton(
                    onPressed: () {
                      if ((origin != destiny) && controller.text.isNotEmpty) {
                        Aristc aristc = Aristc(
                            origin: origin, destiny: destiny, weight: weight);
                        if (widget.aristcs != null) {
                          for (var item in widget.aristcs!) {
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
                        Navigator.pop(context, aristc);
                      } else {
                        ScaffoldMessenger.of(context).hideCurrentSnackBar();
                        ScaffoldMessenger.of(context)
                            .showSnackBar(CustomSnackBar.errorSnackBar(
                                text: origin == destiny
                                    ? "Los nodos no pueden ser los mismos ..."
                                    : controller.text.isEmpty
                                        ? "Ingrese el peso"
                                        : "Hubo un error ..."));
                      }
                    },
                    child: const Text("Hola")),
              ),
              Container(
                margin: const EdgeInsets.only(top: 0, bottom: 24),
                child: TextButton(
                    onPressed: (() => Navigator.pop(context)),
                    child: const Text("Regresar")),
              )
            ],
          ),
        ),
      ),
    );
  }
}
