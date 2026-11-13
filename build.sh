#!/usr/bin/env bash
cd "$(dirname "$0")" || exit 1

echo "=== Java ==="
java -version
echo
echo "=== Maven ==="
mvn -version
echo
echo "=== Building SellShop (this can take a few minutes the first time) ==="

if ! mvn -B clean package > build-log.txt 2>&1; then
  echo
  echo "BUILD FAILED. Open build-log.txt and look for lines starting with [ERROR]."
  exit 1
fi

cp target/SellShop-*.jar SellShop.jar
echo
echo "DONE. Your plugin is the file SellShop.jar in this folder."
echo "Put it into the \"plugins\" folder of your server."
