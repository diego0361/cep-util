import 'package:cep_util/models/endereco_model.dart';
import 'package:cep_util/pages/location_card.dart';
import 'package:cep_util/repositories/cep_repository.dart';
import 'package:cep_util/repositories/cep_repository_impl.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final CepRepository cepRepository = CepRepositoryImpl();
  EnderecoModel? enderecoModel;

  bool loading = false;

  final formKey = GlobalKey<FormState>();
  final cepEC = TextEditingController();

  @override
  void dispose() {
    cepEC.dispose();
    super.dispose();
  }

  void searchCep() async {
    final valid = formKey.currentState?.validate() ?? false;
    if (valid) {
      try {
        setState(() {
          loading = true;
        });
        final endereco = await cepRepository.getCep(cepEC.text);
        setState(() {
          loading = false;
          enderecoModel = endereco;
        });
      } catch (e) {
        setState(() {
          loading = false;
          enderecoModel = null;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.red,
            content: Text('Erro ao buscar endereço'),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Buscar CEP'),
        backgroundColor: Colors.amber,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: TextFormField(
                  controller: cepEC,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'CEP Obrigatório';
                    }
                    return null;
                  },
                ),
              ),
              ElevatedButton(
                onPressed: searchCep,
                child: const Text('Buscar'),
              ),
              Visibility(
                visible: loading,
                child: const CircularProgressIndicator(),
              ),
              Visibility(
                visible: enderecoModel != null,
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      LocationCard(
                        title: 'Localidade: ${enderecoModel?.localidade}',
                      ),
                      LocationCard(
                        title: 'Logradouro: ${enderecoModel?.logradouro}',
                      ),
                      LocationCard(
                        title: 'Bairro: ${enderecoModel?.bairro}',
                      ),
                      LocationCard(
                        title: 'CEP: ${enderecoModel?.cep}',
                      ),
                      LocationCard(
                        title: 'DDD: ${enderecoModel?.ddd}',
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
