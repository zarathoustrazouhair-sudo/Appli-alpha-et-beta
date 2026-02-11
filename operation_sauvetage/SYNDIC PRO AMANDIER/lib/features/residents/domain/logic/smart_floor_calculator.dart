class SmartFloorCalculator {
  static String getFloor(int apartmentNumber) {
    if (apartmentNumber >= 1 && apartmentNumber <= 5) {
      return "1er Étage";
    } else if (apartmentNumber >= 6 && apartmentNumber <= 10) {
      return "2ème Étage";
    } else if (apartmentNumber >= 11 && apartmentNumber <= 15) {
      return "3ème Étage";
    } else {
      return "RDC ou Inconnu";
    }
  }
}
