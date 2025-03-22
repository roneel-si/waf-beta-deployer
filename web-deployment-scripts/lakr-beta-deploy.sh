
    #!/bin/sh
    cd
    aws s3 cp s3://si-demos/roneel-temp/waf-beta-code-deploy/lakr/final-build.tar.gz ./
    rm -rf final-build/
    tar -zxvf final-build.tar.gz
    rsync -r ./final-build/ ./lakr-nuxt/
    rm -rf final-build.tar.gz
    cd lakr-nuxt/
    pm2 reload Lakr-Waf-Nuxt
