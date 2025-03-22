    #!/bin/sh
    cd
    aws s3 cp s3://si-demos/roneel-temp/waf-beta-code-deploy/dsg/final-build.tar.gz ./
    rm -rf final-build/
    tar -zxvf final-build.tar.gz
    rsync -r ./final-build/ ./dsg-nuxt/
    rm -rf final-build.tar.gz
    cd dsg-nuxt/
#    npm i --only=prod
    pm2 reload Dsg-Waf-Nuxt
