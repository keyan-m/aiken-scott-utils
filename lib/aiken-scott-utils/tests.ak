use aiken/collection/list
use aiken/math
use aiken_scott_utils/list as scott_list

const fold_elems = [2, 3, 4]

const left_acc = math.pow(4, math.pow(3, math.pow(2, 1)))

const right_acc = math.pow(2, math.pow(3, math.pow(4, 1)))

test foldr() {
  let acc0 = list.foldr(fold_elems, 1, fn(x, z0) { math.pow(x, z0) })
  acc0 == right_acc
}

test foldl() {
  let acc0 = list.foldl(fold_elems, 1, fn(x, z0) { math.pow(x, z0) })
  acc0 == left_acc
}

test foldr2() {
  let
    _,
    acc1,
  <-
    list.foldr2(
      fold_elems,
      0,
      1,
      fn(x, _z0, z1, return) { return(0, math.pow(x, z1)) },
    )
  acc1 == right_acc
}

test foldl2() {
  let
    _,
    acc1,
  <-
    list.foldl2(
      fold_elems,
      0,
      1,
      fn(x, _z0, z1, return) { return(0, math.pow(x, z1)) },
    )
  acc1 == left_acc
}

test foldr3() {
  let
    _,
    _,
    acc2,
  <-
    scott_list.foldr3(
      fold_elems,
      0,
      0,
      1,
      fn(x, _z0, _z1, z2, return) { return(0, 0, math.pow(x, z2)) },
    )
  acc2 == right_acc
}

test foldl3() {
  let
    _,
    _,
    acc2,
  <-
    scott_list.foldl3(
      fold_elems,
      0,
      0,
      1,
      fn(x, _z0, _z1, z2, return) { return(0, 0, math.pow(x, z2)) },
    )
  acc2 == left_acc
}

test foldr4() {
  let
    _,
    _,
    _,
    acc3,
  <-
    scott_list.foldr4(
      fold_elems,
      0,
      0,
      0,
      1,
      fn(x, _z0, _z1, _z2, z3, return) { return(0, 0, 0, math.pow(x, z3)) },
    )
  acc3 == right_acc
}

test foldl4() {
  let
    _,
    _,
    _,
    acc3,
  <-
    scott_list.foldl4(
      fold_elems,
      0,
      0,
      0,
      1,
      fn(x, _z0, _z1, _z2, z3, return) { return(0, 0, 0, math.pow(x, z3)) },
    )
  acc3 == left_acc
}

test foldr5() {
  let
    _,
    _,
    _,
    _,
    acc4,
  <-
    scott_list.foldr5(
      fold_elems,
      0,
      0,
      0,
      0,
      1,
      fn(x, _z0, _z1, _z2, _z3, z4, return) {
        return(0, 0, 0, 0, math.pow(x, z4))
      },
    )
  acc4 == right_acc
}

test foldl5() {
  let
    _,
    _,
    _,
    _,
    acc4,
  <-
    scott_list.foldl5(
      fold_elems,
      0,
      0,
      0,
      0,
      1,
      fn(x, _z0, _z1, _z2, _z3, z4, return) {
        return(0, 0, 0, 0, math.pow(x, z4))
      },
    )
  acc4 == left_acc
}

test foldr6() {
  let
    _,
    _,
    _,
    _,
    _,
    acc5,
  <-
    scott_list.foldr6(
      fold_elems,
      0,
      0,
      0,
      0,
      0,
      1,
      fn(x, _z0, _z1, _z2, _z3, _z4, z5, return) {
        return(0, 0, 0, 0, 0, math.pow(x, z5))
      },
    )
  acc5 == right_acc
}

test foldl6() {
  let
    _,
    _,
    _,
    _,
    _,
    acc5,
  <-
    scott_list.foldl6(
      fold_elems,
      0,
      0,
      0,
      0,
      0,
      1,
      fn(x, _z0, _z1, _z2, _z3, _z4, z5, return) {
        return(0, 0, 0, 0, 0, math.pow(x, z5))
      },
    )
  acc5 == left_acc
}

test find() {
  let m_a = list.find([0, 0, 0, 1, 0, 0, 2, 0, 0, 1, 0, 2, 0], fn(x) { x == 1 })
  Some(1) == m_a
}

test find2_ordered() {
  let
    m_a,
    m_b,
  <-
    scott_list.find2(
      [0, 0, 0, 1, 2, 0, 2, 0, 0, 1, 0, 2, 0],
      fn(x) { x == 1 },
      fn(x) { x == 2 },
    )
  and {
    Some(1) == m_a,
    Some(2) == m_b,
  }
}

