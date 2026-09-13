local ls = require("luasnip")

local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node

local fmta = require("luasnip.extras.fmt").fmta

local tex = require("snippets.conditions")

local math = {
    condition = tex.in_math,
}

local snippets = {}

-- ===============================
-- LETRAS GRIEGAS
-- ===============================

local greek_letters = {
    a = "\\alpha",
    b = "\\beta",

    g = "\\gamma",
    G = "\\Gamma",

    d = "\\delta",
    D = "\\Delta",

    e = "\\varepsilon",
    et = "\\eta",

    z = "\\zeta",

    th = "\\theta",
    Th = "\\Theta",

    i = "\\iota",
    k = "\\kappa",

    l = "\\lambda",
    L = "\\Lambda",

    m = "\\mu",
    n = "\\nu",

    x = "\\xi",
    X = "\\Xi",

    p = "\\pi",
    P = "\\Pi",

    r = "\\rho",

    s = "\\sigma",
    S = "\\Sigma",

    t = "\\tau",

    ph = "\\phi",
    vph = "\\varphi",
    Ph = "\\Phi",

    ps = "\\psi",
    Ps = "\\Psi",

    o = "\\omega",
    O = "\\Omega",

    c = "\\chi",

    y = "\\upsilon",
    Y = "\\Upsilon",
}

for key, value in pairs(greek_letters) do
    table.insert(snippets, s({ trig = key }, t(value), math))
end

-- ===============================
-- MATHBB / MATHCAL / MATHSCR
-- ===============================

table.insert(
    snippets,
    s(
        { trig = "([A-Z])bb", regTrig = true },
        f(function(_, snip)
            return "\\mathbb{" .. snip.captures[1] .. "}"
        end),
        math
    )
)

table.insert(
    snippets,
    s(
        { trig = "([A-Z])cal", regTrig = true },
        f(function(_, snip)
            return "\\mathcal{" .. snip.captures[1] .. "}"
        end),
        math
    )
)

table.insert(
    snippets,
    s(
        { trig = "([A-Z])scr", regTrig = true },
        f(function(_, snip)
            return "\\mathscr{" .. snip.captures[1] .. "}"
        end),
        math
    )
)

-- ===============================
-- RAÍCES
-- ===============================

table.insert(
    snippets,
    s(
        { trig = "sqrt" },
        fmta("\\sqrt{<>}", {
            i(1),
        }),
        math
    )
)

table.insert(
    snippets,
    s(
        { trig = "xrt" },
        fmta("\\sqrt[<>]{<>}", {
            i(1),
            i(2),
        }),
        math
    )
)

-- ===============================
-- FUNCIONES TRIGONOMÉTRICAS INVERSAS
-- asin -> \arcsin{}
-- acos -> \arccos{}
-- atan -> \arctan{}
-- ===============================

local function inverse_trig(name)
    return s(
        { trig = "a" .. name },
        fmta("\\arc" .. name .. "{<>}", {
            i(1),
        }),
        math
    )
end

for _, name in ipairs({ "sin", "cos", "tan" }) do
    table.insert(snippets, inverse_trig(name))
end

-- ===============================
-- COMANDOS CON ARGUMENTO
-- ===============================

table.insert(snippets, s({ trig = "xto" }, fmta("\\xrightarrow{<>}", { i(1) }), math))

table.insert(snippets, s({ trig = "xot" }, fmta("\\xleftarrow{<>}", { i(1) }), math))

table.insert(snippets, s({ trig = "ovl" }, fmta("\\overline{<>}", { i(1) }), math))

table.insert(snippets, s({ trig = "mrm" }, fmta("\\mathrm{<>}", { i(1) }), math))

-- ===============================
-- SÍMBOLOS
-- ===============================

local symbols = {
    ldots = "\\ldots",
    cdot = "\\cdot",
    vdots = "\\vdots",
    ddots = "\\ddots",

    times = "\\times",

    neq = "\\neq",
    geq = "\\geq",
    leq = "\\leq",
    aprox = "\\approx",

    subset = "\\subset",
    supset = "\\supset",
    subseteq = "\\subseteq",
    supseteq = "\\supseteq",

    rarrow = "\\Rightarrow",
    larrow = "\\Leftarrow",
    lrarrow = "\\Leftrightarrow",

    ["in"] = "\\in",
    notin = "\\notin",

    oo = "\\infty",
    empty = "\\emptyset",
    iff = "\\iff",

    cos = "\\cos",
    sin = "\\sin",
    tan = "\\tan",
}

for trigger, value in pairs(symbols) do
    table.insert(snippets, s({ trig = trigger }, t(value), math))
end

return snippets
