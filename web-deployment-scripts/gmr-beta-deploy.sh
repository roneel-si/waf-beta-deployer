
    #!/bin/sh
    cd /home/ubuntu/
    aws s3 cp s3://si-demos/roneel-temp/waf-beta-code-deploy/gmr/final-build.tar.gz ./
    rm -rf final-build/
    tar -zxvf final-build.tar.gz
    rsync -r ./final-build/ ./gmr-nuxt/
    rm -rf final-build.tar.gz
    cd gmr-nuxt/
    pm2 reload Gmr-Waf-Nuxt
