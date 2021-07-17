#!/usr/bin/env julia --sysimage ~/.julia_sysimages/1.6.1/default.so

OUT_DIR = @__DIR__
OUT_FILE = joinpath(OUT_DIR, "index.asciidoc")

open(OUT_FILE; write=true) do io
    write(io, "= Blog Index", '\n')
    write(io, read(joinpath(OUT_DIR, "blog.asciidoc"), String), '\n')

    for f in readdir(OUT_DIR; join=true, sort=false)
        isdir(f) && !ispath(joinpath(f, ".exclude-from-blog")) || continue

        index_file = joinpath(f, "index.asciidoc")
        !isfile(index_file) && continue

        first_line = readline(index_file)
        title = match(r"^\s*=\s*(.*)$", first_line)[1]
        dir_name = basename(f)
        # @show title dir_name

        write(io, "link:/blog/$(dir_name)/[$(title)]", '\n')
    end
end

run(`asciidoctor $(joinpath(OUT_DIR, "index.asciidoc"))`)

# OUT_FILE = ""

# cd blog || exit

# out_file="./index.asciidoc"

# add_to_index() {
# 	dir_name="$1"
# 	title="$(head -n 1 "$dir_name/index.asciidoc" | sed 's/^\s*\=\s*//')"
# 	echo "$title"
# }

# export -f add_to_index

# cat <<EOF >$out_file
# = Blog Index
# EOF

# cat blog.asciidoc >>"$out_file"

# find . -maxdepth 1 -type d -not -name ".*" -exec bash -c 'add_to_index "$0"' '{}' ';'
