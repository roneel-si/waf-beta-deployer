#!/bin/sh
cd
aws s3 cp s3://si-demos/roneel-temp/waf-beta-code-deploy/sm/final-build.tar.gz ./
rm -rf final-build/
tar -zxvf final-build.tar.gz
rsync -r ./final-build/ ./sm-nuxt/
rm -rf final-build.tar.gz
cd sm-nuxt/
pm2 reload Sm-Waf-Nuxt
