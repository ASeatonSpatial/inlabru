# inlabru (development version)

# inlabru 2.1.15

* New options system

* New faster linearisation method

* New line search method to make the nonlinear inla iterations robust

# inlabru 2.1.14.901

* Method for updating old stored estimation objects

* System for supplying mappings between latent models and evaluated effects
  via `bru_mapper` objects

# inlabru 2.1.14.900

* Improved factor support; Either as "contrast with the 1st level", via the
  special `"factor_contrast"` model, or all levels with model `"factor_full"`.
  Further options planned (e.g. a simpler options to fix the precision
  parameter).  The estimated coefficients appear as random effects in the
  `inla()` output.

* Interface restructuring to support new features while keeping most
  backwards compatibility. Change `map=` to `main=` or unnamed first argument;
  Since `main` is the first parameter, it doesn't need to be a named argument.

* Keep components with zero derivative in the linearisation

* PROJ6 support

* Add random seed option for posterior sampling

* Add package unit testing

* New backend code to make extended feature support easier

* New int.args option to control spatial integration resolution,
  thanks to Martin Jullum (`martinju`)

# inlabru 2.1.13

* Fix CRAN complaint regarding documentation

# inlabru 2.1.12

* Workaround an integration points error for old (ca pre-2018) INLA versions

# inlabru 2.1.11

* Add CITATION file

# inlabru 2.1.10

* Fix internal sampling bug due to INLA changes

# inlabru 2.1.9

* Remove unused VignetteBuilder entry from DESCRIPTION

# inlabru 2.1.8

* Update default options

* Prevent int.polygon from integrating outside the mesh domain,
  and generally more robust integration scheme construction.

* Fix `bru()` to `like()` parameter logic. (Thanks to Peter Vesk for bug example)

# inlabru 2.1.7

* Added a `NEWS.md` file to track changes to the package.

* Added `inla` methods for `predict()` and `generate()` that convert
  `inla` output into `bru` objects before calling the `bru` prediction
  and posterior sample generator.

* Added protection for examples requiring optional packages

* Fix `sample.lgcp` output formatting, extended CRS support, and more efficient sampling algorithm

* Avoid dense matrices for effect mapping

# inlabru 2.1.4

* `iinla()` tracks convergence of both fixed and random effects

# inlabru 2.1.3

* Added matrix geom `gg.matrix()`

* Fixed CRAN test issues

