
#!/bin/sh
cd
aws s3 cp s3://si-demos/roneel-temp/waf-beta-code-deploy/w88/final-build.tar.gz ./
rm -rf final-build/
tar -zxvf final-build.tar.gz
rsync -r ./final-build/ ./w88-nuxt/
rm -rf final-build.tar.gz
cd w88-nuxt/
#npm install --only=prod
pm2 reload W88-Waf-Nuxt
