//// Utility functions for traversing lists while collecting more than one
//// values.
////
//// Sample code to see how you can use one of the fold functions with the
//// backpassing syntax:
//// ```aiken
//// use aiken_scott_utils/list as scott_list
////
//// fn avg_of_sums_and_products(xs: List<Int>) -> Int {
////   let
////     sum,
////     product,
////   <-
////     scott_list.foldr2(
////       xs,
////       0,
////       1,
////       fn(x, sum_so_far, prod_so_far, return) {
////         return(sum_so_far + x, prod_so_far * x)
////       },
////     ) 
////   (sum + product) / 2
//// }
//// ```
////
//// The same code without backpassing syntactic sugar:
//// ```aiken
//// use aiken_scott_utils/list as scott_list
////
//// fn avg_of_sums_and_products_desugared(xs: List<Int>) -> Int {
////   scott_list.foldr2(
////     xs,
////     0,
////     1,
////     fn(x, sum_so_far, prod_so_far, return) {
////       return(sum_so_far + x, prod_so_far * x)
////     },
////     fn(sum, product) { (sum + product) / 2 }
////   ) 
//// }
//// ```

use aiken/collection/list
use aiken_scott_utils/types.{Scott2, Scott3, Scott4, Scott5, Scott6}

// --- FOLDS -------------------------------------------------------------------

fn do_foldr2(
  self: List<x>,
  with: fn(x, a, b, Scott2<a, b, result>) -> result,
  return: Scott2<a, b, result>,
) -> Scott2<a, b, result> {
  when self is {
    [] -> return
    [x, ..xs] -> do_foldr2(xs, with, fn(a, b) { with(x, a, b, return) })
  }
}

fn do_foldr3(
  self: List<x>,
  with: fn(x, a, b, c, Scott3<a, b, c, result>) -> result,
  return: Scott3<a, b, c, result>,
) -> Scott3<a, b, c, result> {
  when self is {
    [] -> return
    [x, ..xs] -> do_foldr3(xs, with, fn(a, b, c) { with(x, a, b, c, return) })
  }
}

fn do_foldr4(
  self: List<x>,
  with: fn(x, a, b, c, d, Scott4<a, b, c, d, result>) -> result,
  return: Scott4<a, b, c, d, result>,
) -> Scott4<a, b, c, d, result> {
  when self is {
    [] -> return
    [x, ..xs] ->
      do_foldr4(xs, with, fn(a, b, c, d) { with(x, a, b, c, d, return) })
  }
}

fn do_foldr5(
  self: List<x>,
  with: fn(x, a, b, c, d, e, Scott5<a, b, c, d, e, result>) -> result,
  return: Scott5<a, b, c, d, e, result>,
) -> Scott5<a, b, c, d, e, result> {
  when self is {
    [] -> return
    [x, ..xs] ->
      do_foldr5(xs, with, fn(a, b, c, d, e) { with(x, a, b, c, d, e, return) })
  }
}

fn do_foldr6(
  self: List<x>,
  with: fn(x, a, b, c, d, e, f, Scott6<a, b, c, d, e, f, result>) -> result,
  return: Scott6<a, b, c, d, e, f, result>,
) -> Scott6<a, b, c, d, e, f, result> {
  when self is {
    [] -> return
    [x, ..xs] ->
      do_foldr6(
        xs,
        with,
        fn(a, b, c, d, e, f) { with(x, a, b, c, d, e, f, return) },
      )
  }
}

pub fn foldl2(
  self: List<x>,
  zero_a: a,
  zero_b: b,
  with: fn(x, a, b, Scott2<a, b, result>) -> result,
  return: Scott2<a, b, result>,
) -> result {
  when self is {
    [] -> return(zero_a, zero_b)
    [x, ..xs] -> {
      let acc_a, acc_b <- with(x, zero_a, zero_b)
      foldl2(xs, acc_a, acc_b, with, return)
    }
  }
}

pub fn foldr2(
  self: List<x>,
  zero_a: a,
  zero_b: b,
  with: fn(x, a, b, Scott2<a, b, result>) -> result,
  return: Scott2<a, b, result>,
) -> result {
  do_foldr2(self, with, return)(zero_a, zero_b)
}

pub fn foldl3(
  self: List<x>,
  zero_a: a,
  zero_b: b,
  zero_c: c,
  with: fn(x, a, b, c, Scott3<a, b, c, result>) -> result,
  return: Scott3<a, b, c, result>,
) -> result {
  when self is {
    [] -> return(zero_a, zero_b, zero_c)
    [x, ..xs] -> {
      let acc_a, acc_b, acc_c <- with(x, zero_a, zero_b, zero_c)
      foldl3(xs, acc_a, acc_b, acc_c, with, return)
    }
  }
}

pub fn foldr3(
  self: List<x>,
  zero_a: a,
  zero_b: b,
  zero_c: c,
  with: fn(x, a, b, c, Scott3<a, b, c, result>) -> result,
  return: Scott3<a, b, c, result>,
) -> result {
  do_foldr3(self, with, return)(zero_a, zero_b, zero_c)
}

pub fn foldl4(
  self: List<x>,
  zero_a: a,
  zero_b: b,
  zero_c: c,
  zero_d: d,
  with: fn(x, a, b, c, d, Scott4<a, b, c, d, result>) -> result,
  return: Scott4<a, b, c, d, result>,
) -> result {
  when self is {
    [] -> return(zero_a, zero_b, zero_c, zero_d)
    [x, ..xs] -> {
      let acc_a, acc_b, acc_c, acc_d <- with(x, zero_a, zero_b, zero_c, zero_d)
      foldl4(xs, acc_a, acc_b, acc_c, acc_d, with, return)
    }
  }
}

