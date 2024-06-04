// ignore_for_file: public_member_api_docs, sort_constructors_first
class InvestmentModel {
  String invest;
  int amount;
  String tableno;
  String time;
  bool? isWin;
  String? id;

  InvestmentModel({
    required this.time,
    required this.invest,
    required this.amount,
    required this.tableno,
    this.isWin,
    this.id,
  });
}
