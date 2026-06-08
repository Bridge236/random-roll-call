-- ==================================================
-- 别点我 · 随机点名系统 — Supabase 数据库初始化 SQL
-- 在 Supabase 控制台 → SQL Editor 中运行此脚本
-- ==================================================

-- 1. 班级表
CREATE TABLE IF NOT EXISTS classes (
  id          UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id     UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  name        TEXT NOT NULL,
  created_at  TIMESTAMPTZ DEFAULT now()
);

-- 2. 学生表
CREATE TABLE IF NOT EXISTS students (
  id          UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  class_id    UUID NOT NULL REFERENCES classes(id) ON DELETE CASCADE,
  user_id     UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  name        TEXT NOT NULL,
  created_at  TIMESTAMPTZ DEFAULT now()
);

-- 3. 点名记录表
CREATE TABLE IF NOT EXISTS roll_records (
  id           UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  class_id     UUID NOT NULL REFERENCES classes(id) ON DELETE CASCADE,
  student_id   UUID REFERENCES students(id) ON DELETE SET NULL,
  student_name TEXT NOT NULL,
  user_id      UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  rolled_at    TIMESTAMPTZ DEFAULT now()
);

-- ==================================================
-- Row Level Security (RLS) — 每位老师只能访问自己的数据
-- ==================================================

ALTER TABLE classes     ENABLE ROW LEVEL SECURITY;
ALTER TABLE students    ENABLE ROW LEVEL SECURITY;
ALTER TABLE roll_records ENABLE ROW LEVEL SECURITY;

-- classes
CREATE POLICY "teacher_own_classes" ON classes
  FOR ALL USING (auth.uid() = user_id);

-- students
CREATE POLICY "teacher_own_students" ON students
  FOR ALL USING (auth.uid() = user_id);

-- roll_records
CREATE POLICY "teacher_own_records" ON roll_records
  FOR ALL USING (auth.uid() = user_id);

-- ==================================================
-- 索引（提升查询速度）
-- ==================================================
CREATE INDEX IF NOT EXISTS idx_classes_user     ON classes(user_id);
CREATE INDEX IF NOT EXISTS idx_students_class   ON students(class_id);
CREATE INDEX IF NOT EXISTS idx_records_class    ON roll_records(class_id);
CREATE INDEX IF NOT EXISTS idx_records_rolled   ON roll_records(rolled_at DESC);
