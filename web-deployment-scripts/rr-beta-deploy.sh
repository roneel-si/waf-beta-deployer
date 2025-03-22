
    cd
    aws s3 cp s3://si-demos/roneel-temp/waf-beta-code-deploy/rr/final-build.tar.gz ./
    rm -rf final-build/
    tar -zxvf final-build.tar.gz
    rsync -r ./final-build/ ./rr-nuxt/
    rm -rf final-build.tar.gz
    cd rr-nuxt/
    pm2 reload Rr-Waf-Nuxt
