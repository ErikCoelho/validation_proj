import '../../../../core/models/calculate_user.dart';

class CalculateUserUseCase {
  final CalculateUser user;

  CalculateUserUseCase(this.user);

  double calcularBaseCalculo() {
    const deducaoPorDependente = 189.59;
    return user.salarioBruto -
        user.descontoINSS -
        (user.numeroDependentes * deducaoPorDependente) -
        user.totalDescontoIRRF;
  }

  double calcularIRRF() {
    double baseCalculo = calcularBaseCalculo();

    if (baseCalculo <= 2112.00) {
      return 0.0; // Isento
    } else if (baseCalculo <= 2826.65) {
      return (baseCalculo * 0.075) - 158.40;
    } else if (baseCalculo <= 3751.05) {
      return (baseCalculo * 0.15) - 370.40;
    } else if (baseCalculo <= 4664.68) {
      return (baseCalculo * 0.225) - 651.73;
    } else {
      return (baseCalculo * 0.275) - 884.96;
    }
  }

  double calcularSalarioLiquido() {
    double irrf = calcularIRRF();
    return user.salarioBruto -
        user.descontoINSS -
        irrf -
        user.totalDescontoIRRF;
  }
}
