requireNamespace("usethis")
requireNamespace("renv")
requireNamespace("lintr")
requireNamespace("spelling")


usethis::create_package("rdojo.bowling")
usethis::use_build_ignore("DEVELOP-SETUP.R") # this file
usethis::use_readme_rmd()

renv::init() # for reproducibility and portability

usethis::use_git()
usethis::git_vaccinate()
usethis::use_github()
usethis::use_tidy_contributing()
usethis::use_tidy_github()
usethis::use_github_action_check_standard()
usethis::use_github_action("lint")
usethis::use_package_doc()
usethis::use_lifecycle_badge("maturing")
usethis::use_cran_badge()
usethis::use_roxygen_md()
usethis::use_spell_check()
usethis::use_testthat()
usethis::use_tidy_description()
usethis::use_tidy_style()
usethis::use_pipe()

usethis::use_news_md()

# cycle between those before every pull-request
spelling::spell_check_package()
spelling::update_wordlist()
covr::report()
lintr::lint_package()

usethis::use_github_action("test-coverage")
usethis::use_coverage()

usethis::use_tidy_eval()

usethis::use_version()


renv::status()
renv::snapshot(prompt = FALSE)
