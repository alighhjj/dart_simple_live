# GitHub Actions APK 构建说明

本项目提供了多种不同的GitHub Actions工作流来构建APK：

1. `auto_build_apk.yml` - 自动构建APK并上传到Artifacts（如果配置了签名则构建发布版，否则构建调试版）
2. `build_apk_nosign.yml` - 构建不带签名的调试版APK
3. `build_apk_with_debug_keystore.yml` - 专门用于构建带调试签名的APK
4. `quick_apk_build.yml` - 快速构建单一架构APK用于测试
5. `signed_apk_build.yml` - 构建带签名的发布版APK并创建GitHub Release

## 不需要签名的构建

对于测试和开发，可以直接使用以下工作流之一：
- `build_apk_nosign.yml` - 构建调试版本的APK，自动生成调试签名
- `build_apk_with_debug_keystore.yml` - 专门用于构建带调试签名的APK
- `auto_build_apk.yml` - 自动构建，如果配置了签名则构建发布版，否则构建调试版

## 需要配置的密钥（Secrets）

如果要构建带签名的发布版APK，需要在GitHub仓库的Settings > Secrets and variables > Actions中添加以下密钥：

1. `KEYSTORE_BASE64` - 使用base64编码的keystore文件
2. `STORE_PASSWORD` - keystore的存储密码
3. `KEY_PASSWORD` - 密钥密码
4. `KEY_ALIAS` - 密钥别名

## 如何生成密钥

1. 生成keystore文件：
   ```bash
   keytool -genkey -v -keystore release-key.jks -keyalg RSA -keysize 2048 -storepass your_store_password -keypass your_key_password -validity 10000 -alias your_key_alias
   ```

2. 将keystore文件转换为base64：
   ```bash
   base64 -i release-key.jks -o keystore-base64.txt
   ```

3. 将生成的base64字符串添加到GitHub Secrets中的`KEYSTORE_BASE64`字段

## 工作流触发方式

1. `auto_build_apk.yml`:
   - 推送到任何分支时自动触发
   - 推送标签时会创建Release
   - 可以手动触发

2. `build_apk_nosign.yml`:
   - 推送到任何分支时触发
   - 可以手动触发

3. `build_apk_with_debug_keystore.yml`:
   - 推送到任何分支时触发
   - 可以手动触发

4. `quick_apk_build.yml`:
   - 推送到dev分支时触发
   - 可以手动触发

5. `signed_apk_build.yml`:
   - 推送以"v"开头的标签时触发（如v1.0.0）
   - 可以手动触发

## 生成的APK文件

构建完成后，APK文件将上传到GitHub Actions的Artifacts中，或者在Release中直接提供下载。