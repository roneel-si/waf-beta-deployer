  #!/bin/sh
    cd
    aws s3 cp s3://si-demos/roneel-temp/waf-beta-code-deploy/uww/final-build.tar.gz ./
    rm -rf final-build/
    tar -zxvf final-build.tar.gz
    rsync -r ./final-build/ ./uww-nuxt/
    rm -rf final-build.tar.gz
    cd uww-nuxt/
    pm2 reload Uww-Waf-Nuxt