test find2_unordered() {
  let
    m_a,
    m_b,
  <-
    scott_list.find2(
      [0, 0, 0, 2, 0, 0, 2, 0, 0, 1, 0, 2, 0],
      fn(x) { x == 1 },
      fn(x) { x == 2 },
    )
  and {
    Some(1) == m_a,
    Some(2) == m_b,
  }
}

test find3_ordered() {
  let
    m_a,
    m_b,
    m_c,
  <-
    scott_list.find3(
      [0, 0, 0, 1, 2, 0, 2, 3, 0, 1, 0, 2, 0],
      fn(x) { x == 1 },
      fn(x) { x == 2 },
      fn(x) { x == 3 },
    )
  and {
    Some(1) == m_a,
    Some(2) == m_b,
    Some(3) == m_c,
  }
}

test find3_unordered() {
  let
    m_a,
    m_b,
    m_c,
  <-
    scott_list.find3(
      [0, 3, 0, 2, 0, 0, 2, 0, 0, 1, 0, 2, 0],
      fn(x) { x == 1 },
      fn(x) { x == 2 },
      fn(x) { x == 3 },
    )
  and {
    Some(1) == m_a,
    Some(2) == m_b,
    Some(3) == m_c,
  }
}

test find3_unordered_2() {
  let
    m_a,
    m_b,
    m_c,
  <-
    scott_list.find3(
      [0, 3, 0, 1, 0, 0, 2, 0, 0, 1, 0, 2, 0],
      fn(x) { x == 1 },
      fn(x) { x == 2 },
      fn(x) { x == 3 },
    )
  and {
    Some(1) == m_a,
    Some(2) == m_b,
    Some(3) == m_c,
  }
}

test find4_ordered() {
  let
    m_a,
    m_b,
    m_c,
    m_d,
  <-
    scott_list.find4(
      [0, 0, 0, 1, 2, 0, 2, 3, 0, 1, 0, 2, 0, 4],
      fn(x) { x == 1 },
      fn(x) { x == 2 },
      fn(x) { x == 3 },
      fn(x) { x == 4 },
    )
  and {
    Some(1) == m_a,
    Some(2) == m_b,
    Some(3) == m_c,
    Some(4) == m_d,
  }
}

test find4_unordered() {
  let
    m_a,
    m_b,
    m_c,
    m_d,
  <-
    scott_list.find4(
      [0, 4, 0, 0, 3, 0, 2, 0, 0, 2, 0, 0, 1, 0, 2, 0, 4],
      fn(x) { x == 1 },
      fn(x) { x == 2 },
      fn(x) { x == 3 },
      fn(x) { x == 4 },
    )
  and {
    Some(1) == m_a,
    Some(2) == m_b,
    Some(3) == m_c,
    Some(4) == m_d,
  }
}

test find4_unordered_2() {
  let
    m_a,
    m_b,
    m_c,
    m_d,
  <-
    scott_list.find4(
      [0, 3, 0, 1, 0, 4, 0, 2, 0, 0, 1, 0, 2, 0],
      fn(x) { x == 1 },
      fn(x) { x == 2 },
      fn(x) { x == 3 },
      fn(x) { x == 4 },
    )
  and {
    Some(1) == m_a,
    Some(2) == m_b,
    Some(3) == m_c,
    Some(4) == m_d,
  }
}

test find5_ordered() {
  let
    m_a,
    m_b,
    m_c,
    m_d,
    m_e,
  <-
    scott_list.find5(
      [0, 0, 0, 1, 2, 0, 2, 3, 0, 1, 4, 2, 0, 5],
      fn(x) { x == 1 },
      fn(x) { x == 2 },
      fn(x) { x == 3 },
      fn(x) { x == 4 },
      fn(x) { x == 5 },
    )
  and {
    Some(1) == m_a,
    Some(2) == m_b,
    Some(3) == m_c,
    Some(4) == m_d,
    Some(5) == m_e,
  }
}

test find5_unordered() {
  let
    m_a,
    m_b,
    m_c,
    m_d,
    m_e,
  <-
    scott_list.find5(
      [5, 0, 4, 0, 0, 3, 0, 2, 0, 0, 2, 0, 0, 1, 0, 2, 0, 4],
      fn(x) { x == 1 },
      fn(x) { x == 2 },
      fn(x) { x == 3 },
      fn(x) { x == 4 },
      fn(x) { x == 5 },
    )
  and {
    Some(1) == m_a,
    Some(2) == m_b,
    Some(3) == m_c,
    Some(4) == m_d,
    Some(5) == m_e,
  }
}

