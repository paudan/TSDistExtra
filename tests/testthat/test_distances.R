context('time series distances')

test_that('test TWED distance', {
  expect_equal(TWEDistance(c(5,8,6,4,5,1,4,8,14,4,4), c(4,5,5,4,14,4,4,7,1,8,4,4)), 163.033, tolerance=1e-3)
  expect_equal(TWEDistance(c(5,8,6,4,5,1,4,8,14,4,4), c(4,5,5,4,14,4,4,7)), 82.033, tolerance=1e-3)
  expect_equal(TWEDistance(c(5,8,6,4,5,1,4,8,14,4,4), c(5,8,6,4,5,1,4,8,14,4,4)), 0, tolerance=1e-3)
  expect_equal(TWEDistance(c(5,8,6,4,5,1,4,8,14,4,4), c(5,8,6,4,5,1,4,8,14,4,4)*1.2), 37.36, tolerance=1e-3)
  expect_equal(TWEDistance(c(5,8,6,4,5,1,4,8,14,4,4), c(5,8,6,4,5,1,4,8,14,4,4)*1.5), 200.508, tolerance=1e-3)
  expect_equal(TWEDistance(c(5,8,6,4,5,1,4,8,14,4,4), c(5,8,6,4,5,1,4)), 154.046, tolerance=1e-3)
})

test_that('test MJC distance', {
  expect_equal(MJCDistance(c(5,8,6,4,5,1,4,8,14,4,4), c(4,5,5,4,14,4,4,7,1,8,4,4)), 45.0546, tolerance=1e-3)
  expect_equal(MJCDistance(c(5,8,6,4,5,1,4,8,14,4,4), c(4,5,5,4,14,4,4,7)), 41.83929, tolerance=1e-3)
  expect_equal(MJCDistance(c(5,8,6,4,5,1,4,8,14,4,4), c(5,8,6,4,5,1,4,8,14,4,4)), 0, tolerance=1e-3)
  expect_equal(MJCDistance(c(5,8,6,4,5,1,4,8,14,4,4), c(5,8,6,4,5,1,4,8,14,4,4)*1.2), 19, tolerance=1e-3)
  expect_equal(MJCDistance(c(5,8,6,4,5,1,4,8,14,4,4), c(5,8,6,4,5,1,4,8,14,4,4)*1.5), 59.90748, tolerance=1e-3)
  expect_equal(MJCDistance(c(5,8,6,4,5,1,4,8,14,4,4), c(5,8,6,4,5,1,4)), 0, tolerance=1e-3)
})

test_that('test pruned DTW distance', {
  expect_equal(PrunedDTWDistance(c(5,8,6,4,5,1,4,8,14,4,4), c(4,5,5,4,14,4,4,7,1,8,4,4)), 71, tolerance=1e-3)
  expect_equal(PrunedDTWDistance(c(5,8,6,4,5,1,4,8,14,4,4), c(4,5,5,4,14,4,4,7)), 94, tolerance=1e-3)
  expect_equal(PrunedDTWDistance(c(5,8,6,4,5,1,4,8,14,4,4), c(5,8,6,4,5,1,4,8,14,4,4)), 0, tolerance=1e-3)
  expect_equal(PrunedDTWDistance(c(5,8,6,4,5,1,4,8,14,4,4), c(5,8,6,4,5,1,4,8,14,4,4)*1.2), 19, tolerance=1e-3)
  expect_equal(PrunedDTWDistance(c(5,8,6,4,5,1,4,8,14,4,4), c(5,8,6,4,5,1,4,8,14,4,4)*1.5), 102.75, tolerance=1e-3)
  expect_equal(PrunedDTWDistance(c(5,8,6,4,5,1,4,8,14,4,4), c(5,8,6,4,5,1,4)), 142, tolerance=1e-3)
})