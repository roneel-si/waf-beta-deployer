
    #!/bin/sh
    cd
    aws s3 cp s3://si-demos/roneel-temp/waf-beta-code-deploy/gulfgiants/final-build.tar.gz ./
    rm -rf final-build/
    tar -zxvf final-build.tar.gz
    rsync -r ./final-build/ ./gg-nuxt/
    rm -rf final-build.tar.gz
    cd gg-nuxt/
    pm2 reload GG-Waf-Nuxt
