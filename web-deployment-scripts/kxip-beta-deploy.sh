
#!/bin/sh
cd
aws s3 cp s3://si-demos/roneel-temp/waf-beta-code-deploy/kxip/final-build.tar.gz ./
rm -rf final-build/
tar -zxvf final-build.tar.gz
rsync -r ./final-build/ ./kxip-nuxt/
rm -rf final-build.tar.gz
cd kxip-nuxt/
pm2 reload Kxip-Waf-Nuxt
