package("gmp")

    set_homepage("https://gmplib.org/")
    set_description("GMP is a free library for arbitrary precision arithmetic, operating on signed integers, rational numbers, and floating-point numbers.")
    set_license("LGPL-3.0")

    add_urls("https://gmplib.org/download/gmp/gmp-$(version).tar.xz")
    add_versions("6.2.1", "fd4829912cddd12f84181c3451cc752be224643e87fac497b69edddadc49b4f2")

    if is_plat("linux") then
        add_extsources("apt::libgmp-dev")
    end

    add_deps("m4")

    on_install("macosx", "linux", function (package)
        local configs = {}
        table.insert(configs, "--enable-shared=" .. (package:config("shared") and "yes" or "no"))
        table.insert(configs, "--enable-static=" .. (package:config("shared") and "no" or "yes"))
        if package:debug() then
            table.insert(configs, "--enable-debug")
        end
        if package:config("pic") ~= false then
            table.insert(configs, "--with-pic")
        end
        import("package.tools.autoconf").install(package, configs)
    end)

    on_test(function (package)
        assert(package:has_cfuncs("gmp_randinit", {includes = "gmp.h"}))
    end)
