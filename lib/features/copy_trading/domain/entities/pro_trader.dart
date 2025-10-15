import 'package:equatable/equatable.dart';

class ProTrader extends Equatable {
  final String initials;
  final String name;
  final int copiers;
  final double roi;
  final double pnl;
  final int winRate;
  final double aum;
  final List<double> chartData; // For the sparkline chart

  const ProTrader({
    required this.initials,
    required this.name,
    required this.copiers,
    required this.roi,
    required this.pnl,
    required this.winRate,
    required this.aum,
    required this.chartData,
  });

  @override
  List<Object?> get props => [name, initials];
}