    #!/bin/sh
    cd
    aws s3 cp s3://si-demos/roneel-temp/waf-beta-code-deploy/upw/final-build.tar.gz ./
    rm -rf final-build/
    tar -zxvf final-build.tar.gz
    rsync -r ./final-build/ ./upw-nuxt/
    rm -rf final-build.tar.gz
    cd upw-nuxt/
#    npm i --only=prod
    pm2 reload Upw-Waf-Nuxt
