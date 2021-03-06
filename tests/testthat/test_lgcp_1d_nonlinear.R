local_bru_testthat_setup()

test_that("Mexdolphin: Hazard rate detection function", {
  skip_on_cran()
  local_bru_safe_inla()
  data(mexdolphin, package = "inlabru")

  hr <- function(distance, lsig) {
    1 - exp(-(distance / (exp(lsig)))^-1)
  }

  cmp <- ~ lsig(1) + Intercept(1)
  form <- distance ~ log(hr(distance, lsig)) + Intercept
  ips <- ipoints(INLA::inla.mesh.1d(seq(0, 8, by = 0.1)), name = "distance")
  fit <- lgcp(
    components = cmp,
    mexdolphin$points,
    ips = ips,
    formula = form,
    options = list(
      control.inla = list(int.strategy = "eb"),
      bru_initial = list(lsig = -1)
    )
  )

  #  ggplot(data.frame(distance = c(
  #    mexdolphin$points$distance,
  #    -mexdolphin$points$distance))) +
  #    geom_density(aes(distance, after_stat(count))) +
  #    geom_line(aes(distance, est),
  #              data = data.frame(distance = seq(-8,8, by = 0.01)) %>%
  #                mutate(est = hr(abs(distance),
  #                                fit$summary.fixed["lsig","mean"]) *
  #                         exp(fit$summary.fixed["Intercept","mean"])))
  #
  #  plot(ips$distance, hr(ips$distance, fit$summary.fixed["lsig", "mean"]))

  expect_equal(fit$summary.fixed["lsig", "mean"], 1.038281, tolerance = midtol)
  expect_equal(fit$summary.fixed["lsig", "sd"], 0.5183252, tolerance = midtol)
  expect_equal(fit$summary.fixed["Intercept", "mean"], 2.325408, tolerance = midtol)
  expect_equal(fit$summary.fixed["Intercept", "sd"], 0.2900139, tolerance = midtol)
})


# timings <- function(times = 10) {
#   local_bru_options_set(bru_verbose = FALSE)
#   microbenchmark::microbenchmark(
#     legacy = {
#       local_bru_options_set(bru_linearisation_method = "legacy")
#       fit <- lgcp(
#         components = cmp,
#         mexdolphin$points,
#         ips = ips,
#         formula = form,
#         options = list(control.inla = list(int.strategy = "eb"))
#       )
#     },
#     pandemic = {
#       local_bru_options_set(bru_linearisation_method = "pandemic")
#       fit <- lgcp(
#         components = cmp,
#         mexdolphin$points,
#         ips = ips,
#         formula = form,
#         options = list(control.inla = list(int.strategy = "eb"))
#       )
#     },
#     times = times
#   )
# }
#
# timings(times = 10)
#
# Unit: seconds
# expr      min       lq     mean   median       uq      max neval cld
# legacy 1.447667 1.474479 1.507082 1.496711 1.520239 1.899379   100   b
# pandemic 1.252985 1.271926 1.291995 1.288727 1.307383 1.402191   100  a
