#!/bin/sh
cd
aws s3 cp s3://si-demos/roneel-temp/waf-beta-code-deploy/gfg/final-build.tar.gz ./
rm -rf final-build/
tar -zxvf final-build.tar.gz
rsync -r ./final-build/ ./gfg-nuxt/
rm -rf final-build.tar.gz
cd gfg-nuxt/
pm2 reload Gfg-Waf-Nuxt
