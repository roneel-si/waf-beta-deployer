
    #!/bin/sh
    cd /home/ubuntu
    aws s3 cp s3://si-demos/roneel-temp/waf-beta-code-deploy/wis/final-build.tar.gz ./
    rm -rf final-build/
    tar -zxvf final-build.tar.gz
    rsync -r ./final-build/ ./wis-nuxt/
    rm -rf final-build.tar.gz
    cd wis-nuxt/
    pm2 reload Wis-Waf-Nuxt
