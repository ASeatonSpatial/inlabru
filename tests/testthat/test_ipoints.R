local_bru_testthat_setup()

test_that("1D integration points can be generated", {
  local_bru_safe_inla()
  ips <- ipoints(c(0, 10), 3, name = "myDim")

  expect_s3_class(ips, "data.frame")
  expect_equal(nrow(ips), 3)
  expect_equal(ncol(ips), 2)
  expect_equal(names(ips), c("myDim", "weight"))
  expect_equal(as.numeric(ips[1, ]), c(0, 2.5))
  expect_equal(as.numeric(ips[2, ]), c(5, 5))
})


test_that("conversion of 1D mesh to integration points", {
  local_bru_safe_inla()
  mesh <- INLA::inla.mesh.1d(seq(0, 10, by = 1))
  ips <- ipoints(mesh, name = "time")

  expect_s3_class(ips, "data.frame")
  expect_equal(nrow(ips), 11)
  expect_equal(ncol(ips), 2)
  expect_equal(names(ips), c("time", "weight"))
  expect_equal(as.numeric(ips[1, ]), c(0, 0.5))
  expect_equal(as.numeric(ips[5, ]), c(4, 1))
  expect_equal(as.numeric(ips[11, ]), c(10, 0.5))
})

test_that("conversion of SpatialPolygon to integration points", {
  local_bru_safe_inla()
  data(gorillas, package = "inlabru")
  expect_warning(
    ips <- ipoints(gorillas$boundary),
    "Computing integration points from polygon"
  )

  expect_s4_class(ips, "SpatialPointsDataFrame")
  expect_equal(names(ips), "weight")
  expect_equal(colnames(data.frame(ips)), c("weight", "x", "y", "optional"))
  expect_equal(sum(ips$weight), 19.87366, tolerance = lowtol)
})

test_that("conversion of SpatialPolygon to integration points when domain is defined via a mesh", {
  local_bru_safe_inla()
  data(gorillas, package = "inlabru")
  ips <- ipoints(gorillas$boundary, gorillas$mesh)
  expect_warning(
    ips_nodomain <- ipoints(gorillas$boundary),
    "Computing integration points from polygon"
  )

  expect_s4_class(ips, "SpatialPointsDataFrame")
  expect_equal(colnames(data.frame(ips)), c("weight", "x", "y", "optional"))
  expect_equal(sum(ips$weight),
    sum(ips_nodomain$weight),
    tolerance = midtol
  )
})

test_that("conversion of 2D mesh to integration points", {
  local_bru_safe_inla()
  data(gorillas, package = "inlabru")
  ips <- ipoints(gorillas$mesh)

  expect_s4_class(ips, "SpatialPointsDataFrame")
  expect_equal(colnames(data.frame(ips)), c("vertex", "weight", "x", "y", "optional"))
  expect_equal(sum(ips$weight), 27.65967, tolerance = lowtol)
})

test_that("SpatialLinesDataFrame to integration points using grouping parameter", {
  local_bru_safe_inla()
  data(mrsea, package = "inlabru")
  mrsea <- local_mrsea_rebuild_CRS(mrsea, use_km = FALSE)
  expect_warning(
    ips <- ipoints(mrsea$samplers, mrsea$mesh, group = "season"),
    "export to PROJ failed: generic error of unknown origin"
  )

  expect_s4_class(ips, "SpatialPointsDataFrame")
  expect_equal(
    colnames(data.frame(ips)),
    c("weight", "vertex", "season", "x", "y", "coordinateZ", "optional")
  )
  expect_equal(sum(ips$weight) / 2293712, 1, tolerance = midtol)

  data(mrsea, package = "inlabru")
  mrsea <- local_mrsea_rebuild_CRS(mrsea, use_km = TRUE)
  expect_warning(
    ips <- ipoints(mrsea$samplers, mrsea$mesh, group = "season"),
    "export to PROJ failed: generic error of unknown origin"
  )

  expect_s4_class(ips, "SpatialPointsDataFrame")
  expect_equal(
    colnames(data.frame(ips)),
    c("weight", "vertex", "season", "x", "y", "coordinateZ", "optional")
  )
  expect_equal(sum(ips$weight) / 2293.712, 1, tolerance = midtol)
})