pub fn foldr4(
  self: List<x>,
  zero_a: a,
  zero_b: b,
  zero_c: c,
  zero_d: d,
  with: fn(x, a, b, c, d, Scott4<a, b, c, d, result>) -> result,
  return: Scott4<a, b, c, d, result>,
) -> result {
  do_foldr4(self, with, return)(zero_a, zero_b, zero_c, zero_d)
}

pub fn foldl5(
  self: List<x>,
  zero_a: a,
  zero_b: b,
  zero_c: c,
  zero_d: d,
  zero_e: e,
  with: fn(x, a, b, c, d, e, Scott5<a, b, c, d, e, result>) -> result,
  return: Scott5<a, b, c, d, e, result>,
) -> result {
  when self is {
    [] -> return(zero_a, zero_b, zero_c, zero_d, zero_e)
    [x, ..xs] -> {
      let
        acc_a,
        acc_b,
        acc_c,
        acc_d,
        acc_e,
      <- with(x, zero_a, zero_b, zero_c, zero_d, zero_e)
      foldl5(xs, acc_a, acc_b, acc_c, acc_d, acc_e, with, return)
    }
  }
}

pub fn foldr5(
  self: List<x>,
  zero_a: a,
  zero_b: b,
  zero_c: c,
  zero_d: d,
  zero_e: e,
  with: fn(x, a, b, c, d, e, Scott5<a, b, c, d, e, result>) -> result,
  return: Scott5<a, b, c, d, e, result>,
) -> result {
  do_foldr5(self, with, return)(zero_a, zero_b, zero_c, zero_d, zero_e)
}

pub fn foldl6(
  self: List<x>,
  zero_a: a,
  zero_b: b,
  zero_c: c,
  zero_d: d,
  zero_e: e,
  zero_f: f,
  with: fn(x, a, b, c, d, e, f, Scott6<a, b, c, d, e, f, result>) -> result,
  return: Scott6<a, b, c, d, e, f, result>,
) -> result {
  when self is {
    [] -> return(zero_a, zero_b, zero_c, zero_d, zero_e, zero_f)
    [x, ..xs] -> {
      let
        acc_a,
        acc_b,
        acc_c,
        acc_d,
        acc_e,
        acc_f,
      <- with(x, zero_a, zero_b, zero_c, zero_d, zero_e, zero_f)
      foldl6(xs, acc_a, acc_b, acc_c, acc_d, acc_e, acc_f, with, return)
    }
  }
}

pub fn foldr6(
  self: List<x>,
  zero_a: a,
  zero_b: b,
  zero_c: c,
  zero_d: d,
  zero_e: e,
  zero_f: f,
  with: fn(x, a, b, c, d, e, f, Scott6<a, b, c, d, e, f, result>) -> result,
  return: Scott6<a, b, c, d, e, f, result>,
) -> result {
  do_foldr6(self, with, return)(zero_a, zero_b, zero_c, zero_d, zero_e, zero_f)
}

// --- FINDS -------------------------------------------------------------------

fn do_find2(
  self: List<x>,
  a_so_far: Option<x>,
  b_so_far: Option<x>,
  predicate_a: fn(x) -> Bool,
  predicate_b: fn(x) -> Bool,
  return: Scott2<Option<x>, Option<x>, result>,
) -> result {
  when self is {
    [] -> return(a_so_far, b_so_far)
    [x, ..xs] ->
      when a_so_far is {
        None ->
          if predicate_a(x) {
            when b_so_far is {
              None -> return(Some(x), list.find(xs, predicate_b))
              Some(_) -> return(Some(x), b_so_far)
            }
          } else {
            when b_so_far is {
              None ->
                if predicate_b(x) {
                  return(list.find(xs, predicate_a), Some(x))
                } else {
                  do_find2(
                    xs,
                    a_so_far,
                    b_so_far,
                    predicate_a,
                    predicate_b,
                    return,
                  )
                }
              Some(_) -> return(list.find(xs, predicate_a), b_so_far)
            }
          }
        Some(_) ->
          if predicate_b(x) {
            return(a_so_far, Some(x))
          } else {
            return(a_so_far, list.find(xs, predicate_b))
          }
      }
  }
}

fn do_find3(
  self: List<x>,
  a_so_far: Option<x>,
  b_so_far: Option<x>,
  c_so_far: Option<x>,
  predicate_a: fn(x) -> Bool,
  predicate_b: fn(x) -> Bool,
  predicate_c: fn(x) -> Bool,
  return: Scott3<Option<x>, Option<x>, Option<x>, result>,
) -> result {
  when self is {
    [] -> return(a_so_far, b_so_far, c_so_far)
    [x, ..xs] -> {
      let a_found_as =
        fn(found_a) {
          let
            m_b,
            m_c,
          <- do_find2(xs, b_so_far, c_so_far, predicate_b, predicate_c)
          return(found_a, m_b, m_c)
        }
      let b_found_as =
        fn(found_b) {
          let
            m_a,
            m_c,
          <- do_find2(xs, a_so_far, c_so_far, predicate_a, predicate_c)
          return(m_a, found_b, m_c)
        }
      let c_found_as =
        fn(found_c) {
          let
            m_a,
            m_b,
          <- do_find2(xs, a_so_far, b_so_far, predicate_a, predicate_b)
          return(m_a, m_b, found_c)
        }
      when a_so_far is {
        None ->
          if predicate_a(x) {
            a_found_as(Some(x))
          } else {
            when b_so_far is {
              None ->
                if predicate_b(x) {
                  b_found_as(Some(x))
                } else {
                  when c_so_far is {
                    None ->
                      if predicate_c(x) {
                        c_found_as(Some(x))
                      } else {
                        do_find3(
                          xs,
                          a_so_far,
                          b_so_far,
                          c_so_far,
                          predicate_a,
                          predicate_b,
                          predicate_c,
                          return,
                        )
                      }
                    Some(_) -> c_found_as(c_so_far)
                  }
                }
              Some(_) -> b_found_as(b_so_far)
            }
          }
        Some(_) -> a_found_as(a_so_far)
      }
    }
  }
}

