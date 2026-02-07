import 'dart:math';

class QiblaService {
  /// Calculate Qibla direction (heading from North) based on current coordinates
  static double calculateQiblaDirection(double latitude, double longitude) {
    // Kaaba coordinates (Mecca)
    const double kaabaLat = 21.422487;
    const double kaabaLng = 39.826206;

    double lambdaK = kaabaLng * pi / 180.0;
    double phiK = kaabaLat * pi / 180.0;
    double lambda = longitude * pi / 180.0;
    double phi = latitude * pi / 180.0;

    double numerator = sin(lambdaK - lambda);
    double denominator =
        cos(phi) * tan(phiK) - sin(phi) * cos(lambdaK - lambda);

    double qiblaDirection = atan2(numerator, denominator) * 180.0 / pi;

    // Normalize to 0-360
    if (qiblaDirection < 0) {
      qiblaDirection += 360.0;
    }

    return qiblaDirection;
  }
}
