#!/bin/sh
cd
aws s3 cp s3://si-demos/roneel-temp/waf-beta-code-deploy/pkl/final-build.tar.gz ./
rm -rf final-build/
tar -zxvf final-build.tar.gz
rsync -r ./final-build/ ./pkl-nuxt/
rm -rf final-build.tar.gz
cd pkl-nuxt/
npm install --only=prod
pm2 reload Pkl-Waf-Nuxt