fn do_find4(
  self: List<x>,
  a_so_far: Option<x>,
  b_so_far: Option<x>,
  c_so_far: Option<x>,
  d_so_far: Option<x>,
  predicate_a: fn(x) -> Bool,
  predicate_b: fn(x) -> Bool,
  predicate_c: fn(x) -> Bool,
  predicate_d: fn(x) -> Bool,
  return: Scott4<Option<x>, Option<x>, Option<x>, Option<x>, result>,
) -> result {
  when self is {
    [] -> return(a_so_far, b_so_far, c_so_far, d_so_far)
    [x, ..xs] -> {
      let a_found_as =
        fn(found_a) {
          let
            m_b,
            m_c,
            m_d,
          <-
            do_find3(
              xs,
              b_so_far,
              c_so_far,
              d_so_far,
              predicate_b,
              predicate_c,
              predicate_d,
            )
          return(found_a, m_b, m_c, m_d)
        }
      let b_found_as =
        fn(found_b) {
          let
            m_a,
            m_c,
            m_d,
          <-
            do_find3(
              xs,
              a_so_far,
              c_so_far,
              d_so_far,
              predicate_a,
              predicate_c,
              predicate_d,
            )
          return(m_a, found_b, m_c, m_d)
        }
      let c_found_as =
        fn(found_c) {
          let
            m_a,
            m_b,
            m_d,
          <-
            do_find3(
              xs,
              a_so_far,
              b_so_far,
              d_so_far,
              predicate_a,
              predicate_b,
              predicate_d,
            )
          return(m_a, m_b, found_c, m_d)
        }
      let d_found_as =
        fn(found_d) {
          let
            m_a,
            m_b,
            m_c,
          <-
            do_find3(
              xs,
              a_so_far,
              b_so_far,
              c_so_far,
              predicate_a,
              predicate_b,
              predicate_c,
            )
          return(m_a, m_b, m_c, found_d)
        }
      when a_so_far is {
        None ->
          if predicate_a(x) {
            a_found_as(Some(x))
          } else {
            when b_so_far is {
              None ->
                if predicate_b(x) {
                  b_found_as(Some(x))
                } else {
                  when c_so_far is {
                    None ->
                      if predicate_c(x) {
                        c_found_as(Some(x))
                      } else {
                        when d_so_far is {
                          None ->
                            if predicate_d(x) {
                              d_found_as(Some(x))
                            } else {
                              do_find4(
                                xs,
                                a_so_far,
                                b_so_far,
                                c_so_far,
                                d_so_far,
                                predicate_a,
                                predicate_b,
                                predicate_c,
                                predicate_d,
                                return,
                              )
                            }
                          Some(_) -> d_found_as(d_so_far)
                        }
                      }
                    Some(_) -> c_found_as(c_so_far)
                  }
                }
              Some(_) -> b_found_as(b_so_far)
            }
          }
        Some(_) -> a_found_as(a_so_far)
      }
    }
  }
}

