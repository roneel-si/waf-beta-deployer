#!/bin/sh
cd
aws s3 cp s3://si-demos/roneel-temp/waf-beta-code-deploy/mcfc/final-build.tar.gz ./
rm -rf final-build/
tar -zxvf final-build.tar.gz
rsync -r ./final-build/ ./mcfc-nuxt/
rm -rf final-build.tar.gz
cd mcfc-nuxt/
pm2 reload Mcfc-Waf-Nuxt