test find5_unordered_2() {
  let
    m_a,
    m_b,
    m_c,
    m_d,
    m_e,
  <-
    scott_list.find5(
      [0, 3, 0, 1, 0, 4, 0, 5, 3, 2, 0, 0, 1, 0, 2, 0],
      fn(x) { x == 1 },
      fn(x) { x == 2 },
      fn(x) { x == 3 },
      fn(x) { x == 4 },
      fn(x) { x == 5 },
    )
  and {
    Some(1) == m_a,
    Some(2) == m_b,
    Some(3) == m_c,
    Some(4) == m_d,
    Some(5) == m_e,
  }
}

test find6_ordered() {
  let
    m_a,
    m_b,
    m_c,
    m_d,
    m_e,
    m_f,
  <-
    scott_list.find6(
      [0, 0, 0, 1, 2, 0, 2, 3, 0, 1, 4, 2, 0, 5, 1, 2, 3, 6],
      fn(x) { x == 1 },
      fn(x) { x == 2 },
      fn(x) { x == 3 },
      fn(x) { x == 4 },
      fn(x) { x == 5 },
      fn(x) { x == 6 },
    )
  and {
    Some(1) == m_a,
    Some(2) == m_b,
    Some(3) == m_c,
    Some(4) == m_d,
    Some(5) == m_e,
    Some(6) == m_f,
  }
}

test find6_unordered() {
  let
    m_a,
    m_b,
    m_c,
    m_d,
    m_e,
    m_f,
  <-
    scott_list.find6(
      [7, 0, 6, 5, 0, 4, 0, 0, 3, 0, 2, 0, 0, 2, 0, 0, 1, 0, 2, 0, 4],
      fn(x) { x == 1 },
      fn(x) { x == 2 },
      fn(x) { x == 3 },
      fn(x) { x == 4 },
      fn(x) { x == 5 },
      fn(x) { x == 6 },
    )
  and {
    Some(1) == m_a,
    Some(2) == m_b,
    Some(3) == m_c,
    Some(4) == m_d,
    Some(5) == m_e,
    Some(6) == m_f,
  }
}

test find6_unordered_2() {
  let
    m_a,
    m_b,
    m_c,
    m_d,
    m_e,
    m_f,
  <-
    scott_list.find6(
      [7, 5, 6, 0, 3, 0, 1, 0, 4, 0, 5, 3, 2, 0, 0, 1, 0, 2, 0],
      fn(x) { x == 1 },
      fn(x) { x == 2 },
      fn(x) { x == 3 },
      fn(x) { x == 4 },
      fn(x) { x == 5 },
      fn(x) { x == 6 },
    )
  and {
    Some(1) == m_a,
    Some(2) == m_b,
    Some(3) == m_c,
    Some(4) == m_d,
    Some(5) == m_e,
    Some(6) == m_f,
  }
}

const list_for_at_tests = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14]

test at2_ordered() {
  let m_a, m_b <- scott_list.at2(list_for_at_tests, 0, 14)
  and {
    Some(0) == m_a,
    Some(14) == m_b,
  }
}

test at2_unordered() {
  let m_a, m_b <- scott_list.at2(list_for_at_tests, 14, 0)
  and {
    Some(14) == m_a,
    Some(0) == m_b,
  }
}

test at2_most_cost() {
  let m_a, m_b <- scott_list.at2(list_for_at_tests, 14, 13)
  and {
    Some(14) == m_a,
    Some(13) == m_b,
  }
}

test at2_most_cost_no_scott() {
  let m_a = list.at(list_for_at_tests, 13)
  let m_b = list.at(list_for_at_tests, 14)
  and {
    Some(13) == m_a,
    Some(14) == m_b,
  }
}

test at3_ordered() {
  let m_a, m_b, m_c <- scott_list.at3(list_for_at_tests, 0, 1, 14)
  and {
    Some(0) == m_a,
    Some(1) == m_b,
    Some(14) == m_c,
  }
}

test at3_unordered() {
  let m_a, m_b, m_c <- scott_list.at3(list_for_at_tests, 14, 1, 0)
  and {
    Some(14) == m_a,
    Some(1) == m_b,
    Some(0) == m_c,
  }
}

test at3_most_cost() {
  let m_a, m_b, m_c <- scott_list.at3(list_for_at_tests, 14, 13, 12)
  and {
    Some(14) == m_a,
    Some(13) == m_b,
    Some(12) == m_c,
  }
}

test at3_most_cost_no_scott() {
  let m_a = list.at(list_for_at_tests, 12)
  let m_b = list.at(list_for_at_tests, 13)
  let m_c = list.at(list_for_at_tests, 14)
  and {
    Some(12) == m_a,
    Some(13) == m_b,
    Some(14) == m_c,
  }
}

