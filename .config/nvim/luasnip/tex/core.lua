local ls = require("luasnip")

local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local sn = ls.snippet_node
local d = ls.dynamic_node

local fmt = require("luasnip.extras.fmt").fmt

local tex = require("snippets.conditions")

local snippets = {}
local autosnippets = {}

local function get_visual(_, parent)
    local selected = parent.snippet.env.LS_SELECT_RAW

    if selected and #selected > 0 then
        return sn(nil, i(1, selected))
    end

    return sn(nil, i(1))
end

-- =========================================================
-- PREÁMBULO
-- =========================================================

table.insert(
    snippets,
    s("preamble", {
        t({
            "\\documentclass[12pt,a4paper]{article}",
            "",
            "% ================== PAQUETES BÁSICOS ==================",
            "\\usepackage[utf8]{inputenc}",
            "\\usepackage[T1]{fontenc}",
            "\\usepackage[spanish]{babel}",
            "\\usepackage{lmodern}",
            "\\usepackage[left=1.5cm, right=1.5cm, top=2cm, bottom=2cm]{geometry}",
            "\\usepackage[dvipsnames]{xcolor}",
            "",
            "% ================== MATEMÁTICAS ==================",
            "\\usepackage{amsmath, amssymb, amsthm, amsfonts}",
            "\\usepackage{mathtools}",
            "\\usepackage{bm}",
            "\\usepackage{mathrsfs}",
            "\\usepackage{dsfont}",
            "",
            "% ================== ENTORNOS ==================",
            "\\newtheorem{defs}{Definición}",
            "\\newtheorem{obs}{Observación}",
            "\\newtheorem{teo}{Teorema}",
            "\\newtheorem{prop}{Proposición}",
            "\\newtheorem{cor}{Corolario}",
            "\\newtheorem{exercise}{Ejercicio}",
            "",
            "\\newenvironment{dem}{%",
            "    \\par\\noindent\\textbf{Demostración. }\\normalfont%",
            "}{\\hfill$\\square$\\par}",
            "",
            "\\newenvironment{sol}{%",
            "    \\par\\noindent\\textbf{Solución. }\\normalfont%",
            "}{\\par}",
            "",
            "% ================== FIGURAS Y OTROS ==================",
            "\\usepackage{graphicx}",
            "\\usepackage{nameref}",
            "\\usepackage{tikz}",
            "\\usepackage{tikz-cd}",
            "\\usepackage{hyperref}",
            "",
            "% ================== ESTILO ==================",
            "\\numberwithin{equation}{section}",
            "\\setlength{\\parskip}{0.5em}",
            "\\setlength{\\parindent}{0pt}",
            "",
        }),
        i(0),
    })
)

-- =========================================================
-- TÍTULO
-- =========================================================

table.insert(
    snippets,
    s("title", {
        t("\\title{"),
        i(1),
        t({
            "}",
            "\\author{José Luis Ocejo}",
            "\\date{}",
            "",
        }),
        i(0),
    })
)

-- =========================================================
-- FRACCIONES
-- =========================================================

table.insert(
    snippets,
    s({ trig = "ff" }, {
        t("\\frac{"),
        i(1),
        t("}{"),
        i(2),
        t("}"),
    }, {
        condition = tex.in_math,
    })
)

table.insert(
    snippets,
    s({ trig = "df" }, {
        t("\\dfrac{"),
        i(1),
        t("}{"),
        i(2),
        t("}"),
    }, {
        condition = tex.in_math,
    })
)

-- =========================================================
-- SUPERÍNDICE
-- =========================================================

table.insert(
    autosnippets,
    s({
        trig = "td",
        wordTrig = false,
    }, {
        t("^{"),
        i(1),
        t("}"),
    }, {
        condition = tex.in_math,
    })
)

-- =========================================================
-- SUBÍNDICE
-- =========================================================

table.insert(
    autosnippets,
    s({
        trig = "_",
        wordTrig = false,
    }, {
        t("_{"),
        i(1),
        t("}"),
    }, {
        condition = tex.in_math,
    })
)

-- =========================================================
-- INTEGRAL
-- =========================================================

table.insert(
    autosnippets,
    s({
        trig = "int",
        wordTrig = true,
    }, {
        t("\\int_{"),
        i(1),
        t("}^{"),
        i(2),
        t("} "),
        i(3),
    }, {
        condition = tex.in_math,
    })
)

-- =========================================================
-- SUMATORIA
-- =========================================================

table.insert(
    autosnippets,
    s({
        trig = "sum",
        wordTrig = true,
    }, {
        t("\\sum_{"),
        i(1),
        t("}^{"),
        i(2),
        t("} "),
        i(0),
    }, {
        condition = tex.in_math,
    })
)

-- =========================================================
-- FLECHAS
-- =========================================================

table.insert(
    snippets,
    s({ trig = "to" }, t("\\to"), {
        condition = tex.in_math,
    })
)

table.insert(
    snippets,
    s({ trig = "mapsto" }, t("\\mapsto"), {
        condition = tex.in_math,
    })
)

-- =========================================================
-- BOX
-- =========================================================

table.insert(
    snippets,
    s("box", {
        t("\\boxed{"),
        i(1),
        t("}"),
    })
)

-- =========================================================
-- LÍMITES / SUP / INF / MAX / MIN
-- =========================================================

local operators = {
    lim = "\\lim",
    sup = "\\sup",
    inf = "\\inf",
    max = "\\max",
    min = "\\min",
}

for trigger, command in pairs(operators) do
    table.insert(
        snippets,
        s({ trig = trigger }, {
            t(command .. "_{"),
            i(1),
            t("} "),
            i(0),
        }, {
            condition = tex.in_math,
        })
    )
end

-- =========================================================
-- FORMATO DE TEXTO
-- =========================================================

table.insert(
    snippets,
    s("tbf", {
        t("\\textbf{"),
        i(1),
        t("}"),
    })
)

table.insert(
    snippets,
    s("tit", {
        t("\\textit{"),
        i(1),
        t("}"),
    })
)

table.insert(
    snippets,
    s("ul", {
        t("\\underline{"),
        i(1),
        t("}"),
    })
)

table.insert(
    snippets,
    s("emph", {
        t("\\emph{"),
        i(1),
        t("}"),
    })
)

-- =========================================================
-- DELIMITADORES
--
-- lrp -> \left( ... \right)
-- lrb -> \left[ ... \right]
-- lrc -> \left\{ ... \right\}
-- lra -> \left\langle ... \right\rangle
-- lrm -> \left| ... \right|
-- lrn -> \left\| ... \right\|
-- =========================================================

local brackets = {
    a = { "\\langle", "\\rangle" },
    b = { "[", "]" },
    c = { "\\{", "\\}" },
    m = { "|", "|" },
    p = { "(", ")" },
    n = { "\\|", "\\|" },
}

table.insert(
    autosnippets,
    s(
        {
            trig = "lr([abcmpn])",
            regTrig = true,
            wordTrig = false,
            hidden = true,
        },
        fmt([[\left{} {} \right{}{}]], {
            f(function(_, snip)
                return brackets[snip.captures[1]][1]
            end),

            d(1, get_visual),

            f(function(_, snip)
                return brackets[snip.captures[1]][2]
            end),

            i(0),
        })
    )
)
return snippets, autosnippets
