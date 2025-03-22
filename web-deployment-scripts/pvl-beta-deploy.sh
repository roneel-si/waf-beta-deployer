
    #!/bin/sh
    cd
    aws s3 cp s3://si-demos/roneel-temp/waf-beta-code-deploy/pvl/final-build.tar.gz ./
    rm -rf final-build/
    tar -zxvf final-build.tar.gz
    rsync -r ./final-build/ ./pvl-nuxt/
    rm -rf final-build.tar.gz
    cd pvl-nuxt/
    pm2 reload Pvl-Waf-Nuxt
