#include "generator/regions/specs/syria.hpp"

namespace generator
{
namespace regions
{
namespace specs
{
PlaceLevel SyriaSpecifier::GetSpecificCountryLevel(Region const & region) const
{
  return PlaceLevel::Unknown;
}
}  // namespace specs
}  // namespace regions
}  // namespace generator
