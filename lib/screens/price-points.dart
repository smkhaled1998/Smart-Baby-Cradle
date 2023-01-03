
import 'package:collection/collection.dart';
class PricePoint {
  final double x;
  final double y;

  PricePoint({required this.x, required this.y});
}
//
// List<PricePoint> get pricePoints {
//   final data =<double> [1,2,3,4,5,8,19,20,21,22,23,24];
//   return data
//       .mapIndexed(
//           (index, element) => PricePoint(x: index.toDouble(), y: element))
//       .toList();
// }
