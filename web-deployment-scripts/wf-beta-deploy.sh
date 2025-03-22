
    #!/bin/sh
    cd
    aws s3 cp s3://si-demos/roneel-temp/waf-beta-code-deploy/wf/final-build.tar.gz ./
    rm -rf final-build/
    tar -zxvf final-build.tar.gz
    rsync -r ./final-build/ ./wf-nuxt/
    rm -rf final-build.tar.gz
    cd wf-nuxt/
    pm2 reload Wf-Waf-Nuxt