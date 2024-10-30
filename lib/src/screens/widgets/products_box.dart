import 'package:flutter/material.dart';
import 'package:stockit/src/models/produtos_models.dart';

class ItemBox extends StatelessWidget {
  final Produtos item;
  final bool itemSelect;
  final Function(bool?)? onTroca;
  final Function(BuildContext)? deleteItem;

  const ItemBox({
    super.key,
    required this.item,
    required this.itemSelect,
    required this.onTroca,
    required this.deleteItem,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: GestureDetector(
        onLongPress: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text('Deseja excluir ${item.itemName}?'),
                  content: Row(
                    children: [
                      TextButton.icon(
                        onPressed: () {
                          if (deleteItem != null) {
                            deleteItem!(context);
                            Navigator.of(context).pop();
                          }
                        },
                        icon: const Icon(Icons.delete),
                        label: const Text('Excluir Item'),
                      ),
                      TextButton.icon(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        icon: const Icon(Icons.cancel),
                        label: const Text('Fechar'),
                      ),
                    ],
                  ),
                );
              });
        },
        onTap: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                alignment: Alignment.center,
                title: Text(item.itemName,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    )),
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Descrição:\n${item.itemDesc}'),
                    Text('Valor:\nR\$${item.valor}'),
                  ],
                ),
                actions: <Widget>[
                  TextButton.icon(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(Icons.cancel),
                    label: const Text('Fechar'),
                  ),
                ],
              );
            },
          );
        },
        child: Column(
          children: [
            Image.asset('lib/src/assets/icon-entrevista.png'),
            Text('${item.itemName} - R\$${item.valor}',
                style: TextStyle(
                  decoration: itemSelect == true
                      ? TextDecoration.none
                      : TextDecoration.lineThrough,
                )),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Checkbox(
                  value: itemSelect,
                  onChanged: onTroca,
                  activeColor: Colors.green,
                ),
                Text(itemSelect == true ? "Em Estoque" : "Esgotado",
                    style: itemSelect == true
                        ? const TextStyle(
                            color: Colors.green,
                            fontSize: 14,
                            fontWeight: FontWeight.bold)
                        : TextStyle(
                            color: Colors.red.shade300,
                          )),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
