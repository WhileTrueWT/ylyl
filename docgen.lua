#!/usr/bin/lua
local markdown = require "markdown"

local template = [[
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>ylyl</title>
        <meta http-equiv="Permissions-Policy" content="interest-cohort=()">
        <link href="style.css" rel="stylesheet" type="text/css" media="all">
    </head>
    <body>
        <main>
            $CONTENT
        </main>
        <footer>
            <p>page last modified: $MODIFIED.</p>
        </footer>
    </body>
</html>
]]

local inf = io.open("docs.md", "r")
local ins = inf:read("*a")
inf:close()

local statf = io.popen("stat -c %Y docs.md")
local lastModified = statf:read()
statf:close()

local outs = template
local outs = outs:gsub("$CONTENT", markdown(ins))
local outs = outs:gsub("$MODIFIED", os.date("%Y-%m-%d at %H:%M:%S", lastModified))

local outf = io.open("docs.html", "w")
outf:write(outs)
outf:close()
