import 'package:intl/intl.dart';

final dateFormatter = DateFormat('yyyy-MM-dd');
final timeFormatter = DateFormat('HH:mm:ss');

DateTime fromGraphQLDateTimeToDartDateTime(DateTime dateTime) => dateTime;
DateTime fromDartDateTimeToGraphQLDateTime(DateTime dateTime) => dateTime;
DateTime? fromGraphQLDateTimeToDartDateTimeNullable(DateTime? dateTime) => dateTime;
DateTime? fromDartDateTimeToGraphQLDateTimeNullable(DateTime? dateTime) => dateTime;
DateTime? fromGraphQLDateTimeNullableToDartDateTimeNullable(DateTime? dateTime) => dateTime;
DateTime? fromDartDateTimeNullableToGraphQLDateTimeNullable(DateTime? dateTime) => dateTime;