fn do_find5(
  self: List<x>,
  a_so_far: Option<x>,
  b_so_far: Option<x>,
  c_so_far: Option<x>,
  d_so_far: Option<x>,
  e_so_far: Option<x>,
  predicate_a: fn(x) -> Bool,
  predicate_b: fn(x) -> Bool,
  predicate_c: fn(x) -> Bool,
  predicate_d: fn(x) -> Bool,
  predicate_e: fn(x) -> Bool,
  return: Scott5<Option<x>, Option<x>, Option<x>, Option<x>, Option<x>, result>,
) -> result {
  when self is {
    [] -> return(a_so_far, b_so_far, c_so_far, d_so_far, e_so_far)
    [x, ..xs] -> {
      let a_found_as =
        fn(found_a) {
          let
            m_b,
            m_c,
            m_d,
            m_e,
          <-
            do_find4(
              xs,
              b_so_far,
              c_so_far,
              d_so_far,
              e_so_far,
              predicate_b,
              predicate_c,
              predicate_d,
              predicate_e,
            )
          return(found_a, m_b, m_c, m_d, m_e)
        }
      let b_found_as =
        fn(found_b) {
          let
            m_a,
            m_c,
            m_d,
            m_e,
          <-
            do_find4(
              xs,
              a_so_far,
              c_so_far,
              d_so_far,
              e_so_far,
              predicate_a,
              predicate_c,
              predicate_d,
              predicate_e,
            )
          return(m_a, found_b, m_c, m_d, m_e)
        }
      let c_found_as =
        fn(found_c) {
          let
            m_a,
            m_b,
            m_d,
            m_e,
          <-
            do_find4(
              xs,
              a_so_far,
              b_so_far,
              d_so_far,
              e_so_far,
              predicate_a,
              predicate_b,
              predicate_d,
              predicate_e,
            )
          return(m_a, m_b, found_c, m_d, m_e)
        }
      let d_found_as =
        fn(found_d) {
          let
            m_a,
            m_b,
            m_c,
            m_e,
          <-
            do_find4(
              xs,
              a_so_far,
              b_so_far,
              c_so_far,
              e_so_far,
              predicate_a,
              predicate_b,
              predicate_c,
              predicate_e,
            )
          return(m_a, m_b, m_c, found_d, m_e)
        }
      let e_found_as =
        fn(found_e) {
          let
            m_a,
            m_b,
            m_c,
            m_d,
          <-
            do_find4(
              xs,
              a_so_far,
              b_so_far,
              c_so_far,
              d_so_far,
              predicate_a,
              predicate_b,
              predicate_c,
              predicate_d,
            )
          return(m_a, m_b, m_c, m_d, found_e)
        }
      when a_so_far is {
        None ->
          if predicate_a(x) {
            a_found_as(Some(x))
          } else {
            when b_so_far is {
              None ->
                if predicate_b(x) {
                  b_found_as(Some(x))
                } else {
                  when c_so_far is {
                    None ->
                      if predicate_c(x) {
                        c_found_as(Some(x))
                      } else {
                        when d_so_far is {
                          None ->
                            if predicate_d(x) {
                              d_found_as(Some(x))
                            } else {
                              when e_so_far is {
                                None ->
                                  if predicate_e(x) {
                                    e_found_as(Some(x))
                                  } else {
                                    do_find5(
                                      xs,
                                      a_so_far,
                                      b_so_far,
                                      c_so_far,
                                      d_so_far,
                                      e_so_far,
                                      predicate_a,
                                      predicate_b,
                                      predicate_c,
                                      predicate_d,
                                      predicate_e,
                                      return,
                                    )
                                  }
                                Some(_) -> e_found_as(e_so_far)
                              }
                            }
                          Some(_) -> d_found_as(d_so_far)
                        }
                      }
                    Some(_) -> c_found_as(c_so_far)
                  }
                }
              Some(_) -> b_found_as(b_so_far)
            }
          }
        Some(_) -> a_found_as(a_so_far)
      }
    }
  }
}

fn do_find6(
  self: List<x>,
  a_so_far: Option<x>,
  b_so_far: Option<x>,
  c_so_far: Option<x>,
  d_so_far: Option<x>,
  e_so_far: Option<x>,
  f_so_far: Option<x>,
  predicate_a: fn(x) -> Bool,
  predicate_b: fn(x) -> Bool,
  predicate_c: fn(x) -> Bool,
  predicate_d: fn(x) -> Bool,
  predicate_e: fn(x) -> Bool,
  predicate_f: fn(x) -> Bool,
  return: Scott6<
    Option<x>,
    Option<x>,
    Option<x>,
    Option<x>,
    Option<x>,
    Option<x>,
    result,
  >,
) -> result {
  when self is {
    [] -> return(a_so_far, b_so_far, c_so_far, d_so_far, e_so_far, f_so_far)
    [x, ..xs] -> {
      let a_found_as =
        fn(found_a) {
          let
            m_b,
            m_c,
            m_d,
            m_e,
            m_f,
          <-
            do_find5(
              xs,
              b_so_far,
              c_so_far,
              d_so_far,
              e_so_far,
              f_so_far,
              predicate_b,
              predicate_c,
              predicate_d,
              predicate_e,
              predicate_f,
            )
          return(found_a, m_b, m_c, m_d, m_e, m_f)
        }
      let b_found_as =
        fn(found_b) {
          let
            m_a,
            m_c,
            m_d,
            m_e,
            m_f,
          <-
            do_find5(
              xs,
              a_so_far,
              c_so_far,
              d_so_far,
              e_so_far,
              f_so_far,
              predicate_a,
              predicate_c,
              predicate_d,
              predicate_e,
              predicate_f,
            )
          return(m_a, found_b, m_c, m_d, m_e, m_f)
        }
      let c_found_as =
        fn(found_c) {
          let
            m_a,
            m_b,
            m_d,
            m_e,
            m_f,
          <-
            do_find5(
              xs,
              a_so_far,
              b_so_far,
              d_so_far,
              e_so_far,
              f_so_far,
              predicate_a,
              predicate_b,
              predicate_d,
              predicate_e,
              predicate_f,
            )
          return(m_a, m_b, found_c, m_d, m_e, m_f)
        }
      let d_found_as =
        fn(found_d) {
          let
            m_a,
            m_b,
            m_c,
            m_e,
            m_f,
          <-
            do_find5(
              xs,
              a_so_far,
              b_so_far,
              c_so_far,
              e_so_far,
              f_so_far,
              predicate_a,
              predicate_b,
              predicate_c,
              predicate_e,
              predicate_f,
            )
          return(m_a, m_b, m_c, found_d, m_e, m_f)
        }
      let e_found_as =
        fn(found_e) {
          let
            m_a,
            m_b,
            m_c,
            m_d,
            m_f,
          <-
            do_find5(
              xs,
              a_so_far,
              b_so_far,
              c_so_far,
              d_so_far,
              f_so_far,
              predicate_a,
              predicate_b,
              predicate_c,
              predicate_d,
              predicate_f,
            )
          return(m_a, m_b, m_c, m_d, found_e, m_f)
        }
      let f_found_as =
        fn(found_f) {
          let
            m_a,
            m_b,
            m_c,
            m_d,
            m_e,
          <-
            do_find5(
              xs,
              a_so_far,
              b_so_far,
              c_so_far,
              d_so_far,
              e_so_far,
              predicate_a,
              predicate_b,
              predicate_c,
              predicate_d,
              predicate_e,
            )
          return(m_a, m_b, m_c, m_d, m_e, found_f)
        }
      when a_so_far is {
        None ->
          if predicate_a(x) {
            a_found_as(Some(x))
          } else {
            when b_so_far is {
              None ->
                if predicate_b(x) {
                  b_found_as(Some(x))
                } else {
                  when c_so_far is {
                    None ->
                      if predicate_c(x) {
                        c_found_as(Some(x))
                      } else {
                        when d_so_far is {
                          None ->
                            if predicate_d(x) {
                              d_found_as(Some(x))
                            } else {
                              when e_so_far is {
                                None ->
                                  if predicate_e(x) {
                                    e_found_as(Some(x))
                                  } else {
                                    when f_so_far is {
                                      None ->
                                        if predicate_f(x) {
                                          f_found_as(Some(x))
                                        } else {
                                          do_find6(
                                            xs,
                                            a_so_far,
                                            b_so_far,
                                            c_so_far,
                                            d_so_far,
                                            e_so_far,
                                            f_so_far,
                                            predicate_a,
                                            predicate_b,
                                            predicate_c,
                                            predicate_d,
                                            predicate_e,
                                            predicate_f,
                                            return,
                                          )
                                        }
                                      Some(_) -> f_found_as(f_so_far)
                                    }
                                  }
                                Some(_) -> e_found_as(e_so_far)
                              }
                            }
                          Some(_) -> d_found_as(d_so_far)
                        }
                      }
                    Some(_) -> c_found_as(c_so_far)
                  }
                }
              Some(_) -> b_found_as(b_so_far)
            }
          }
        Some(_) -> a_found_as(a_so_far)
      }
    }
  }
}

