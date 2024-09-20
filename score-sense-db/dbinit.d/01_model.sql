CREATE TABLE "admin" (
  "id" int8 NOT NULL,
  "username" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
  "password" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
  CONSTRAINT "admin_pkey" PRIMARY KEY ("id")
);
ALTER TABLE "admin" OWNER TO "postgres";
COMMENT ON COLUMN "admin"."id" IS '管理员 ID';
COMMENT ON COLUMN "admin"."username" IS '管理员用户名';
COMMENT ON COLUMN "admin"."password" IS '管理员密码';

CREATE TABLE "answer" (
  "exam_id" int8 NOT NULL,
  "question_id" int8 NOT NULL,
  "id" int8 NOT NULL,
  "user_id" int8 NOT NULL,
  "answer_text" text COLLATE "pg_catalog"."default" NOT NULL,
  "submitted_at" timestamp(6) NOT NULL DEFAULT now(),
  "score" int4 NOT NULL DEFAULT 0,
  CONSTRAINT "answer_pkey" PRIMARY KEY ("exam_id", "question_id", "id")
);
ALTER TABLE "answer" OWNER TO "postgres";
COMMENT ON COLUMN "answer"."exam_id" IS '考试 ID';
COMMENT ON COLUMN "answer"."question_id" IS '试题 ID';
COMMENT ON COLUMN "answer"."id" IS '答案 ID';
COMMENT ON COLUMN "answer"."user_id" IS '用户 ID';
COMMENT ON COLUMN "answer"."answer_text" IS '答案';
COMMENT ON COLUMN "answer"."submitted_at" IS '提交时间';
COMMENT ON COLUMN "answer"."score" IS '用户在该题获得的分数，将实际成绩 * 100 存储，如 100 分存储为 10,000。';

CREATE TABLE "exam" (
  "id" int8 NOT NULL,
  "name" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
  "description" text COLLATE "pg_catalog"."default",
  "province" char(2) NOT NULL,
  "prefecture" char(4) NOT NULL,
  CONSTRAINT "exam_pkey" PRIMARY KEY ("id")
);
ALTER TABLE "exam" OWNER TO "postgres";
COMMENT ON COLUMN "exam"."id" IS '考试 ID';
COMMENT ON COLUMN "exam"."name" IS '考试名称';
COMMENT ON COLUMN "exam"."description" IS '考试描述';
COMMENT ON COLUMN "exam"."province" IS '举办省份';
COMMENT ON COLUMN "exam"."prefecture" IS '举办城市';
COMMENT ON TABLE "exam" IS '考试信息';

CREATE TABLE "exam_result" (
  "id" int8 NOT NULL,
  "exam_id" int8 NOT NULL,
  "user_id" int8 NOT NULL,
  "vacancy_id" int8 NOT NULL,
  "total_score" int4 NOT NULL DEFAULT 0,
  "completed_at" timestamp(6) NOT NULL DEFAULT now(),
  CONSTRAINT "exam_result_pkey" PRIMARY KEY ("id")
);
ALTER TABLE "exam_result" OWNER TO "postgres";
COMMENT ON COLUMN "exam_result"."id" IS '考试结果 ID';
COMMENT ON COLUMN "exam_result"."exam_id" IS '考试 ID';
COMMENT ON COLUMN "exam_result"."user_id" IS '参考用户 ID';
COMMENT ON COLUMN "exam_result"."vacancy_id" IS '岗位 ID';
COMMENT ON COLUMN "exam_result"."total_score" IS '总成绩';
COMMENT ON COLUMN "exam_result"."completed_at" IS '完成考试时间';

CREATE TABLE "exam_vacancy" (
  "exam_id" int8 NOT NULL,
  "vacancy_id" int8 NOT NULL,
  PRIMARY KEY ("exam_id", "vacancy_id")
);
COMMENT ON COLUMN "exam_vacancy"."exam_id" IS '考试 ID';
COMMENT ON COLUMN "exam_vacancy"."vacancy_id" IS '岗位 ID';

CREATE TABLE "option" (
  "exam_id" int8 NOT NULL,
  "question_id" int8 NOT NULL,
  "id" char(1) COLLATE "pg_catalog"."default" NOT NULL,
  "option_text" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
  "is_correct" bool NOT NULL DEFAULT false,
  CONSTRAINT "option_pkey" PRIMARY KEY ("exam_id", "question_id", "id")
);
ALTER TABLE "option" OWNER TO "postgres";
COMMENT ON COLUMN "option"."exam_id" IS '考试 ID';
COMMENT ON COLUMN "option"."question_id" IS '试题 ID';
COMMENT ON COLUMN "option"."id" IS '选项 ID';
COMMENT ON COLUMN "option"."option_text" IS '选项文本';
COMMENT ON COLUMN "option"."is_correct" IS '是否是正确选项';

