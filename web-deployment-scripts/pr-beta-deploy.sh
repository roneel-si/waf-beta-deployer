#!/bin/sh
cd
aws s3 cp s3://si-demos/roneel-temp/waf-beta-code-deploy/pr/final-build.tar.gz ./
rm -rf final-build/
tar -zxvf final-build.tar.gz
rsync -r ./final-build/ ./pr-nuxt/
rm -rf final-build.tar.gz
cd pr-nuxt/
pm2 reload Pr-Waf-Nuxt