pub fn find2(
  self: List<x>,
  predicate_a: fn(x) -> Bool,
  predicate_b: fn(x) -> Bool,
  return: Scott2<Option<x>, Option<x>, result>,
) -> result {
  do_find2(self, None, None, predicate_a, predicate_b, return)
}

pub fn find3(
  self: List<x>,
  predicate_a: fn(x) -> Bool,
  predicate_b: fn(x) -> Bool,
  predicate_c: fn(x) -> Bool,
  return: Scott3<Option<x>, Option<x>, Option<x>, result>,
) -> result {
  do_find3(
    self,
    None,
    None,
    None,
    predicate_a,
    predicate_b,
    predicate_c,
    return,
  )
}

pub fn find4(
  self: List<x>,
  predicate_a: fn(x) -> Bool,
  predicate_b: fn(x) -> Bool,
  predicate_c: fn(x) -> Bool,
  predicate_d: fn(x) -> Bool,
  return: Scott4<Option<x>, Option<x>, Option<x>, Option<x>, result>,
) -> result {
  do_find4(
    self,
    None,
    None,
    None,
    None,
    predicate_a,
    predicate_b,
    predicate_c,
    predicate_d,
    return,
  )
}

pub fn find5(
  self: List<x>,
  predicate_a: fn(x) -> Bool,
  predicate_b: fn(x) -> Bool,
  predicate_c: fn(x) -> Bool,
  predicate_d: fn(x) -> Bool,
  predicate_e: fn(x) -> Bool,
  return: Scott5<Option<x>, Option<x>, Option<x>, Option<x>, Option<x>, result>,
) -> result {
  do_find5(
    self,
    None,
    None,
    None,
    None,
    None,
    predicate_a,
    predicate_b,
    predicate_c,
    predicate_d,
    predicate_e,
    return,
  )
}

pub fn find6(
  self: List<x>,
  predicate_a: fn(x) -> Bool,
  predicate_b: fn(x) -> Bool,
  predicate_c: fn(x) -> Bool,
  predicate_d: fn(x) -> Bool,
  predicate_e: fn(x) -> Bool,
  predicate_f: fn(x) -> Bool,
  return: Scott6<
    Option<x>,
    Option<x>,
    Option<x>,
    Option<x>,
    Option<x>,
    Option<x>,
    result,
  >,
) -> result {
  do_find6(
    self,
    None,
    None,
    None,
    None,
    None,
    None,
    predicate_a,
    predicate_b,
    predicate_c,
    predicate_d,
    predicate_e,
    predicate_f,
    return,
  )
}

// --- ATS ---------------------------------------------------------------------

fn do_at2(
  self: List<x>,
  a_so_far: Option<x>,
  b_so_far: Option<x>,
  index_a: Int,
  index_b: Int,
  return: Scott2<Option<x>, Option<x>, result>,
) -> result {
  when self is {
    [] -> return(a_so_far, b_so_far)
    [x, ..xs] ->
      when a_so_far is {
        None ->
          if index_a == 0 {
            when b_so_far is {
              None -> return(Some(x), list.at(xs, index_b - 1))
              Some(_) -> return(Some(x), b_so_far)
            }
          } else {
            when b_so_far is {
              None ->
                if index_b == 0 {
                  return(list.at(xs, index_a - 1), Some(x))
                } else {
                  do_at2(
                    xs,
                    a_so_far,
                    b_so_far,
                    index_a - 1,
                    index_b - 1,
                    return,
                  )
                }
              Some(_) -> return(list.at(xs, index_a - 1), b_so_far)
            }
          }
        Some(_) ->
          if index_b == 0 {
            return(a_so_far, Some(x))
          } else {
            return(a_so_far, list.at(xs, index_b - 1))
          }
      }
  }
}

