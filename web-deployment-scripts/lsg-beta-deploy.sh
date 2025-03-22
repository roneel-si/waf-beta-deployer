#!/bin/sh
cd
aws s3 cp s3://si-demos/roneel-temp/waf-beta-code-deploy/lsg/final-build.tar.gz ./
rm -rf final-build/
tar -zxvf final-build.tar.gz
rsync -r ./final-build/ ./lsg-nuxt/
rm -rf final-build.tar.gz
cd lsg-nuxt/
pm2 reload Lsg-Waf-Nuxt
