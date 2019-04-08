#!/bin/bash
cd ~/ios_base/IOSBASE
read -p "请输入变更提交内容 : " commitMessage
git commit -a -m "$commitMessage"
git push
