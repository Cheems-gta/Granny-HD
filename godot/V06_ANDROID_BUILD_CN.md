# V0.6 Android APK 云端编译（手机）

**状态：** Godot 4.4.1 云端工作流已提交；还需要将完整 V0.6 ZIP 上传为 GitHub Release 的附件。本仓库没有完整的 295 张 PNG，不能仅凭源码生成真实 HD APK。尚未验证编译成功。

## 用手机操作

1. 从聊天中的下载链接保存 **Granny_HD_Godot_V0_6_Connected_House_Prototype.zip**（约 143 MiB）到手机；**不要解压、改名或重新压缩**。
2. 打开 https://github.com/Cheems-gta/Granny-HD/releases/new ，选择新标签 **v0.6-source**，目标分支 **main**。
3. Release 标题写 `Granny HD V0.6 source materials`，选择网页的 Attach files，上传步骤 1 的原始 ZIP 文件。待附件上传完毕，再点击 **Publish release**（不要仅保存草稿）。
4. 发布 Release 会触发 `Godot V0.6 Android APK` 工作流。也可进入 https://github.com/Cheems-gta/Granny-HD/actions/workflows/godot-v06-android.yml 手动运行。
5. 如果运行成功（绿色），在 Artifacts 下载 **GrannyHD-V06-Android-Debug**，解压后获得 `GrannyHD_V06_Debug.apk`。手机安装前请确认文件来源是本仓库。
6. 如果失败（红色），打开运行详情和 `GrannyHD-V06-Build-Logs` 或复制运行链接来排查；目前不存在通过验收的 V0.6 APK。

## 项目校验

- 原始 ZIP SHA-256：`db31e5e52e9931e8265bb9f56e4cd76b044ff7fe34f13a4bd73a4eed162c919f`
- 包内目录：`godot/project.godot`
- 贴图：59 套 × 5 张 = **295 PNG**
- 系统：Godot 4.4.1、Android ARM64、横屏、调试签名
- 这是原创的室内材质演示原型，**不是原版 Granny APK** 的完整高清替换。

若看不到附件上传框，请使用浏览器的“桌面版网站”模式。