#!/bin/sh
cd /home/ubuntu/
aws s3 cp s3://si-demos/roneel-temp/waf-beta-code-deploy/spz/final-build.tar.gz ./
rm -rf final-build/
tar -zxvf final-build.tar.gz
rsync -r ./final-build/ ./spz-nuxt/
rm -rf final-build.tar.gz
cd spz-nuxt/
pm2 reload Spz-Waf-Nuxt
