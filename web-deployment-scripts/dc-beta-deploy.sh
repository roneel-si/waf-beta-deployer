 #!/bin/sh
 cd
 aws s3 cp s3://si-demos/roneel-temp/waf-beta-code-deploy/dc/final-build.tar.gz ./
 rm -rf final-build/
 tar -zxvf final-build.tar.gz
 rsync -r ./final-build/ ./dc-nuxt/
 rm -rf final-build.tar.gz
 cd dc-nuxt/
 pm2 reload Dc-Waf-Nuxt
