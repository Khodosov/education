class Message {
  final String author;
  final String message;

  Message({
    required this.author,
    required this.message,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Message && author == other.author && message == other.message);

  @override
  int get hashCode => author.hashCode * message.hashCode;

  @override
  String toString() => '$author: "$message"';
}
