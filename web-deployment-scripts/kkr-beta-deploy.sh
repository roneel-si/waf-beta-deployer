 #!/bin/sh
 cd
 aws s3 cp s3://si-demos/roneel-temp/waf-beta-code-deploy/kkr/final-build.tar.gz ./
 rm -rf final-build/
 tar -zxvf final-build.tar.gz
 rsync -r ./final-build/ ./kkr-nuxt/
 rm -rf final-build.tar.gz
 cd kkr-nuxt/
 pm2 reload Kkr-Waf-Nuxt
