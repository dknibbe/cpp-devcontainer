#include "TemperatureConverter.hpp"

namespace TemperatureConverter {
double celsius2fahrenheit(double temperature) {
  // °C * 1,8 + 32
  return temperature * 1.8 + 32.0;
}

double fahrenheit2celsius(double temperature) {
  // (°F - 32) * 5/9
  return (temperature - 32) * 5.0 / 9.0;
}
} // namespace TemperatureConverter
