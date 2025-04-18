#!/bin/bash

# バージョン番号を引数から取得、指定がない場合はエラー
VERSION=$1
if [ -z "$VERSION" ]; then
    echo "Error: Version number is required"
    echo "Usage: $0 <version>"
    echo "Example: $0 v1.0.0"
    exit 1
fi

# バージョン形式の検証 (vX.Y.Z)
if ! [[ $VERSION =~ ^v[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
    echo "Error: Version must be in the format vX.Y.Z (e.g., v1.0.0)"
    exit 1
fi

# ECRリポジトリのURLを取得
ECR_REPO=272685186052.dkr.ecr.ap-northeast-1.amazonaws.com/test-repository

# イメージのビルド
docker build -t ${ECR_REPO}:"${VERSION}" ./app
docker tag ${ECR_REPO}:"${VERSION}"

# ECRにログイン
aws ecr get-login-password --region ap-northeast-1 | docker login --username AWS --password-stdin ${ECR_REPO}

# イメージのプッシュ
docker push ${ECR_REPO}:"${VERSION}"

echo "Successfully built and pushed version ${VERSION}"