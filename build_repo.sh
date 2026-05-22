#!/bin/bash

cd "$(dirname "$0")"

echo "Building Packages..."

# generate real Packages file (simple but compatible)
rm -f Packages Packages.gz

for file in debs/*.deb; do
  if [ -f "$file" ]; then
    size=$(stat -f%z "$file")
    md5=$(md5 -q "$file")

    echo "Package: $(basename "$file" .deb)" >> Packages
    echo "Filename: debs/$(basename "$file")" >> Packages
    echo "Size: $size" >> Packages
    echo "MD5sum: $md5" >> Packages
    echo "Architecture: iphoneos-arm" >> Packages
    echo "Section: Applications" >> Packages
    echo "" >> Packages
  fi
done

gzip -f Packages

echo "DONE ✔ Repo built"
