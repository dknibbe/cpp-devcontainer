#include <catch2/catch_test_macros.hpp>

#include <TemperatureConverter.hpp>

TEST_CASE("0 degrees celsius") {
  REQUIRE(TemperatureConverter::celsius2fahrenheit(0.0) == 32.0);
}

TEST_CASE("100 degrees celsius") {
  REQUIRE(TemperatureConverter::celsius2fahrenheit(100.0) == 212.0);
}

TEST_CASE("Roundtrips") {
  REQUIRE(TemperatureConverter::celsius2fahrenheit(
              TemperatureConverter::fahrenheit2celsius(0.0)) == 0.0);
  REQUIRE(TemperatureConverter::fahrenheit2celsius(
              TemperatureConverter::celsius2fahrenheit(0.0)) == 0.0);
}
