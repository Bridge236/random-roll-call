# 别点我 · 随机点名系统 — 部署指南

## 项目结构
```
bdw-app/
├── public/
│   ├── index.html          # 登录页
│   ├── dashboard.html      # 班级 & 学生管理
│   ├── roll.html           # 随机点名
│   ├── logo.png            # 网站 Logo
│   └── supabase-config.js  # ⚠️ 填入你的 Supabase 配置
├── vercel.json             # Vercel 部署配置
└── supabase-init.sql       # 数据库初始化脚本
```

---

## 第一步：配置 Supabase

### 1.1 创建项目
1. 登录 [https://supabase.com](https://supabase.com)
2. 新建项目，记录好**项目密码**

### 1.2 初始化数据库
1. 进入项目 → **SQL Editor**
2. 复制 `supabase-init.sql` 全部内容，粘贴运行
3. 看到 "Success" 即可

### 1.3 添加教师账号
1. 进入项目 → **Authentication** → **Users**
2. 点击 **"Add user"** → **"Create new user"**
3. 填入邮箱 + 密码，点击创建
4. 重复以上步骤添加所有老师账号

> ⚠️ 注意：Supabase 默认会发验证邮件。若不想要，进入
> **Authentication → Settings → Email** 关闭 "Enable email confirmations"

### 1.4 获取 API 密钥
1. 进入 **Settings → API**
2. 复制：
   - **Project URL**（形如 `https://xxxxx.supabase.co`）
   - **anon public key**（以 `eyJ` 开头的长字符串）

---

## 第二步：填写配置

打开 `public/supabase-config.js`，替换两行：

```js
const SUPABASE_URL = 'https://你的项目ID.supabase.co';
const SUPABASE_ANON_KEY = '你的 anon key';
```

---

## 第三步：部署到 Vercel

### 方式一：直接上传（推荐新手）
1. 登录 [https://vercel.com](https://vercel.com)
2. 点击 **"New Project"** → **"Browse"** 上传整个 `bdw-app` 文件夹
3. Framework 选 **Other**，Root Directory 选 `public`，点击 Deploy
4. 部署完成后获得网址，分享给老师们即可

### 方式二：通过 GitHub（推荐正式上线）
1. 将 `bdw-app` 文件夹推送到 GitHub 仓库
2. Vercel 连接 GitHub 仓库，自动部署
3. 每次 git push 自动更新网站

---

## 使用说明

| 功能 | 说明 |
|------|------|
| 登录 | 用 Supabase 后台添加的邮箱+密码登录 |
| 班级管理 | 创建多个班级，各班独立名单 |
| 学生管理 | 手动添加 或 粘贴批量导入（每行一个姓名） |
| 随机点名 | 选班级后点「点名」，支持空格键触发 |
| 不重复模式 | 本轮已点过的不再出现，全部点完后重置 |
| 缺席标记 | 点击学生名字标记缺席，不参与点名 |
| 重置本轮 | 清空本轮记录，重新开始 |

---

## 注意事项

- `supabase-config.js` 中的 `anon key` 是公开安全的，Supabase 的 RLS（行级安全）保证每位老师只能看到自己的数据
- 建议正式上线后绑定自定义域名
