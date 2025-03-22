
#!/bin/sh
cd
aws s3 cp s3://si-demos/roneel-temp/waf-beta-code-deploy/sportsadda/final-build.tar.gz ./
rm -rf final-build/
tar -zxvf final-build.tar.gz
rsync -r ./final-build/ ./sportsadda-nuxt/
rm -rf final-build.tar.gz
cd sportsadda-nuxt/
#npm install --only=prod
pm2 reload Sportsadda-Waf-Nuxt
