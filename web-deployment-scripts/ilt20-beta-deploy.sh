#!/bin/sh
cd
aws s3 cp s3://si-demos/roneel-temp/waf-beta-code-deploy/ilt20/final-build.tar.gz ./
rm -rf final-build/
tar -zxvf final-build.tar.gz
rsync -r ./final-build/ ./ilt20-nuxt/
rm -rf final-build.tar.gz
cd ilt20-nuxt/
pm2 reload Ilt20-Waf-Nuxt
