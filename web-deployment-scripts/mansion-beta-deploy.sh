#!/bin/sh
cd
aws s3 cp s3://si-demos/roneel-temp/waf-beta-code-deploy/mansion/final-build.tar.gz ./
rm -rf final-build/
tar -zxvf final-build.tar.gz
rsync -r ./final-build/ ./mansion-nuxt/
rm -rf final-build.tar.gz
cd mansion-nuxt/
#npm install --only=prod
pm2 reload Mansion-Waf-Nuxt
