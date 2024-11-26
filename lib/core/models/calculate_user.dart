class CalculateUser {
  final String nome;
  final double salarioBruto;
  final double descontoINSS;
  final int numeroDependentes;
  final double totalDescontoIRRF;
  final int cpf;
  final int cep;

  CalculateUser(
      {this.nome = '',
      this.salarioBruto = 0,
      this.descontoINSS = 0,
      this.numeroDependentes = 0,
      this.totalDescontoIRRF = 0,
      this.cpf = 0,
      this.cep = 0});

  CalculateUser copyWith({
    String? nome,
    double? salarioBruto,
    double? descontoINSS,
    int? numeroDependentes,
    double? totalDescontoIRRF,
    int? cpf,
    int? cep,
  }) {
    return CalculateUser(
      nome: nome ?? this.nome,
      salarioBruto: salarioBruto ?? this.salarioBruto,
      descontoINSS: descontoINSS ?? this.descontoINSS,
      numeroDependentes: numeroDependentes ?? this.numeroDependentes,
      totalDescontoIRRF: totalDescontoIRRF ?? this.totalDescontoIRRF,
      cpf: cpf ?? this.cpf,
      cep: cep ?? this.cep,
    );
  }
}
