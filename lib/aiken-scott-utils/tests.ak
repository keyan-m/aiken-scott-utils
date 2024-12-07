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
    scott_list.foldr2(
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
    scott_list.foldl2(
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
