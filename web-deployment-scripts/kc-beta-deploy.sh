#!/bin/sh
cd
aws s3 cp s3://si-demos/roneel-temp/waf-beta-code-deploy/kc/final-build.tar.gz ./
rm -rf final-build/
tar -zxvf final-build.tar.gz
rsync -r ./final-build/ ./kc-nuxt/
rm -rf final-build.tar.gz
cd kc-nuxt/
pm2 reload Kc-Waf-Nuxt
