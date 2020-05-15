requireNamespace("usethis")
requireNamespace("renv")

usethis::create_package("rdojo.bowling")
usethis::use_build_ignore("DEVELOP-SETUP.R") # this file
usethis::use_readme_rmd()

renv::init() # for reproducibility and portability


