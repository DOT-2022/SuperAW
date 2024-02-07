extension StringExtension on String {
  // String capitalize() {
  //   return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  // }

  String capitalizeFirstLetterOfEachWord() {
    if (isEmpty) return ''; // Return empty string if input is empty

    // Split the string into words using whitespace as delimiter
    List<String> words = split(' ');

    // Capitalize the first letter of each word
    words = words.map((word) {
      if (word.isNotEmpty) {
        return word[0].toUpperCase() + word.substring(1).toLowerCase();
      } else {
        return ''; // Return empty string if word is empty
      }
    }).toList();

    // Join the words back into a single string
    return words.join(' ');
  }
}