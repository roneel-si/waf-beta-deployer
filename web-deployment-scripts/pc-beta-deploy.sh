
    #!/bin/sh
    cd
    aws s3 cp s3://si-demos/roneel-temp/waf-beta-code-deploy/pc/final-build.tar.gz ./
    rm -rf final-build/
    tar -zxvf final-build.tar.gz
    rsync -r ./final-build/ ./pc-nuxt/
    rm -rf final-build.tar.gz
    cd pc-nuxt/
#    npm install --only=prod
 #   aws s3 cp s3://si-demos/roneel-temp/waf-beta-code-deploy/pc/ecosystem.config.js ./
  #  sudo pm2 start ecosystem.config.js --env beta
sudo pm2 reload Pc-Waf-Nuxt
