use aiken_scott_utils/common.{Scott2, Scott3, Scott4, Scott5, Scott6}

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
              None ->
                do_find2(
                  xs,
                  Some(x),
                  b_so_far,
                  predicate_a,
                  predicate_b,
                  return,
                )
              Some(_) -> return(Some(x), b_so_far)
            }
          } else {
            when b_so_far is {
              None ->
                if predicate_b(x) {
                  do_find2(
                    xs,
                    a_so_far,
                    Some(x),
                    predicate_a,
                    predicate_b,
                    return,
                  )
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
              Some(_) ->
                do_find2(
                  xs,
                  a_so_far,
                  b_so_far,
                  predicate_a,
                  predicate_b,
                  return,
                )
            }
          }
        Some(_) ->
          if predicate_b(x) {
            return(a_so_far, Some(x))
          } else {
            do_find2(xs, a_so_far, b_so_far, predicate_a, predicate_b, return)
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
