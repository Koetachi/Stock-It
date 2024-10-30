import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:stockit/src/screens/widgets/button_box.dart';

class AddItemBox extends StatelessWidget {
  final TextEditingController controller, descricao, valor;
  final VoidCallback onSave;
  final VoidCallback onCancel;

  const AddItemBox({
    super.key,
    required this.controller,
    required this.descricao,
    required this.valor,
    required this.onSave,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.tealAccent[100],
      content: SizedBox(
        height: 300,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            TextField(
              controller: controller,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Cadastrar Produto",
              ),
            ),
            TextField(
              controller: descricao,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Descrição Produto",
              ),
            ),
            TextField(
              controller: valor,
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}$'))
              ],
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Preço",
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Buttons(
                    text: "Incluir",
                    ico: Icons.add,
                    onPress: () {
                      if (controller.text.isEmpty ||
                          descricao.text.isEmpty ||
                          valor.text.isEmpty) {
                        showDialog(
                            context: context,
                            builder: (
                              BuildContext context,
                            ) {
                              return AlertDialog(
                                  title: const Text(
                                      'Por favor, preencha todos os campos'),
                                  content: Buttons(
                                      text: "Fechar",
                                      ico: Icons.cancel,
                                      onPress: () {
                                        Navigator.of(context).pop();
                                      }));
                            });
                      } else {
                        onSave();
                      }
                    }),
                Buttons(text: "Fechar", ico: Icons.cancel, onPress: onCancel),
              ],
            )
          ],
        ),
      ),
    );
  }
}