fn do_at3(
  self: List<x>,
  a_so_far: Option<x>,
  b_so_far: Option<x>,
  c_so_far: Option<x>,
  index_a: Int,
  index_b: Int,
  index_c: Int,
  return: Scott3<Option<x>, Option<x>, Option<x>, result>,
) -> result {
  when self is {
    [] -> return(a_so_far, b_so_far, c_so_far)
    [x, ..xs] -> {
      let a_found_as =
        fn(found_a) {
          let
            m_b,
            m_c,
          <- do_at2(xs, b_so_far, c_so_far, index_b - 1, index_c - 1)
          return(found_a, m_b, m_c)
        }
      let b_found_as =
        fn(found_b) {
          let
            m_a,
            m_c,
          <- do_at2(xs, a_so_far, c_so_far, index_a - 1, index_c - 1)
          return(m_a, found_b, m_c)
        }
      let c_found_as =
        fn(found_c) {
          let
            m_a,
            m_b,
          <- do_at2(xs, a_so_far, b_so_far, index_a - 1, index_b - 1)
          return(m_a, m_b, found_c)
        }
      when a_so_far is {
        None ->
          if index_a == 0 {
            a_found_as(Some(x))
          } else {
            when b_so_far is {
              None ->
                if index_b == 0 {
                  b_found_as(Some(x))
                } else {
                  when c_so_far is {
                    None ->
                      if index_c == 0 {
                        c_found_as(Some(x))
                      } else {
                        do_at3(
                          xs,
                          a_so_far,
                          b_so_far,
                          c_so_far,
                          index_a - 1,
                          index_b - 1,
                          index_c - 1,
                          return,
                        )
                      }
                    Some(_) -> c_found_as(c_so_far)
                  }
                }
              Some(_) -> b_found_as(b_so_far)
            }
          }
        Some(_) -> a_found_as(a_so_far)
      }
    }
  }
}

fn do_at4(
  self: List<x>,
  a_so_far: Option<x>,
  b_so_far: Option<x>,
  c_so_far: Option<x>,
  d_so_far: Option<x>,
  index_a: Int,
  index_b: Int,
  index_c: Int,
  index_d: Int,
  return: Scott4<Option<x>, Option<x>, Option<x>, Option<x>, result>,
) -> result {
  when self is {
    [] -> return(a_so_far, b_so_far, c_so_far, d_so_far)
    [x, ..xs] -> {
      let a_found_as =
        fn(found_a) {
          let
            m_b,
            m_c,
            m_d,
          <-
            do_at3(
              xs,
              b_so_far,
              c_so_far,
              d_so_far,
              index_b - 1,
              index_c - 1,
              index_d - 1,
            )
          return(found_a, m_b, m_c, m_d)
        }
      let b_found_as =
        fn(found_b) {
          let
            m_a,
            m_c,
            m_d,
          <-
            do_at3(
              xs,
              a_so_far,
              c_so_far,
              d_so_far,
              index_a - 1,
              index_c - 1,
              index_d - 1,
            )
          return(m_a, found_b, m_c, m_d)
        }
      let c_found_as =
        fn(found_c) {
          let
            m_a,
            m_b,
            m_d,
          <-
            do_at3(
              xs,
              a_so_far,
              b_so_far,
              d_so_far,
              index_a - 1,
              index_b - 1,
              index_d - 1,
            )
          return(m_a, m_b, found_c, m_d)
        }
      let d_found_as =
        fn(found_d) {
          let
            m_a,
            m_b,
            m_c,
          <-
            do_at3(
              xs,
              a_so_far,
              b_so_far,
              c_so_far,
              index_a - 1,
              index_b - 1,
              index_c - 1,
            )
          return(m_a, m_b, m_c, found_d)
        }
      when a_so_far is {
        None ->
          if index_a == 0 {
            a_found_as(Some(x))
          } else {
            when b_so_far is {
              None ->
                if index_b == 0 {
                  b_found_as(Some(x))
                } else {
                  when c_so_far is {
                    None ->
                      if index_c == 0 {
                        c_found_as(Some(x))
                      } else {
                        when d_so_far is {
                          None ->
                            if index_d == 0 {
                              d_found_as(Some(x))
                            } else {
                              do_at4(
                                xs,
                                a_so_far,
                                b_so_far,
                                c_so_far,
                                d_so_far,
                                index_a - 1,
                                index_b - 1,
                                index_c - 1,
                                index_d - 1,
                                return,
                              )
                            }
                          Some(_) -> d_found_as(d_so_far)
                        }
                      }
                    Some(_) -> c_found_as(c_so_far)
                  }
                }
              Some(_) -> b_found_as(b_so_far)
            }
          }
        Some(_) -> a_found_as(a_so_far)
      }
    }
  }
}

