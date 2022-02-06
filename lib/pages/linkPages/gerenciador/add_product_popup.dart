import 'package:estoque_frontend/models/product_model.dart';
import 'package:estoque_frontend/repositories/product_repository.dart';
import 'package:estoque_frontend/services/auth_services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddProduct extends StatefulWidget {
  final Product? product;
  const AddProduct({required this.product, Key? key}) : super(key: key);

  @override
  _AddProductState createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  inputDecoration(String hint) {
    return InputDecoration(
      focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black),
          borderRadius: BorderRadius.all(Radius.circular(10))),
      border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(color: Colors.black)),
      hintText: hint,
    );
  }

  final TextEditingController _nameProduct = TextEditingController();
  final TextEditingController _tagProduct = TextEditingController();
  final TextEditingController _quantProduct = TextEditingController(text: "0");

  int _quantidade = 0;
  double _maxHeight = 375;
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;

  _addQuantidade() {
    setState(
      () {
        _quantidade = (int.tryParse(_quantProduct.text)!) + 1;
        _quantProduct.text = _quantidade.toString();
      },
    );
  }

  _subQuantidade() {
    setState(
      () {
        _quantidade = (int.tryParse(_quantProduct.text)!) - 1;
        _quantProduct.text = _quantidade.toString();
      },
    );
  }

  _updateHeight() {
    if (_maxHeight < 415) {
      setState(
        () {
          _maxHeight = _maxHeight + 60;
        },
      );
    }
  }

  registerProduct(Product product) async {
    ScaffoldMessenger.of(context).clearSnackBars();
    try {
      setState(() {
        isLoading = true;
      });
      if (await context.read<ProductRepository>().registerProduct(
            product,
            context.read<AuthService>().token,
          )) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Produto cadastrado com sucesso"),
          ),
        );
        Navigator.of(context).pop();
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            e.toString(),
          ),
        ),
      );
    }
    setState(() {
      isLoading = false;
    });
  }

  updateProduct(Product product) async {
    ScaffoldMessenger.of(context).clearSnackBars();
    try {
      setState(() {
        isLoading = true;
      });
      if (await context
          .read<ProductRepository>()
          .updateProduct(product, context.read<AuthService>().token)) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Produto atualizado com sucesso"),
          ),
        );
        Navigator.of(context).pop();
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            e.toString(),
          ),
        ),
      );
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    _nameProduct.text = widget.product == null ? "" : widget.product!.name;
    _tagProduct.text =
        widget.product == null ? "" : widget.product!.productType;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Container(
        constraints: BoxConstraints(
          minWidth: 400,
          maxWidth: 500,
          minHeight: 375,
          maxHeight: _maxHeight,
        ),
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(20))),
        width: MediaQuery.of(context).size.width,
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Adicionar produto",
                style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 10, bottom: 5),
                child: Text(
                  "Nome :",
                  style: TextStyle(fontSize: 15),
                ),
              ),
              TextFormField(
                cursorColor: Colors.black,
                decoration: inputDecoration("Digite o nome do produto"),
                controller: _nameProduct,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Preencha o nome do produto";
                  }
                  return null;
                },
              ),
              const Padding(
                padding: EdgeInsets.only(top: 10, bottom: 5),
                child: Text(
                  "Tag :",
                  style: TextStyle(fontSize: 15),
                ),
              ),
              TextFormField(
                cursorColor: Colors.black,
                decoration: inputDecoration("Digite um tag para o produto"),
                controller: _tagProduct,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Preencha um tag para o produto";
                  }
                  return null;
                },
              ),
              const Padding(
                padding: EdgeInsets.only(top: 10, bottom: 5),
                child: Text(
                  "Quantidade :",
                  style: TextStyle(fontSize: 15),
                ),
              ),
              SizedBox(
                height: 55,
                child: Row(
                  children: [
                    Container(
                      constraints:
                          const BoxConstraints(minHeight: 40, maxHeight: 45),
                      width: 140,
                      child: TextFormField(
                        readOnly: true,
                        textAlign: TextAlign.center,
                        textAlignVertical: TextAlignVertical.bottom,
                        controller: _quantProduct,
                        decoration: inputDecoration(''),
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value == "0") {
                            return "Quantidade inválida.";
                          }
                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Container(
                        height: 25,
                        width: 25,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(color: Colors.grey.shade700)),
                        child: IconButton(
                          padding: const EdgeInsets.all(0),
                          splashRadius: 15,
                          onPressed: _addQuantidade,
                          icon: Icon(
                            Icons.add,
                            color: Colors.grey.shade700,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      height: 25,
                      width: 25,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(color: Colors.grey.shade700)),
                      child: IconButton(
                        padding: const EdgeInsets.all(0),
                        splashRadius: 15,
                        onPressed: () =>
                            _quantidade != 0 ? _subQuantidade() : {},
                        icon: Icon(
                          Icons.remove,
                          color: Colors.grey.shade700,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 50,
                      child: ElevatedButton(
                        child: const Text(
                          'Cancelar',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Colors.purple,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: SizedBox(
                      height: 50,
                      child: ElevatedButton(
                        child: widget.product == null
                            ? const Text('Adicionar produto')
                            : const Text('Atualizar produto'),
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            if (widget.product == null) {
                              registerProduct(
                                Product(
                                    name: _nameProduct.text,
                                    productType: _tagProduct.text),
                              );
                            } else {
                              updateProduct(
                                Product(
                                    id: widget.product!.id,
                                    name: _nameProduct.text,
                                    productType: _tagProduct.text),
                              );
                            }
                          } else {
                            _updateHeight();
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Colors.purple,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
