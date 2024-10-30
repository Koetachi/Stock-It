import 'package:flutter/material.dart';
import 'package:stockit/src/models/produtos_models.dart';
import 'package:stockit/src/screens/widgets/addItem_box.dart';
import 'package:stockit/src/screens/widgets/products_box.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _controller = TextEditingController();
  final _descricao = TextEditingController();
  final _valor = TextEditingController();
  bool ordena = true;

  List<Produtos> lista = [
    Produtos(
        itemName: 'Café', itemDesc: 'Melita', inStorage: false, valor: 18.5),
    Produtos(
        itemName: 'Leite', itemDesc: 'Mococa', inStorage: true, valor: 12.5),
  ];

  void orderList(bool ordenado) {
    setState(() {
      lista.sort((a, b) {
        if (ordena) {
          return a.valor.compareTo(b.valor);
        } else {
          return b.valor.compareTo(a.valor);
        }
      });
      ordena = ordenado;
    });
  }

  void checkList(bool? value, int index) {
    setState(() {
      lista[index].inStorage = !lista[index].inStorage;
    });
  }

  void saveNewItem() {
    setState(() {
      double valor = double.parse(_valor.text);
      lista.add(Produtos(
        itemName: _controller.text,
        itemDesc: _descricao.text,
        valor: valor,
        inStorage: false,
      ));
      _controller.clear();
      _descricao.clear();
      _valor.clear();
    });
    Navigator.of(context).pop();
  }

  void deleteItem(int index) {
    setState(() {
      lista.removeAt(index);
    });
  }

  void createNewTask() {
    showDialog(
      context: context,
      builder: (context) {
        return AddItemBox(
          controller: _controller,
          descricao: _descricao,
          valor: _valor,
          onSave: saveNewItem,
          onCancel: () => Navigator.of(context).pop(),
        );
      },
    );
  }

  void tutorial() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            alignment: Alignment.center,
            title: const Text('Como navegar'),
            content: SizedBox(
              height: 150,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Row(
                    children: [
                      Icon(Icons.announcement_rounded),
                      SizedBox(width: 8),
                      Text('Clique para mais detalhes'),
                    ],
                  ),
                  const Row(
                    children: [
                      Icon(Icons.delete),
                      SizedBox(width: 8),
                      Text('Clique e segure para excluir'),
                    ],
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
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Stock-It',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: Colors.redAccent,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_alt_rounded),
            onPressed: () => orderList(true),
          ),
          IconButton(
            icon: const Icon(Icons.filter_alt_off_rounded),
            onPressed: () => orderList(false),
          ),
          IconButton(
            onPressed: createNewTask,
            icon: const Icon(Icons.dehaze_rounded),
          ),
          IconButton(
              onPressed: tutorial,
              icon: const Icon(Icons.announcement_rounded)),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: createNewTask,
        child: const Icon(Icons.add),
      ),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
        ),
        itemCount: lista.length,
        itemBuilder: (context, int index) {
          return ItemBox(
            item: lista[index],
            itemSelect: lista[index].inStorage,
            onTroca: (value) => checkList(value, index),
            deleteItem: (context) => deleteItem(index),
          );
        },
      ),
    );
  }
}
