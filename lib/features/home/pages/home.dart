import 'package:flutter/material.dart';
import 'package:validator/features/home/data/datasource/cep_api_service.dart';
import 'package:validator/features/home/data/models/cep.dart';
import 'package:validator/features/home/domain/usecases/calculate_user_usecases.dart';

import '../../../core/models/calculate_user.dart';
import '../presentation/widgets/custom_text_field.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    var calculateUser = CalculateUser();
    var cepApiService = CepApiService();

    return Scaffold(
      appBar: appBar(),
      body: Padding(
          padding: const EdgeInsets.all(15),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomTextField(
                    label: 'Nome',
                    hint: 'Preencha o nome',
                    inputType: 'nome',
                    onSaved: (value) =>
                        calculateUser = calculateUser.copyWith(nome: value)),
                const SizedBox(height: 20),
                CustomTextField(
                    label: 'Salário Bruto',
                    hint: 'Preencha o salário',
                    inputType: 'money',
                    onSaved: (value) {
                      final sanitizedValue =
                          value?.replaceAll(RegExp(r'[^0-9,]'), '') ?? '0';
                      calculateUser = calculateUser.copyWith(
                          salarioBruto: double.tryParse(
                                  sanitizedValue.replaceAll(',', '.')) ??
                              0);
                    }),
                const SizedBox(height: 20),
                CustomTextField(
                    label: 'Desconto INSS',
                    hint: 'Preencha o desconto',
                    inputType: 'money',
                    onSaved: (value) {
                      final sanitizedValue =
                          value?.replaceAll(RegExp(r'[^0-9,]'), '') ?? '0';
                      calculateUser = calculateUser.copyWith(
                          descontoINSS: double.tryParse(
                                  sanitizedValue.replaceAll(',', '.')) ??
                              0);
                    }),
                const SizedBox(height: 20),
                CustomTextField(
                    label: 'Número de dependentes',
                    hint: 'Preencha o número de dependentes',
                    inputType: 'int',
                    onSaved: (value) => calculateUser = calculateUser.copyWith(
                        numeroDependentes: int.tryParse(value ?? ''))),
                const SizedBox(height: 20),
                CustomTextField(
                    label: 'Total de descontos cabíveis para dedução de IRRF',
                    hint: 'Preencha o total de descontos',
                    inputType: 'money',
                    onSaved: (value) {
                      final sanitizedValue =
                          value?.replaceAll(RegExp(r'[^0-9,]'), '') ?? '0';
                      calculateUser = calculateUser.copyWith(
                          totalDescontoIRRF: double.tryParse(
                                  sanitizedValue.replaceAll(',', '.')) ??
                              0);
                    }),
                const SizedBox(height: 20),
                CustomTextField(
                    label: 'CPF',
                    hint: 'Preencha o cpf',
                    inputType: 'cpf',
                    onSaved: (value) {
                      final sanitizedValue =
                          value?.replaceAll(RegExp(r'[^0-9,]'), '') ?? '0';
                      calculateUser = calculateUser.copyWith(
                          cpf: int.tryParse(sanitizedValue
                                  .replaceAll('.', '')
                                  .replaceAll('-', '')) ??
                              0);
                    }),
                const SizedBox(height: 20),
                CustomTextField(
                    label: 'CEP',
                    hint: 'Preencha o cep',
                    inputType: 'cep',
                    onSaved: (value) {
                      final sanitizedValue =
                          value?.replaceAll(RegExp(r'[^0-9,]'), '') ?? '0';
                      calculateUser = calculateUser.copyWith(
                          cep: int.tryParse(
                                  sanitizedValue.replaceAll('-', '')) ??
                              0);
                    }),
                ElevatedButton(
                  onPressed: () async {
                    if (formKey.currentState!.validate()) {
                      formKey.currentState!.save();

                      var calculateuserUsecases =
                          CalculateUserUseCase(calculateUser);

                      final double irrf = calculateuserUsecases.calcularIRRF();
                      final double salarioLiquido =
                          calculateuserUsecases.calcularSalarioLiquido();

                      var cep = await cepApiService
                          .getCep(calculateUser.cep.toString());

                      showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                                title: const Text('Resultado'),
                                content: Text(
                                  'Nome: ${calculateUser.nome}\n'
                                  'Salário Bruto: R\$ ${calculateUser.salarioBruto.toStringAsFixed(2)}\n'
                                  'Desconto INSS: R\$ ${calculateUser.descontoINSS.toStringAsFixed(2)}\n'
                                  'Número de Dependentes: ${calculateUser.numeroDependentes}\n'
                                  'Outros Descontos: R\$ ${calculateUser.totalDescontoIRRF.toStringAsFixed(2)}\n'
                                  'Imposto de Renda (IRRF): R\$ ${irrf.toStringAsFixed(2)}\n'
                                  'Salário Líquido: R\$ ${salarioLiquido.toStringAsFixed(2)}\n'
                                  'Endereço: ${cep.logradouro}, ${cep.bairro}, ${cep.localidade} - ${cep.uf}',
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () => Navigator.pop(context),
                                    child: const Text('OK'),
                                  ),
                                ],
                              ));
                    } else {
                      print('form is invalid');
                    }
                  },
                  child: Text('Calcular'),
                )
              ],
            ),
          )),
    );
  }

  AppBar appBar() {
    return AppBar(
      title: const Text(
        'App',
        style: TextStyle(
          color: Colors.black,
          fontSize: 18,
          fontWeight: FontWeight.w800,
        ),
      ),
      backgroundColor: Colors.white,
      centerTitle: true,
    );
  }
}
