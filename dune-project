(lang dune 3.11)

(name hooke)

(generate_opam_files true)

(source
 (github leostera/hooke))

(authors "Leandro Ostera <leandro@abstractmachines.dev>")

(maintainers "Leandro Ostera <leandro@abstractmachines.dev>")

(license MIT)

(package
 (name hooke)
 (synopsis "A spring-physics library for OCaml")
 (description "Hooke is a small physics library that provides springs")
 (depends
   (ocaml (>= "5.1"))
   dune)
 (tags (physics springs animation)))
