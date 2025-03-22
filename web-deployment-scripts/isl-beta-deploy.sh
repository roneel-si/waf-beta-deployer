#!/bin/sh
cd
aws s3 cp s3://si-demos/roneel-temp/waf-beta-code-deploy/isl/final-build.tar.gz ./
rm -rf final-build/
tar -zxvf final-build.tar.gz
rsync -r ./final-build/ ./isl-nuxt/
rm -rf final-build.tar.gz
cd isl-nuxt/
pm2 reload Islv1-Waf-Nuxt
