#include "TemperatureConverter.hpp"

namespace TemperatureConverter {
double celsius2fahrenheit(double temperature) {
  // °C * 1,8 + 32
  return temperature * 9.0 / 5.0 + 32.0;
}

double fahrenheit2celsius(double temperature) {
  // (°F - 32) * 5/9
  return (temperature - 32.0) * 5.0 / 9.0;
}
} // namespace TemperatureConverter
