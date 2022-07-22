import '../specifications/specification.dart';

abstract class CompositeSpecification<T> extends Specification<T> {
  CompositeSpecification({
    required this.left,
    required this.right,
  });

  final Specification<T> left;

  final Specification<T> right;
}
