// Supabase 配置
// 部署前请将下方两个值替换为你在 Supabase 控制台 -> Settings -> API 中找到的值
const SUPABASE_URL = 'https://umxkyoyqsakwfcombcie.supabase.co';
const SUPABASE_ANON_KEY = 'sb_publishable_X0I5Q7gecC8EbAUbNNPizQ_5P9YBAwg';

// 初始化 Supabase 客户端（使用 CDN 版本）
const { createClient } = supabase;
const sb = createClient(SUPABASE_URL, SUPABASE_ANON_KEY);
