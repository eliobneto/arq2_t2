#!/bin/bash
programas=("jpeg_c" "mvt" "perlin" "trie" "queens")

for i in "${programas[@]}"; do
  (cd $i && make);
done
