class Std {
  final String firstName;
  final String lastName;

  Std({
    required this.firstName,
    required this.lastName,
  });

  factory Std.fromSheets(List<String> input) =>
     Std(
      firstName: input[4], 
      lastName: input[5]
      );
}