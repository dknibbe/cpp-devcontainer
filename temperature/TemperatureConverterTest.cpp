#include <catch2/catch_test_macros.hpp>

#include <TemperatureConverter.hpp>

TEST_CASE("This is a basic test") {
  REQUIRE(TemperatureConverter::celsius2fahrenheit(2.0) == 2.0);
}

TEST_CASE("This is another test") { REQUIRE(true); }