fn do_at5(
  self: List<x>,
  a_so_far: Option<x>,
  b_so_far: Option<x>,
  c_so_far: Option<x>,
  d_so_far: Option<x>,
  e_so_far: Option<x>,
  index_a: Int,
  index_b: Int,
  index_c: Int,
  index_d: Int,
  index_e: Int,
  return: Scott5<Option<x>, Option<x>, Option<x>, Option<x>, Option<x>, result>,
) -> result {
  when self is {
    [] -> return(a_so_far, b_so_far, c_so_far, d_so_far, e_so_far)
    [x, ..xs] -> {
      let a_found_as =
        fn(found_a) {
          let
            m_b,
            m_c,
            m_d,
            m_e,
          <-
            do_at4(
              xs,
              b_so_far,
              c_so_far,
              d_so_far,
              e_so_far,
              index_b - 1,
              index_c - 1,
              index_d - 1,
              index_e - 1,
            )
          return(found_a, m_b, m_c, m_d, m_e)
        }
      let b_found_as =
        fn(found_b) {
          let
            m_a,
            m_c,
            m_d,
            m_e,
          <-
            do_at4(
              xs,
              a_so_far,
              c_so_far,
              d_so_far,
              e_so_far,
              index_a - 1,
              index_c - 1,
              index_d - 1,
              index_e - 1,
            )
          return(m_a, found_b, m_c, m_d, m_e)
        }
      let c_found_as =
        fn(found_c) {
          let
            m_a,
            m_b,
            m_d,
            m_e,
          <-
            do_at4(
              xs,
              a_so_far,
              b_so_far,
              d_so_far,
              e_so_far,
              index_a - 1,
              index_b - 1,
              index_d - 1,
              index_e - 1,
            )
          return(m_a, m_b, found_c, m_d, m_e)
        }
      let d_found_as =
        fn(found_d) {
          let
            m_a,
            m_b,
            m_c,
            m_e,
          <-
            do_at4(
              xs,
              a_so_far,
              b_so_far,
              c_so_far,
              e_so_far,
              index_a - 1,
              index_b - 1,
              index_c - 1,
              index_e - 1,
            )
          return(m_a, m_b, m_c, found_d, m_e)
        }
      let e_found_as =
        fn(found_e) {
          let
            m_a,
            m_b,
            m_c,
            m_d,
          <-
            do_at4(
              xs,
              a_so_far,
              b_so_far,
              c_so_far,
              d_so_far,
              index_a - 1,
              index_b - 1,
              index_c - 1,
              index_d - 1,
            )
          return(m_a, m_b, m_c, m_d, found_e)
        }
      when a_so_far is {
        None ->
          if index_a == 0 {
            a_found_as(Some(x))
          } else {
            when b_so_far is {
              None ->
                if index_b == 0 {
                  b_found_as(Some(x))
                } else {
                  when c_so_far is {
                    None ->
                      if index_c == 0 {
                        c_found_as(Some(x))
                      } else {
                        when d_so_far is {
                          None ->
                            if index_d == 0 {
                              d_found_as(Some(x))
                            } else {
                              when e_so_far is {
                                None ->
                                  if index_e == 0 {
                                    e_found_as(Some(x))
                                  } else {
                                    do_at5(
                                      xs,
                                      a_so_far,
                                      b_so_far,
                                      c_so_far,
                                      d_so_far,
                                      e_so_far,
                                      index_a - 1,
                                      index_b - 1,
                                      index_c - 1,
                                      index_d - 1,
                                      index_e - 1,
                                      return,
                                    )
                                  }
                                Some(_) -> e_found_as(e_so_far)
                              }
                            }
                          Some(_) -> d_found_as(d_so_far)
                        }
                      }
                    Some(_) -> c_found_as(c_so_far)
                  }
                }
              Some(_) -> b_found_as(b_so_far)
            }
          }
        Some(_) -> a_found_as(a_so_far)
      }
    }
  }
}

