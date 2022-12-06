#include <catch2/catch_test_macros.hpp>
#include <catch2/matchers/catch_matchers_floating_point.hpp>

#include <TemperatureConverter.hpp>

TEST_CASE("0 degrees celsius") {
  REQUIRE_THAT(TemperatureConverter::celsius2fahrenheit(0.0),
               Catch::Matchers::WithinRel(32.0));
}

TEST_CASE("100 degrees celsius") {
  REQUIRE_THAT(TemperatureConverter::celsius2fahrenheit(100.0),
               Catch::Matchers::WithinRel(212.0));
}

TEST_CASE("0 degrees fahrenheit") {
  REQUIRE_THAT(TemperatureConverter::fahrenheit2celsius(0.0),
               Catch::Matchers::WithinRel(-17.7, 1e-2));
}

TEST_CASE("100 degrees fahrenheit") {
  REQUIRE_THAT(TemperatureConverter::fahrenheit2celsius(100.0),
               Catch::Matchers::WithinRel(37.7, 1e-2));
}

TEST_CASE("Roundtrips") {
  REQUIRE_THAT(TemperatureConverter::celsius2fahrenheit(
                   TemperatureConverter::fahrenheit2celsius(0.0)),
               Catch::Matchers::WithinRel(0.0));
  REQUIRE_THAT(TemperatureConverter::fahrenheit2celsius(
                   TemperatureConverter::celsius2fahrenheit(0.0)),
               Catch::Matchers::WithinRel(0.0));
}
