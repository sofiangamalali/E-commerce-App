import 'package:elhaga/Data/Models/product_model.dart';
import 'package:equatable/equatable.dart';

class Favorite extends Equatable {
  final List<Product> items;
  const Favorite({this.items = const <Product>[]});
  @override
  List<Object?> get props => [items];
}
