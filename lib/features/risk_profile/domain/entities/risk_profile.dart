import 'package:equatable/equatable.dart';

class RiskProfile extends Equatable {
  final String title;
  final String description;

  const RiskProfile({
    required this.title,
    required this.description,
  });

  @override
  List<Object?> get props => [title, description];
}