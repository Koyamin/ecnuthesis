module = "ecnuthesis"

sourcefiledir = "source"
sourcefiles = {"*.dtx", "*.ins"}
installfiles = {"*.cls", "*.sty", "*.def"}

typesetfiles = {"ecnuthesis.dtx"}
typesetexe = "xelatex"
typesetsuppfiles = {"ecnudoc.cls"}

unpackfiles = {"ecnuthesis.ins"}
unpackexe = "xetex"

checksuppfiles = {"vi/ecnu-vi-*.pdf"}

checkengines = {"xetex"}
stdengine = "xetex"
checkopts = "-interaction=batchmode"

packtdszip = true