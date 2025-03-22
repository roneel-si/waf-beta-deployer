\#!/bin/sh
cd
aws s3 cp s3://si-demos/roneel-temp/waf-beta-code-deploy/gsoc/final-build.tar.gz ./
rm -rf final-build/
tar -zxvf final-build.tar.gz
rsync -r ./final-build/ ./gsoc-nuxt/
rm -rf final-build.tar.gz
cd gsoc-nuxt/
pm2 reload Gsoc-Waf-Nuxt

