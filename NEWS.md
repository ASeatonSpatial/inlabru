# inlabru 2.1.4.999

* Added a `NEWS.md` file to track changes to the package.

* Added `inla` methods for `predict()` and `generate()` that convert
  `inla` output into `bru` objects before calling the `bru` prediction
  and posterior sample generator.

* Added protection for examples requiring optional packages

# inlabru 2.1.4

* `iinla()` tracks convergence of both fixed and random effects

# inlabru 2.1.3

* Added matrix geom `gg.matrix()`

* Fixed CRAN test issues