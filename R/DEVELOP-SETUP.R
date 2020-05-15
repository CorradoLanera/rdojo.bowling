requireNamespace("usethis")
requireNamespace("renv")

usethis::create_package("rdojo.bowling")
usethis::use_build_ignore("DEVELOP-SETUP.R") # this file
usethis::use_readme_rmd()

usethis::use_git()
usethis::use_github()



renv::init() # for reproducibility and portability