fn do_at6(
  self: List<x>,
  a_so_far: Option<x>,
  b_so_far: Option<x>,
  c_so_far: Option<x>,
  d_so_far: Option<x>,
  e_so_far: Option<x>,
  f_so_far: Option<x>,
  index_a: Int,
  index_b: Int,
  index_c: Int,
  index_d: Int,
  index_e: Int,
  index_f: Int,
  return: Scott6<
    Option<x>,
    Option<x>,
    Option<x>,
    Option<x>,
    Option<x>,
    Option<x>,
    result,
  >,
) -> result {
  when self is {
    [] -> return(a_so_far, b_so_far, c_so_far, d_so_far, e_so_far, f_so_far)
    [x, ..xs] -> {
      let a_found_as =
        fn(found_a) {
          let
            m_b,
            m_c,
            m_d,
            m_e,
            m_f,
          <-
            do_at5(
              xs,
              b_so_far,
              c_so_far,
              d_so_far,
              e_so_far,
              f_so_far,
              index_b - 1,
              index_c - 1,
              index_d - 1,
              index_e - 1,
              index_f - 1,
            )
          return(found_a, m_b, m_c, m_d, m_e, m_f)
        }
      let b_found_as =
        fn(found_b) {
          let
            m_a,
            m_c,
            m_d,
            m_e,
            m_f,
          <-
            do_at5(
              xs,
              a_so_far,
              c_so_far,
              d_so_far,
              e_so_far,
              f_so_far,
              index_a - 1,
              index_c - 1,
              index_d - 1,
              index_e - 1,
              index_f - 1,
            )
          return(m_a, found_b, m_c, m_d, m_e, m_f)
        }
      let c_found_as =
        fn(found_c) {
          let
            m_a,
            m_b,
            m_d,
            m_e,
            m_f,
          <-
            do_at5(
              xs,
              a_so_far,
              b_so_far,
              d_so_far,
              e_so_far,
              f_so_far,
              index_a - 1,
              index_b - 1,
              index_d - 1,
              index_e - 1,
              index_f - 1,
            )
          return(m_a, m_b, found_c, m_d, m_e, m_f)
        }
      let d_found_as =
        fn(found_d) {
          let
            m_a,
            m_b,
            m_c,
            m_e,
            m_f,
          <-
            do_at5(
              xs,
              a_so_far,
              b_so_far,
              c_so_far,
              e_so_far,
              f_so_far,
              index_a - 1,
              index_b - 1,
              index_c - 1,
              index_e - 1,
              index_f - 1,
            )
          return(m_a, m_b, m_c, found_d, m_e, m_f)
        }
      let e_found_as =
        fn(found_e) {
          let
            m_a,
            m_b,
            m_c,
            m_d,
            m_f,
          <-
            do_at5(
              xs,
              a_so_far,
              b_so_far,
              c_so_far,
              d_so_far,
              f_so_far,
              index_a - 1,
              index_b - 1,
              index_c - 1,
              index_d - 1,
              index_f - 1,
            )
          return(m_a, m_b, m_c, m_d, found_e, m_f)
        }
      let f_found_as =
        fn(found_f) {
          let
            m_a,
            m_b,
            m_c,
            m_d,
            m_e,
          <-
            do_at5(
              xs,
              a_so_far,
              b_so_far,
              c_so_far,
              d_so_far,
              e_so_far,
              index_a - 1,
              index_b - 1,
              index_c - 1,
              index_d - 1,
              index_e - 1,
            )
          return(m_a, m_b, m_c, m_d, m_e, found_f)
        }
      when a_so_far is {
        None ->
          if index_a == 0 {
            a_found_as(Some(x))
          } else {
            when b_so_far is {
              None ->
                if index_b == 0 {
                  b_found_as(Some(x))
                } else {
                  when c_so_far is {
                    None ->
                      if index_c == 0 {
                        c_found_as(Some(x))
                      } else {
                        when d_so_far is {
                          None ->
                            if index_d == 0 {
                              d_found_as(Some(x))
                            } else {
                              when e_so_far is {
                                None ->
                                  if index_e == 0 {
                                    e_found_as(Some(x))
                                  } else {
                                    when f_so_far is {
                                      None ->
                                        if index_f == 0 {
                                          f_found_as(Some(x))
                                        } else {
                                          do_at6(
                                            xs,
                                            a_so_far,
                                            b_so_far,
                                            c_so_far,
                                            d_so_far,
                                            e_so_far,
                                            f_so_far,
                                            index_a - 1,
                                            index_b - 1,
                                            index_c - 1,
                                            index_d - 1,
                                            index_e - 1,
                                            index_f - 1,
                                            return,
                                          )
                                        }
                                      Some(_) -> f_found_as(f_so_far)
                                    }
                                  }
                                Some(_) -> e_found_as(e_so_far)
                              }
                            }
                          Some(_) -> d_found_as(d_so_far)
                        }
                      }
                    Some(_) -> c_found_as(c_so_far)
                  }
                }
              Some(_) -> b_found_as(b_so_far)
            }
          }
        Some(_) -> a_found_as(a_so_far)
      }
    }
  }
}

/// Unit tests suggest using `at2` is not very different from using `list.at`
/// twice.
pub fn at2(
  self: List<x>,
  index_a: Int,
  index_b: Int,
  return: Scott2<Option<x>, Option<x>, result>,
) -> result {
  do_at2(self, None, None, index_a, index_b, return)
}

/// Unit tests suggest using `at3` is not very different from using `list.at`
/// three times.
pub fn at3(
  self: List<x>,
  index_a: Int,
  index_b: Int,
  index_c: Int,
  return: Scott3<Option<x>, Option<x>, Option<x>, result>,
) -> result {
  do_at3(self, None, None, None, index_a, index_b, index_c, return)
}

/// `at4` and up are more performant than multiple calls to `list.at`.
pub fn at4(
  self: List<x>,
  index_a: Int,
  index_b: Int,
  index_c: Int,
  index_d: Int,
  return: Scott4<Option<x>, Option<x>, Option<x>, Option<x>, result>,
) -> result {
  do_at4(
    self,
    None,
    None,
    None,
    None,
    index_a,
    index_b,
    index_c,
    index_d,
    return,
  )
}

pub fn at5(
  self: List<x>,
  index_a: Int,
  index_b: Int,
  index_c: Int,
  index_d: Int,
  index_e: Int,
  return: Scott5<Option<x>, Option<x>, Option<x>, Option<x>, Option<x>, result>,
) -> result {
  do_at5(
    self,
    None,
    None,
    None,
    None,
    None,
    index_a,
    index_b,
    index_c,
    index_d,
    index_e,
    return,
  )
}

pub fn at6(
  self: List<x>,
  index_a: Int,
  index_b: Int,
  index_c: Int,
  index_d: Int,
  index_e: Int,
  index_f: Int,
  return: Scott6<
    Option<x>,
    Option<x>,
    Option<x>,
    Option<x>,
    Option<x>,
    Option<x>,
    result,
  >,
) -> result {
  do_at6(
    self,
    None,
    None,
    None,
    None,
    None,
    None,
    index_a,
    index_b,
    index_c,
    index_d,
    index_e,
    index_f,
    return,
  )
}
