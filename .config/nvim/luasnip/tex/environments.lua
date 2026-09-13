local ls = require("luasnip")

local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local rep = require("luasnip.extras").rep
local fmta = require("luasnip.extras.fmt").fmta

local tex = require("snippets.conditions")

local in_text = {
    condition = tex.in_text,
}

local snippets = {}

-- ===============================
-- MATEMÁTICAS INLINE
-- ===============================

table.insert(
    snippets,
    s(
	{ trig = ";;", name = "inline math", wordTrig = false },
	fmta("\\( <> \\)", {
	    i(1),
	}),
	in_text
    )
)

-- ===============================
-- INLINE MATH
-- ===============================

table.insert(
    snippets,
    s(
	{ trig = ";:", name = "display math", wordTrig = false },
	fmta(
	    [[
\[
    <>
\]
]],
	    {
		i(1),
	    }
	),
	in_text
    )
)

-- ===============================
-- ALIGN
-- ===============================

table.insert(
    snippets,
    s(
	{ trig = "aln", name = "align" },
	fmta(
	    [[
\begin{align*}
    <>
\end{align*}
]],
	    {
		i(1),
	    }
	),
	in_text
    )
)

-- ===============================
-- ITEMIZE
-- ===============================

table.insert(
    snippets,
    s(
	{ trig = "itm", name = "itemize" },
	fmta(
	    [[
\begin{itemize}
    \item <>
\end{itemize}
]],
	    {
		i(1),
	    }
	),
	in_text
    )
)

-- ===============================
-- ENUMERATE
-- ===============================

table.insert(
    snippets,
    s(
	{ trig = "enm", name = "enumerate" },
	fmta(
	    [[
\begin{enumerate}
    \item <>
\end{enumerate}
]],
	    {
		i(1),
	    }
	),
	in_text
    )
)

-- ===============================
-- ENTORNO GENÉRICO
--
-- beg<Tab>
-- \begin{...}
--     ...
-- \end{...}
-- ===============================

table.insert(
    snippets,
    s(
	{ trig = "beg", name = "generic environment" },
	{
	    t("\\begin{"),
	    i(1),
	    t({ "}", "\t" }),
	    i(2),
	    t({ "", "\\end{" }),
	    rep(1),
	    t("}"),
	    i(0),
	},
	in_text
    )
)
-- ===============================
-- TEOREMA
-- ===============================

table.insert(
    snippets,
    s(
	{ trig = "teo", name = "Teorema" },
	fmta(
	    [[
\begin{teo}
    <>
\end{teo}
]],
	    { i(1) }
	),
	in_text
    )
)

-- ===============================
-- PROPOSICIÓN
-- ===============================

table.insert(
    snippets,
    s(
	{ trig = "prop", name = "Proposición" },
	fmta(
	    [[
\begin{prop}
    <>
\end{prop}
]],
	    { i(1) }
	),
	in_text
    )
)

-- ===============================
-- DEFINICIÓN
-- ===============================

table.insert(
    snippets,
    s(
	{ trig = "defs", name = "Definición" },
	fmta(
	    [[
\begin{defs}
    <>
\end{defs}
]],
	    { i(1) }
	),
	in_text
    )
)

-- ===============================
-- COROLARIO
-- ===============================

table.insert(
    snippets,
    s(
	{ trig = "cor", name = "Corolario" },
	fmta(
	    [[
\begin{cor}
    <>
\end{cor}
]],
	    { i(1) }
	),
	in_text
    )
)

-- ===============================
-- OBSERVACIÓN
-- ===============================

table.insert(
    snippets,
    s(
	{ trig = "obs", name = "Observación" },
	fmta(
	    [[
\begin{obs}
    <>
\end{obs}
]],
	    { i(1) }
	),
	in_text
    )
)

-- ===============================
-- DEMOSTRACIÓN
-- ===============================

table.insert(
    snippets,
    s(
	{ trig = "dem", name = "Demostración" },
	fmta(
	    [[
\begin{dem}
    <>
\end{dem}
]],
	    { i(1) }
	),
	in_text
    )
)

-- ===============================
-- EJERCICIO
-- ===============================

table.insert(
    snippets,
    s(
	{ trig = "ex", name = "Ejercicio" },
	fmta(
	    [[
\begin{exercise}
    <>
\end{exercise}
]],
	    { i(1) }
	),
	in_text
    )
)

-- ===============================
-- SOLUCIÓN
-- ===============================

table.insert(
    snippets,
    s(
	{ trig = "sol", name = "Solución" },
	fmta(
	    [[
\begin{sol}
    <>
\end{sol}
]],
	    { i(1) }
	),
	in_text
    )
)

local function add_env_variants(trigger, environment, label_prefix)
    local variants = {
        { prefix = "",   starred = false, labeled = false },
        { prefix = "u",  starred = true,  labeled = false },
        { prefix = "l",  starred = false, labeled = true },
        { prefix = "ul", starred = true,  labeled = true },
    }

    for _, variant in ipairs(variants) do
        local env = environment .. (variant.starred and "*" or "")
        local trig = variant.prefix .. trigger

        local nodes

        if variant.labeled then
            nodes = {
                t("\\begin{" .. env .. "}"),
                t({ "", "    \\label{" .. label_prefix .. ":" }),
                i(1),
                t({ "}", "    " }),
                i(2),
                t({ "", "\\end{" .. env .. "}" }),
                i(0),
            }
        else
            nodes = {
                t("\\begin{" .. env .. "}"),
                t({ "", "    " }),
                i(1),
                t({ "", "\\end{" .. env .. "}" }),
                i(0),
            }
        end

        table.insert(
            snippets,
            s(
                {
                    trig = trig,
                    name = trig .. " → " .. env,
                },
                nodes,
                in_text
            )
        )
    end
end

add_env_variants("eqn")
return snippets
