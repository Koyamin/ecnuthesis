module = "ecnuthesis"

sourcefiles = {"*.dtx", "*.ins", "support/vi/ecnu-vi-*.pdf"}
installfiles = {"*.cls", "*.sty", "*.def", "ecnu-vi-*.pdf"}

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

tdslocations = {
  "tex/latex/ecnuthesis/ecnu-vi-*.pdf",
}