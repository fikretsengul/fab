import 'package:deps/packages/freezed_annotation.dart';
import 'package:flutter/widgets.dart';

/// `JsonOffsetTypeSerializer` is a converter class used for serializing and deserializing
/// `Offset` objects to and from JSON. It implements the `JsonConverter` interface,
/// providing custom logic to handle `Offset` objects in JSON operations.
class JsonOffsetTypeSerializer implements JsonConverter<Offset, List<double>> {
  /// Constructs a `JsonOffsetTypeSerializer`.
  const JsonOffsetTypeSerializer();

  /// Converts a list of two doubles from JSON to an `Offset` object.
  ///
  /// [json]: The list containing two double values representing the x and y coordinates.
  ///
  /// Returns an `Offset` object corresponding to the provided list of doubles.
  @override
  Offset fromJson(List<double> json) => Offset(json[0], json[1]);

  /// Converts an `Offset` object to a list of two doubles for JSON serialization.
  ///
  /// [offset]: The `Offset` object to serialize.
  ///
  /// Returns a list of two doubles representing the x and y coordinates of the offset,
  /// suitable for JSON serialization.
  @override
  List<double> toJson(Offset offset) => [offset.dx, offset.dy];
}
