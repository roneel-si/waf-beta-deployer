
    #!/bin/sh
    cd
    aws s3 cp s3://si-demos/roneel-temp/waf-beta-code-deploy/wpl/final-build.tar.gz ./
    rm -rf final-build/
    tar -zxvf final-build.tar.gz
    rsync -r ./final-build/ ./wpl-nuxt/
    rm -rf final-build.tar.gz
    cd wpl-nuxt/
#    npm i --only=prod
    pm2 reload Wpl-Waf-Nuxt