test at4_ordered() {
  let m_a, m_b, m_c, m_d <- scott_list.at4(list_for_at_tests, 0, 1, 13, 14)
  and {
    Some(0) == m_a,
    Some(1) == m_b,
    Some(13) == m_c,
    Some(14) == m_d,
  }
}

test at4_unordered() {
  let m_a, m_b, m_c, m_d <- scott_list.at4(list_for_at_tests, 14, 13, 1, 0)
  and {
    Some(14) == m_a,
    Some(13) == m_b,
    Some(1) == m_c,
    Some(0) == m_d,
  }
}

test at4_most_cost() {
  let m_a, m_b, m_c, m_d <- scott_list.at4(list_for_at_tests, 14, 13, 12, 11)
  and {
    Some(14) == m_a,
    Some(13) == m_b,
    Some(12) == m_c,
    Some(11) == m_d,
  }
}

test at4_most_cost_no_scott() {
  let m_a = list.at(list_for_at_tests, 11)
  let m_b = list.at(list_for_at_tests, 12)
  let m_c = list.at(list_for_at_tests, 13)
  let m_d = list.at(list_for_at_tests, 14)
  and {
    Some(11) == m_a,
    Some(12) == m_b,
    Some(13) == m_c,
    Some(14) == m_d,
  }
}

test at5_ordered() {
  let
    m_a,
    m_b,
    m_c,
    m_d,
    m_e,
  <- scott_list.at5(list_for_at_tests, 0, 1, 7, 13, 14)
  and {
    Some(0) == m_a,
    Some(1) == m_b,
    Some(7) == m_c,
    Some(13) == m_d,
    Some(14) == m_e,
  }
}

test at5_unordered() {
  let
    m_a,
    m_b,
    m_c,
    m_d,
    m_e,
  <- scott_list.at5(list_for_at_tests, 14, 13, 7, 1, 0)
  and {
    Some(14) == m_a,
    Some(13) == m_b,
    Some(7) == m_c,
    Some(1) == m_d,
    Some(0) == m_e,
  }
}

test at5_most_cost() {
  let
    m_a,
    m_b,
    m_c,
    m_d,
    m_e,
  <- scott_list.at5(list_for_at_tests, 14, 13, 12, 11, 10)
  and {
    Some(14) == m_a,
    Some(13) == m_b,
    Some(12) == m_c,
    Some(11) == m_d,
    Some(10) == m_e,
  }
}

test at5_most_cost_no_scott() {
  let m_a = list.at(list_for_at_tests, 10)
  let m_b = list.at(list_for_at_tests, 11)
  let m_c = list.at(list_for_at_tests, 12)
  let m_d = list.at(list_for_at_tests, 13)
  let m_e = list.at(list_for_at_tests, 14)
  and {
    Some(10) == m_a,
    Some(11) == m_b,
    Some(12) == m_c,
    Some(13) == m_d,
    Some(14) == m_e,
  }
}

test at6_ordered() {
  let
    m_a,
    m_b,
    m_c,
    m_d,
    m_e,
    m_f,
  <- scott_list.at6(list_for_at_tests, 0, 1, 2, 12, 13, 14)
  and {
    Some(0) == m_a,
    Some(1) == m_b,
    Some(2) == m_c,
    Some(12) == m_d,
    Some(13) == m_e,
    Some(14) == m_f,
  }
}

test at6_unordered() {
  let
    m_a,
    m_b,
    m_c,
    m_d,
    m_e,
    m_f,
  <- scott_list.at6(list_for_at_tests, 14, 0, 13, 1, 12, 2)
  and {
    Some(14) == m_a,
    Some(0) == m_b,
    Some(13) == m_c,
    Some(1) == m_d,
    Some(12) == m_e,
    Some(2) == m_f,
  }
}

test at6_most_cost() {
  let
    m_a,
    m_b,
    m_c,
    m_d,
    m_e,
    m_f,
  <- scott_list.at6(list_for_at_tests, 14, 13, 12, 11, 10, 9)
  and {
    Some(14) == m_a,
    Some(13) == m_b,
    Some(12) == m_c,
    Some(11) == m_d,
    Some(10) == m_e,
    Some(9) == m_f,
  }
}

test at6_most_cost_no_scott() {
  let m_a = list.at(list_for_at_tests, 9)
  let m_b = list.at(list_for_at_tests, 10)
  let m_c = list.at(list_for_at_tests, 11)
  let m_d = list.at(list_for_at_tests, 12)
  let m_e = list.at(list_for_at_tests, 13)
  let m_f = list.at(list_for_at_tests, 14)
  and {
    Some(9) == m_a,
    Some(10) == m_b,
    Some(11) == m_c,
    Some(12) == m_d,
    Some(13) == m_e,
    Some(14) == m_f,
  }
}
