class StringUtil{
  static String createInitials(String word){

    String getInitials(String s, int maxLength){
      int end = s.length < maxLength ? s.length : maxLength;
      return s.substring(0, end);
    }

    String getFirstCharacter(String word){
      if (word.isNotEmpty)
        return word[0];
      return word;
    }

    List<String> words = word.split(" ");

    if (words.length == 1){
      return getInitials(words[0], 3);
    }
    if (words.length == 2){
      return  getInitials(words[0], 2) + words[1][0];
    }

    return getFirstCharacter(word[0])+  getFirstCharacter(words[1]) + getFirstCharacter(words[2]);
  }
}