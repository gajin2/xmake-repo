package("xtl")

    set_kind("library", {headeronly = true})
    set_homepage("https://github.com/xtensor-stack/xtl/")
    set_description("Basic tools (containers, algorithms) used by other quantstack packages")
    set_license("BSD-3-Clause")

    add_urls("https://github.com/xtensor-stack/xtl/archive/refs/tags/$(version).tar.gz")
    add_versions("0.7.2", "95c221bdc6eaba592878090916383e5b9390a076828552256693d5d97f78357c")

    add_deps("cmake")
    add_deps("nlohmann_json")
    on_install("windows", "macosx", "linux", "mingw@windows", function (package)
        import("package.tools.cmake").install(package)
    end)

    on_test(function (package)
        assert(package:check_cxxsnippets({test = [[
            void test() {
                xtl::xcomplex<double> c0;
                xtl::xcomplex<double> c1(1.);
                xtl::xcomplex<double> c2(1., 2.);
            }
        ]]}, {configs = {languages = "c++14"}, includes = "xtl/xcomplex.hpp"}))
    end)