CREATE TABLE "prefecture" (
  "code" char(4) NOT NULL,
  "name" varchar(255) NOT NULL,
  "province_code" char(2) NOT NULL,
  PRIMARY KEY ("code")
);
COMMENT ON COLUMN "prefecture"."code" IS '城市代码';
COMMENT ON COLUMN "prefecture"."name" IS '城市名称';
COMMENT ON COLUMN "prefecture"."province_code" IS '所属省份代码';

CREATE TABLE "province" (
  "code" char(2) NOT NULL,
  "name" varchar(255) NOT NULL,
  PRIMARY KEY ("code")
);
COMMENT ON COLUMN "province"."code" IS '省份代码';
COMMENT ON COLUMN "province"."name" IS '省份名称';

CREATE TABLE "question" (
  "exam_id" int8 NOT NULL,
  "id" int8 NOT NULL,
  "type" int4 NOT NULL,
  "question_text" text COLLATE "pg_catalog"."default" NOT NULL,
  "max_score" int4 NOT NULL,
  CONSTRAINT "question_pkey" PRIMARY KEY ("exam_id", "id")
);
ALTER TABLE "question" OWNER TO "postgres";
COMMENT ON COLUMN "question"."exam_id" IS '考试 ID';
COMMENT ON COLUMN "question"."id" IS '题目 ID';
COMMENT ON COLUMN "question"."type" IS '试题类型';
COMMENT ON COLUMN "question"."question_text" IS '题干';
COMMENT ON COLUMN "question"."max_score" IS '题目满分，将实际成绩 * 100 存储，如 100 存储为 10,000';
COMMENT ON TABLE "question" IS '试题';

CREATE TABLE "sequence" (
  "key" varchar(255) NOT NULL,
  "next_sequence" int4 NOT NULL,
  PRIMARY KEY ("key")
);
COMMENT ON COLUMN "sequence"."key" IS '序号 key';
COMMENT ON COLUMN "sequence"."next_sequence" IS '下一序号';
COMMENT ON TABLE "sequence" IS '序号';

CREATE TABLE "swipe" (
  "sequence" int4 NOT NULL,
  "image_url" varchar(255) NOT NULL,
  PRIMARY KEY ("sequence")
);
COMMENT ON COLUMN "swipe"."sequence" IS '轮播图顺序';
COMMENT ON COLUMN "swipe"."image_url" IS '图片 URL';
COMMENT ON TABLE "swipe" IS '轮播图';

CREATE TABLE "user" (
  "id" int8 NOT NULL,
  "open_id" char(28) COLLATE "pg_catalog"."default" NOT NULL,
  "username" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
  "phone_number" char(11) COLLATE "pg_catalog"."default" NOT NULL,
  "avatar_url" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
  "is_blocked" bool NOT NULL DEFAULT false,
  CONSTRAINT "user_pkey" PRIMARY KEY ("id")
);
ALTER TABLE "user" OWNER TO "postgres";
CREATE UNIQUE INDEX "user_open_id_uindex" ON "user" USING btree (
  "open_id" COLLATE "pg_catalog"."default" "pg_catalog"."bpchar_ops" ASC NULLS LAST
);
COMMENT ON COLUMN "user"."id" IS '用户 ID';
COMMENT ON COLUMN "user"."open_id" IS '用户微信 ID';
COMMENT ON COLUMN "user"."username" IS '用户名';
COMMENT ON COLUMN "user"."phone_number" IS '用户联系电话';
COMMENT ON COLUMN "user"."avatar_url" IS '用户头像地址';
COMMENT ON COLUMN "user"."is_blocked" IS '用户是否被封禁';

CREATE TABLE "vacancy" (
  "id" int8 NOT NULL,
  "name" varchar(255) NOT NULL,
  "province" char(2) NOT NULL,
  "prefecture" char(4) NOT NULL,
  PRIMARY KEY ("id")
);
COMMENT ON COLUMN "vacancy"."id" IS '岗位 ID';
COMMENT ON COLUMN "vacancy"."name" IS '岗位名称';
COMMENT ON COLUMN "vacancy"."province" IS '岗位所在省份';
COMMENT ON COLUMN "vacancy"."prefecture" IS '岗位所在城市';

