# GitHub Actions APK 构建说明

本项目提供以下GitHub Actions工作流来构建APK：

1. `build_apk_with_debug_keystore.yml` - 构建带调试签名的APK（用于测试和开发）
2. `build_release_apk.yml` - 自动构建带正式签名的APK并发布到GitHub Release
3. `generate_release_keystore.yml` - 生成正式签名密钥文件

## 使用说明

### 调试版本构建
对于测试和开发，使用`build_apk_with_debug_keystore.yml`工作流，它会自动生成调试签名并构建APK。

### 自动发布正式版本
`build_release_apk.yml`工作流会在以下情况下自动触发：
- 当代码推送到`master`或`main`分支时
- 手动触发（可选）

该工作流会：
1. 自动生成正式签名密钥
2. 使用该签名构建发布版APK
3. 自动创建GitHub Release并上传APK文件

### 手动生成签名密钥
你也可以使用`generate_release_keystore.yml`生成签名密钥，然后下载并妥善保管该密钥文件，以便后续使用。

## 工作流触发方式

1. `build_apk_with_debug_keystore.yml`:
   - 可以手动触发（推荐用于日常开发和测试）
   - 也可配置为在特定事件时自动触发

2. `build_release_apk.yml`:
   - 当代码推送到`master`或`main`分支时自动触发
   - 可以手动触发
   - 构建完成后自动发布到GitHub Release

3. `generate_release_keystore.yml`:
   - 手动触发，需要提供签名相关信息
   - 用于生成并下载签名密钥文件

## 生成的APK文件

对于调试版本，APK文件将上传到GitHub Actions的Artifacts中。
对于正式版本，APK文件将自动发布到GitHub Release中。

对于生产环境的正式发布，建议在本地环境使用固定的签名密钥进行构建，以确保应用更新时签名的一致性。