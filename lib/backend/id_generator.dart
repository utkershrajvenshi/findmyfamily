import 'dart:math';

class IDGenerator {
  static String generateRoomID() {
    const _charSet = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    var random = Random.secure();
    return List.generate(6, (index) => _charSet[random.nextInt(_charSet.length)]).join();
  }
}
