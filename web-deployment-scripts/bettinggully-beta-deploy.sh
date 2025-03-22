
#!/bin/sh
cd
aws s3 cp s3://si-demos/roneel-temp/waf-beta-code-deploy/bettinggully/final-build.tar.gz ./
rm -rf final-build/
tar -zxvf final-build.tar.gz
rsync -r ./final-build/ ./bettinggully-nuxt/
rm -rf final-build.tar.gz
cd bettinggully-nuxt/
#npm install --only=prod
pm2 reload BettingGully-Waf-Nuxt
