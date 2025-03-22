    #!/bin/sh
    cd
    ls
    pwd
    aws s3 cp s3://si-demos/roneel-temp/waf-beta-code-deploy/br/final-build.tar.gz ./
    rm -rf final-build/
    tar -zxvf final-build.tar.gz
    rsync -r ./final-build/ ./br-nuxt/
    rm -rf final-build.tar.gz
    cd br-nuxt/
#    npm i --only=prod
    pm2 reload Br-Waf-Nuxt
