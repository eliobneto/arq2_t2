#!/bin/bash

make

./gem5.fast -d prog_jpeg_c/status --stats-file=jpeg_stats_local.txt ./machine.py -c prog_jpeg_c/jpeg_c/a.out -o "-dct int -progressive -opt -outfile output_large_encode.jpeg" - i "1.ppm > ftmp_out" -b local
./gem5.fast -d prog_jpeg_c/status --stats-file=jpeg_stats_ltage.txt ./machine.py -c prog_jpeg_c/jpeg_c/a.out -o "-dct int -progressive -opt -outfile output_large_encode.jpeg" - i "1.ppm > ftmp_out" -b ltage
./gem5.fast -d prog_jpeg_c/status --stats-file=jpeg_stats_bimode.txt ./machine.py -c prog_jpeg_c/jpeg_c/a.out -o "-dct int -progressive -opt -outfile output_large_encode.jpeg" - i "1.ppm > ftmp_out" -b bimode
./gem5.fast -d prog_jpeg_c/status --stats-file=jpeg_stats_tournament.txt ./machine.py -c prog_jpeg_c/jpeg_c/a.out -o "-dct int -progressive -opt -outfile output_large_encode.jpeg" - i "1.ppm > ftmp_out" -b tournament

./gem5.fast -d prog_mvt/status --stats-file=jpeg_mvt_local.txt ./machine.py -c prog_mvt/mvt/mvt -b local
./gem5.fast -d prog_mvt/status --stats-file=jpeg_mvt_ltage.txt ./machine.py -c prog_mvt/mvt/mvt -b ltage
./gem5.fast -d prog_mvt/status --stats-file=jpeg_mvt_bimode.txt ./machine.py -c prog_mvt/mvt/mvt -b bimode
./gem5.fast -d prog_mvt/status --stats-file=jpeg_mvt_tournament.txt ./machine.py -c prog_mvt/mvt/mvt -b tournament

./gem5.fast -d prog_trie/status --stats-file=jpeg_trie_local.txt ./machine.py -c prog_trie/trie/trie -o "trie.in1" -b local
./gem5.fast -d prog_trie/status --stats-file=jpeg_trie_ltage.txt ./machine.py -c prog_trie/trie/trie -o "trie.in1" -b ltage
./gem5.fast -d prog_trie/status --stats-file=jpeg_trie_bimode.txt ./machine.py -c prog_trie/trie/trie -o "trie.in1" -b bimode
./gem5.fast -d prog_trie/status --stats-file=jpeg_trie_tournament.txt ./machine.py -c prog_trie/trie/trie -o "trie.in1" -b tournament

./gem5.fast -d prog_queens/status --stats-file=jpeg_queens_local.txt ./machine.py -c prog_queens/queens/queens -o "13" -b local
./gem5.fast -d prog_queens/status --stats-file=jpeg_queens_ltage.txt ./machine.py -c prog_queens/queens/queens -o "13" -b ltage
./gem5.fast -d prog_queens/status --stats-file=jpeg_queens_bimode.txt ./machine.py -c prog_queens/queens/queens -o "13" -b bimode
./gem5.fast -d prog_queens/status --stats-file=jpeg_queens_tournament.txt ./machine.py -c prog_queens/queens/queens -o "13" -b tournament

./gem5.fast -d prog_perlin/status --stats-file=jpeg_perlin_local.txt ./machine.py -c prog_perlin/perlin/perlin -o "2.748063e+01" -b local
./gem5.fast -d prog_perlin/status --stats-file=jpeg_perlin_ltage.txt ./machine.py -c prog_perlin/perlin/perlin -o "2.748063e+01" -b ltage
./gem5.fast -d prog_perlin/status --stats-file=jpeg_perlin_bimode.txt ./machine.py -c prog_perlin/perlin/perlin -o "2.748063e+01" -b bimode
./gem5.fast -d prog_perlin/status --stats-file=jpeg_perlin_tournament.txt ./machine.py -c prog_perlin/perlin/perlin -o "2.748063e+01" -b tournament
