#!/bin/sh
cd
aws s3 cp s3://si-demos/roneel-temp/waf-beta-code-deploy/ecn/final-build.tar.gz ./
rm -rf final-build/
tar -zxvf final-build.tar.gz
rsync -r ./final-build/ ./ecn-nuxt/
rm -rf final-build.tar.gz
cd ecn-nuxt/
pm2 reload Ecn-Waf-Nuxt
