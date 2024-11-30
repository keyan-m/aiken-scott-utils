//// Since every value in Aiken is data encoded, using tuples to pack multiple
//// values adds extra overhead as they need to be constructed the hood.
////
//// However, if we use nested functions, we can pass multiple values as
//// arguments of functions with higher arities.
////
//// Following datatypes are aliases representing the nested functions which
//// use multiple values returned by the utility functions of this package. In
//// the context of validators, the polymorphic `result`s typically resolve to
//// `Bool`.

pub type Scott2<a, b, result> =
  fn(a, b) -> result

pub type Scott3<a, b, c, result> =
  fn(a, b, c) -> result

pub type Scott4<a, b, c, d, result> =
  fn(a, b, c, d) -> result

pub type Scott5<a, b, c, d, e, result> =
  fn(a, b, c, d, e) -> result

pub type Scott6<a, b, c, d, e, f, result> =
  fn(a, b, c, d, e, f) -> result
