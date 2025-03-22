
#!/bin/sh
cd 
aws s3 cp s3://si-demos/roneel-temp/waf-beta-code-deploy/eisl/final-build.tar.gz ./
rm -rf final-build/
tar -zxvf final-build.tar.gz
rsync -r ./final-build/ ./eisl-nuxt/
rm -rf final-build.tar.gz
cd eisl-nuxt/
npm install --only=prod
pm2 reload Eisl-Waf-Nuxt
