#!/bin/sh
cd
aws s3 cp s3://si-demos/roneel-temp/waf-beta-code-deploy/dv/final-build.tar.gz ./
rm -rf final-build/
tar -zxvf final-build.tar.gz
rsync -r ./final-build/ ./dv-nuxt/
rm -rf final-build.tar.gz
cd dv-nuxt/
pm2 reload Dv-Waf-Nuxt
