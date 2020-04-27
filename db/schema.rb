# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20200403071721) do

  create_table "active_admin_comments", force: :cascade do |t|
    t.string   "resource_id",               null: false
    t.string   "resource_type",             null: false
    t.integer  "author_id",     limit: nil
    t.string   "author_type"
    t.text     "body"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "namespace"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], name: "i_act_adm_com_aut_typ_aut_id"
  add_index "active_admin_comments", ["namespace"], name: "i_act_adm_com_nam"
  add_index "active_admin_comments", ["resource_type", "resource_id"], name: "i_act_adm_com_res_typ_res_id"

  create_table "admin_roles", force: :cascade do |t|
    t.string   "name"
    t.integer  "resource_id",   limit: nil
    t.string   "resource_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "admin_roles", ["name", "resource_type", "resource_id"], name: "i_adm_rol_nam_res_typ_res_id"
  add_index "admin_roles", ["name"], name: "index_admin_roles_on_name"

  create_table "admin_users", force: :cascade do |t|
    t.string    "email",                                             default: "",    null: false
    t.string    "encrypted_password",                                default: "",    null: false
    t.string    "reset_password_token"
    t.datetime  "reset_password_sent_at"
    t.datetime  "remember_created_at"
    t.integer   "sign_in_count",                      precision: 38, default: 0
    t.datetime  "current_sign_in_at"
    t.datetime  "last_sign_in_at"
    t.string    "current_sign_in_ip"
    t.string    "last_sign_in_ip"
    t.datetime  "created_at"
    t.datetime  "updated_at"
    t.string    "username"
    t.string    "unique_session_id",      limit: 20
    t.boolean   "inactive",               limit: nil,                default: false
    t.integer   "failed_attempts",                    precision: 38, default: 0
    t.string    "unlock_token"
    t.datetime  "locked_at"
    t.datetime  "password_changed_at"
    t.timestamp "notification_sent_at",   limit: 6
    t.string    "first_name"
    t.boolean   "active",                 limit: nil,                default: true
    t.string    "last_name"
  end

  add_index "admin_users", ["email"], name: "index_admin_users_on_email", unique: true
  add_index "admin_users", ["password_changed_at"], name: "i_adm_use_pas_cha_at"
  add_index "admin_users", ["reset_password_token"], name: "i_adm_use_res_pas_tok", unique: true
  add_index "admin_users", ["username"], name: "admin_users_01", unique: true

  create_table "admin_users_admin_roles", id: false, force: :cascade do |t|
    t.integer "admin_user_id", limit: nil
    t.integer "admin_role_id", limit: nil
  end

  add_index "admin_users_admin_roles", ["admin_user_id", "admin_role_id"], name: "index_on_user_roles"

  create_table "ae_apps", force: :cascade do |t|
    t.string   "app_id",                   limit: 20,                               null: false
    t.string   "allow_access_with_app_id", limit: 1,                                null: false
    t.string   "customer_id",              limit: 15
    t.string   "is_enabled",               limit: 1,                  default: "Y", null: false
    t.string   "identity_user_id"
    t.datetime "created_at",                                                        null: false
    t.datetime "updated_at",                                                        null: false
    t.string   "created_by",               limit: 20
    t.string   "updated_by",               limit: 20
    t.integer  "lock_version",                         precision: 38, default: 0,   null: false
    t.string   "last_action",              limit: 1,                  default: "C", null: false
    t.string   "approval_status",          limit: 1,                  default: "U", null: false
    t.integer  "approved_version",                     precision: 38
    t.integer  "approved_id",              limit: nil
  end

  add_index "ae_apps", ["app_id", "customer_id", "approval_status"], name: "ae_apps_01", unique: true

  create_table "api_keys", force: :cascade do |t|
    t.string   "access_token"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "applications", force: :cascade do |t|
    t.string "name"
    t.string "class_name", limit: 1000
    t.string "kind"
  end

  create_table "ar_internal_metadata", primary_key: "key", force: :cascade do |t|
    t.string    "value"
    t.timestamp "created_at", limit: 6, null: false
    t.timestamp "updated_at", limit: 6, null: false
  end

  create_table "asba_audit_steps", force: :cascade do |t|
    t.string   "req_no",            limit: 32,                  null: false
    t.integer  "attempt_no",                     precision: 38, null: false
    t.string   "status_code",       limit: 100,                 null: false
    t.string   "app_id",            limit: 50,                  null: false
    t.string   "broker_code",       limit: 45,                  null: false
    t.string   "op_name",           limit: 100,                 null: false
    t.string   "req_version",       limit: 5,                   null: false
    t.datetime "req_timestamp",                                 null: false
    t.text     "req_bitstream"
    t.datetime "up_req_timestamp"
    t.string   "up_host",           limit: 100
    t.string   "up_req_uri",        limit: 100
    t.text     "up_req_header"
    t.text     "up_req_bitstream"
    t.string   "rep_version",       limit: 5
    t.datetime "rep_timestamp"
    t.text     "rep_bitstream"
    t.datetime "up_rep_timestamp"
    t.text     "up_rep_header"
    t.text     "up_rep_bitstream"
    t.string   "bank_reference_no", limit: 50
    t.string   "fault_code",        limit: 50
    t.string   "fault_subcode",     limit: 50
    t.string   "fault_reason",      limit: 1000
    t.text     "fault_bitstream"
  end

  create_table "asba_brokers", force: :cascade do |t|
    t.string   "code",             limit: 45,                               null: false
    t.string   "name",             limit: 100,                              null: false
    t.string   "location",         limit: 50,                               null: false
    t.string   "app_id",           limit: 50,                               null: false
    t.string   "is_enabled",       limit: 1,                  default: "Y", null: false
    t.datetime "created_at",                                                null: false
    t.datetime "updated_at",                                                null: false
    t.string   "created_by",       limit: 20
    t.string   "updated_by",       limit: 20
    t.integer  "lock_version",                 precision: 38, default: 0,   null: false
    t.string   "last_action",      limit: 1,                  default: "C", null: false
    t.string   "approval_status",  limit: 1,                  default: "U", null: false
    t.integer  "approved_version",             precision: 38
    t.integer  "approved_id",      limit: nil
  end

  add_index "asba_brokers", ["code", "app_id", "approval_status"], name: "asba_brokers_01", unique: true

  create_table "assigned_brokers", force: :cascade do |t|
    t.integer "broker_id",      limit: nil
    t.integer "service_id",     limit: nil
    t.integer "application_id", limit: nil
  end

  create_table "attachments", force: :cascade do |t|
    t.string   "note"
    t.string   "file"
    t.integer  "attachable_id",   limit: nil
    t.string   "attachable_type"
    t.string   "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "attachments", ["attachable_id"], name: "i_attachments_attachable_id"

  create_table "auditreport_20180807_20190131", id: false, force: :cascade do |t|
    t.integer "id",                limit: nil,                null: false
    t.string  "req_no",                                       null: false
    t.integer "attempt_no",                    precision: 38, null: false
    t.string  "status_code",       limit: 25,                 null: false
    t.string  "app_id",            limit: 50,                 null: false
    t.string  "sb_auditable_type", limit: 50,                 null: false
    t.integer "sb_auditable_id",   limit: nil,                null: false
    t.text    "req_bitstream",                                null: false
    t.text    "rep_bitstream"
  end

  create_table "auditreport_20181101_20181231", id: false, force: :cascade do |t|
    t.integer "id",                limit: nil,                null: false
    t.string  "req_no",                                       null: false
    t.integer "attempt_no",                    precision: 38, null: false
    t.string  "status_code",       limit: 25,                 null: false
    t.string  "app_id",            limit: 50,                 null: false
    t.string  "sb_auditable_type", limit: 50,                 null: false
    t.integer "sb_auditable_id",   limit: nil,                null: false
    t.text    "req_bitstream",                                null: false
    t.text    "rep_bitstream"
  end

  create_table "auditreport_20181101_20190101", id: false, force: :cascade do |t|
    t.integer "id",                limit: nil,                null: false
    t.string  "req_no",                                       null: false
    t.integer "attempt_no",                    precision: 38, null: false
    t.string  "status_code",       limit: 25,                 null: false
    t.string  "app_id",            limit: 50,                 null: false
    t.string  "sb_auditable_type", limit: 50,                 null: false
    t.integer "sb_auditable_id",   limit: nil,                null: false
    t.text    "req_bitstream",                                null: false
    t.text    "rep_bitstream"
  end

  create_table "auditreport_20190101_20190131", id: false, force: :cascade do |t|
    t.integer "id",                limit: nil,                null: false
    t.string  "req_no",                                       null: false
    t.integer "attempt_no",                    precision: 38, null: false
    t.string  "status_code",       limit: 25,                 null: false
    t.string  "app_id",            limit: 50,                 null: false
    t.string  "sb_auditable_type", limit: 50,                 null: false
    t.integer "sb_auditable_id",   limit: nil,                null: false
    t.text    "req_bitstream",                                null: false
    t.text    "rep_bitstream"
  end

  create_table "auditreport_20190118_20190118", id: false, force: :cascade do |t|
    t.integer "id",                limit: nil,                null: false
    t.string  "req_no",                                       null: false
    t.integer "attempt_no",                    precision: 38, null: false
    t.string  "status_code",       limit: 25,                 null: false
    t.string  "app_id",            limit: 50,                 null: false
    t.string  "sb_auditable_type", limit: 50,                 null: false
    t.integer "sb_auditable_id",   limit: nil,                null: false
    t.text    "req_bitstream",                                null: false
    t.text    "rep_bitstream"
  end

  create_table "auditreport_20190118_20190119", id: false, force: :cascade do |t|
    t.integer "id",                limit: nil,                null: false
    t.string  "req_no",                                       null: false
    t.integer "attempt_no",                    precision: 38, null: false
    t.string  "status_code",       limit: 25,                 null: false
    t.string  "app_id",            limit: 50,                 null: false
    t.string  "sb_auditable_type", limit: 50,                 null: false
    t.integer "sb_auditable_id",   limit: nil,                null: false
    t.text    "req_bitstream",                                null: false
    t.text    "rep_bitstream"
  end

  create_table "auditreport_20190131", id: false, force: :cascade do |t|
    t.integer "id",                limit: nil,                null: false
    t.string  "req_no",                                       null: false
    t.integer "attempt_no",                    precision: 38, null: false
    t.string  "status_code",       limit: 25,                 null: false
    t.string  "app_id",            limit: 50,                 null: false
    t.string  "sb_auditable_type", limit: 50,                 null: false
    t.integer "sb_auditable_id",   limit: nil,                null: false
    t.text    "req_bitstream",                                null: false
    t.text    "rep_bitstream"
  end

  create_table "audits", force: :cascade do |t|
    t.integer   "auditable_id",    limit: nil
    t.string    "auditable_type"
    t.integer   "associated_id",   limit: nil
    t.string    "associated_type"
    t.integer   "user_id",         limit: nil
    t.string    "user_type"
    t.string    "username"
    t.string    "action"
    t.text      "audited_changes"
    t.integer   "version",                     precision: 38, default: 0
    t.string    "comment"
    t.string    "remote_address"
    t.string    "request_uuid"
    t.timestamp "created_at",      limit: 6
  end

  add_index "audits", ["associated_id", "associated_type"], name: "associated_index"
  add_index "audits", ["auditable_id", "auditable_type"], name: "auditable_index"
  add_index "audits", ["created_at"], name: "index_audits_on_created_at"
  add_index "audits", ["request_uuid"], name: "index_audits_on_request_uuid"
  add_index "audits", ["user_id", "user_type"], name: "user_index"

  create_table "auto_archivals", force: :cascade do |t|
    t.string   "created_by"
    t.string   "updated_by"
    t.integer  "lock_version",                    precision: 38, default: 0,   null: false
    t.string   "service_name"
    t.string   "table_name"
    t.date     "from_date"
    t.date     "to_date"
    t.string   "status"
    t.string   "archival_table_name"
    t.string   "approval_status",     limit: 1,                  default: "U", null: false
    t.string   "last_action",         limit: 1,                  default: "C"
    t.integer  "approved_id",         limit: nil
    t.integer  "approved_version",                precision: 38
    t.datetime "created_at",                                                   null: false
    t.datetime "updated_at",                                                   null: false
  end

  create_table "banks", force: :cascade do |t|
    t.string   "ifsc"
    t.string   "name"
    t.boolean  "imps_enabled",     limit: nil
    t.datetime "created_at",                                                null: false
    t.datetime "updated_at",                                                null: false
    t.string   "created_by"
    t.string   "updated_by"
    t.integer  "lock_version",                 precision: 38, default: 0,   null: false
    t.string   "approval_status",  limit: 1,                  default: "U", null: false
    t.string   "last_action",      limit: 1,                  default: "C"
    t.integer  "approved_version",             precision: 38
    t.integer  "approved_id",      limit: nil
    t.string   "upi_enabled",      limit: 1,                  default: "Y", null: false
  end

  add_index "banks", ["ifsc", "approval_status"], name: "i_banks_ifsc_approval_status", unique: true

  create_table "banks_bkp_181001to181115", id: false, force: :cascade do |t|
    t.integer  "id",               limit: nil,                null: false
    t.string   "ifsc"
    t.string   "name"
    t.boolean  "imps_enabled",     limit: nil
    t.datetime "created_at",                                  null: false
    t.datetime "updated_at",                                  null: false
    t.string   "created_by"
    t.string   "updated_by"
    t.integer  "lock_version",                 precision: 38, null: false
    t.string   "approval_status",  limit: 1,                  null: false
    t.string   "last_action",      limit: 1
    t.integer  "approved_version",             precision: 38
    t.integer  "approved_id",      limit: nil
  end

  create_table "bm_add_auto_pays", force: :cascade do |t|
    t.string   "app_id",         limit: 20,                  null: false
    t.string   "req_no",         limit: 32,                  null: false
    t.integer  "attempt_no",                  precision: 38, null: false
    t.string   "req_version",    limit: 5,                   null: false
    t.datetime "req_timestamp",                              null: false
    t.string   "customer_id",    limit: 15,                  null: false
    t.string   "status_code",    limit: 50,                  null: false
    t.string   "biller_code",    limit: 100,                 null: false
    t.string   "debit_acct_no",  limit: 20
    t.string   "credit_card_no", limit: 20
    t.integer  "num_params",                  precision: 38, null: false
    t.string   "param1",         limit: 100
    t.string   "param2",         limit: 100
    t.string   "param3",         limit: 100
    t.string   "param4",         limit: 100
    t.string   "param5",         limit: 100
    t.decimal  "amount_limit"
    t.date     "start_date"
    t.date     "end_date"
    t.string   "interval",       limit: 20
    t.string   "email_id1",      limit: 100
    t.string   "email_id2",      limit: 100
    t.string   "mobile_no",      limit: 20
    t.string   "rep_version",    limit: 5
    t.string   "rep_no",         limit: 32
    t.string   "biller_acct_no", limit: 50
    t.datetime "rep_timestamp"
    t.string   "fault_code",     limit: 50
    t.string   "fault_subcode",  limit: 50
    t.string   "fault_reason",   limit: 1000
  end

  add_index "bm_add_auto_pays", ["customer_id", "req_no", "status_code", "biller_code", "req_timestamp", "rep_timestamp"], name: "bm_add_auto_pays_02"
  add_index "bm_add_auto_pays", ["req_no", "app_id", "attempt_no"], name: "bm_add_auto_pays_01", unique: true

  create_table "bm_add_biller_accts", force: :cascade do |t|
    t.string   "app_id",             limit: 50,                  null: false
    t.string   "req_no",             limit: 32,                  null: false
    t.integer  "attempt_no",                      precision: 38, null: false
    t.string   "req_version",        limit: 5,                   null: false
    t.datetime "req_timestamp",                                  null: false
    t.string   "customer_id",        limit: 15,                  null: false
    t.string   "biller_code",        limit: 50,                  null: false
    t.integer  "num_params",                      precision: 38, null: false
    t.string   "param1",             limit: 100
    t.string   "param2",             limit: 100
    t.string   "param3",             limit: 100
    t.string   "param4",             limit: 100
    t.string   "param5",             limit: 100
    t.string   "status_code",        limit: 50,                  null: false
    t.string   "rep_version",        limit: 5
    t.string   "rep_no",             limit: 32
    t.datetime "rep_timestamp"
    t.string   "biller_acct_no",     limit: 50
    t.string   "biller_acct_status", limit: 50
    t.string   "fault_code",         limit: 50
    t.string   "fault_reason",       limit: 1000
    t.string   "biller_nickname",    limit: 10
  end

  add_index "bm_add_biller_accts", ["app_id", "req_no", "attempt_no"], name: "attempt_no_index_add_accts", unique: true
  add_index "bm_add_biller_accts", ["biller_acct_no", "customer_id", "status_code"], name: "idx_by_ban_cid_sc"

  create_table "bm_aggregator_payments", force: :cascade do |t|
    t.string   "cod_acct_no",                limit: 50,                                  null: false
    t.string   "neft_sender_ifsc",                                                       null: false
    t.string   "bene_acct_no",               limit: 50,                                  null: false
    t.integer  "lock_version",                            precision: 38,                 null: false
    t.datetime "created_at",                                                             null: false
    t.datetime "updated_at",                                                             null: false
    t.string   "approval_status",            limit: 1,                   default: "U",   null: false
    t.string   "last_action",                limit: 1
    t.integer  "approved_version",                        precision: 38
    t.integer  "approved_id",                limit: nil
    t.string   "status",                     limit: 50,                  default: "NEW", null: false
    t.string   "fault_code",                 limit: 50
    t.string   "fault_reason",               limit: 1000
    t.string   "neft_req_ref",               limit: 64
    t.integer  "neft_attempt_no",                         precision: 38
    t.string   "neft_rep_ref",               limit: 64
    t.datetime "neft_completed_at"
    t.string   "pending_approval",           limit: 1,                   default: "f",   null: false
    t.string   "bene_acct_ifsc",                                         default: "1",   null: false
    t.string   "rmtr_to_bene_note"
    t.string   "is_reconciled",              limit: 1,                   default: "Y",   null: false
    t.datetime "reconciled_at"
    t.datetime "neft_attempt_at"
    t.string   "customer_id",                limit: 50,                  default: " ",   null: false
    t.string   "rmtr_name",                  limit: 50,                  default: "",    null: false
    t.string   "service_id"
    t.string   "bene_name"
    t.string   "created_by",                 limit: 20
    t.string   "updated_by",                 limit: 20
    t.decimal  "payment_amount"
    t.string   "pool_account"
    t.string   "neft_sender_account"
    t.string   "benfficiary_account_number"
    t.string   "benfficiary_account_ifsc"
  end

  create_table "bm_apps", force: :cascade do |t|
    t.string   "app_id",           limit: 20,                               null: false
    t.string   "channel_id",       limit: 20,                               null: false
    t.integer  "lock_version",                 precision: 38,               null: false
    t.string   "approval_status",                             default: "U", null: false
    t.string   "last_action",      limit: 1
    t.integer  "approved_version",             precision: 38
    t.integer  "approved_id",      limit: nil
    t.datetime "created_at",                                                null: false
    t.datetime "updated_at",                                                null: false
    t.string   "created_by",       limit: 20
    t.string   "updated_by",       limit: 20
    t.string   "needs_otp",        limit: 1,                  default: "f", null: false
  end

  add_index "bm_apps", ["app_id", "approval_status"], name: "i_bm_app_app_id_app_sta", unique: true

  create_table "bm_audit_logs", force: :cascade do |t|
    t.string   "app_id",            limit: 50,                  null: false
    t.string   "req_no",            limit: 32,                  null: false
    t.integer  "attempt_no",                     precision: 38, null: false
    t.string   "status_code",       limit: 25,                  null: false
    t.string   "bm_auditable_type", limit: 50,                  null: false
    t.integer  "bm_auditable_id",   limit: nil,                 null: false
    t.string   "fault_code",        limit: 50
    t.string   "fault_reason",      limit: 1000
    t.text     "req_bitstream"
    t.datetime "req_timestamp"
    t.text     "rep_bitstream"
    t.datetime "rep_timestamp"
    t.text     "fault_bitstream"
    t.string   "fault_subcode",     limit: 50
  end

  add_index "bm_audit_logs", ["app_id", "req_no", "attempt_no"], name: "attempt_no_index_audit_logs", unique: true
  add_index "bm_audit_logs", ["bm_auditable_type", "bm_auditable_id"], name: "auditable_index_audit_logs", unique: true

  create_table "bm_audit_steps", force: :cascade do |t|
    t.string   "bm_auditable_type",                             null: false
    t.integer  "bm_auditable_id",   limit: nil,                 null: false
    t.integer  "step_no",                        precision: 38, null: false
    t.integer  "attempt_no",                     precision: 38, null: false
    t.string   "step_name",         limit: 100,                 null: false
    t.string   "status_code",       limit: 25,                  null: false
    t.string   "fault_code",        limit: 50
    t.string   "fault_reason",      limit: 1000
    t.string   "req_reference"
    t.datetime "req_timestamp"
    t.string   "rep_reference"
    t.datetime "rep_timestamp"
    t.text     "req_bitstream"
    t.text     "rep_bitstream"
    t.text     "fault_bitstream"
    t.string   "fault_subcode",     limit: 50
  end

  add_index "bm_audit_steps", ["bm_auditable_type", "bm_auditable_id", "step_no", "attempt_no"], name: "bm_audit_steps_01", unique: true

  create_table "bm_bill_payments", force: :cascade do |t|
    t.string   "app_id",              limit: 50,                                null: false
    t.string   "req_no",              limit: 32,                                null: false
    t.integer  "attempt_no",                       precision: 38,               null: false
    t.string   "req_version",         limit: 5,                                 null: false
    t.datetime "req_timestamp",                                                 null: false
    t.string   "customer_id",         limit: 15,                                null: false
    t.string   "debit_account_no",    limit: 50,                                null: false
    t.string   "txn_kind",            limit: 50,                                null: false
    t.string   "biller_code",         limit: 50
    t.string   "biller_acct_no",      limit: 50
    t.string   "bill_id",             limit: 50
    t.string   "status",              limit: 50,                                null: false
    t.string   "fault_code",          limit: 50
    t.string   "fault_reason",        limit: 1000
    t.string   "debit_req_ref",       limit: 64
    t.integer  "debit_attempt_no",                 precision: 38
    t.datetime "debit_attempt_at"
    t.string   "debit_rep_ref",       limit: 64
    t.datetime "debited_at"
    t.string   "billpay_req_ref",     limit: 64
    t.integer  "billpay_attempt_no",               precision: 38
    t.datetime "billpay_attempt_at"
    t.string   "billpay_rep_ref",     limit: 64
    t.datetime "billpaid_at"
    t.string   "reversal_req_ref",    limit: 64
    t.integer  "reversal_attempt_no",              precision: 38
    t.datetime "reversal_attempt_at"
    t.string   "reversal_rep_ref",    limit: 64
    t.datetime "reversal_at"
    t.string   "refund_ref",          limit: 64
    t.datetime "refund_at"
    t.string   "is_reconciled",       limit: 1
    t.datetime "reconciled_at"
    t.string   "pending_approval",    limit: 1,                   default: "Y"
    t.string   "service_id"
    t.string   "rep_no",              limit: 32
    t.string   "rep_version",         limit: 5
    t.datetime "rep_timestamp"
    t.string   "param1",              limit: 100
    t.string   "param2",              limit: 100
    t.string   "param3",              limit: 100
    t.string   "param4",              limit: 100
    t.string   "param5",              limit: 100
    t.string   "cod_pool_acct_no",    limit: 100
    t.date     "bill_date"
    t.date     "due_date"
    t.string   "bill_number",         limit: 50
    t.string   "billpay_bank_ref",    limit: 20
    t.decimal  "txn_amount",                                                    null: false
    t.string   "biller_id"
    t.string   "isbbps"
    t.string   "payment_status"
    t.string   "biller_acct_id"
    t.string   "biller_status"
    t.string   "payment_method"
  end

  add_index "bm_bill_payments", ["app_id", "req_no", "attempt_no"], name: "attepmt_index_bill_payments", unique: true
  add_index "bm_bill_payments", ["billpay_rep_ref"], name: "uk_billpay_rep_ref", unique: true
  add_index "bm_bill_payments", ["status", "txn_kind", "req_timestamp"], name: "bm_bill_payments_01"

  create_table "bm_billers", force: :cascade do |t|
    t.string   "biller_code",              limit: 100,                              null: false
    t.string   "biller_name",              limit: 100,                              null: false
    t.string   "biller_category",          limit: 100,                              null: false
    t.string   "biller_location",          limit: 100,                              null: false
    t.string   "processing_method",        limit: 1,                                null: false
    t.string   "is_enabled",               limit: 1,                                null: false
    t.integer  "num_params",                           precision: 38, default: 0,   null: false
    t.string   "param1_name",              limit: 100
    t.string   "param1_pattern",           limit: 100
    t.string   "param1_tooltip"
    t.string   "param2_name",              limit: 100
    t.string   "param2_pattern",           limit: 100
    t.string   "param2_tooltip"
    t.string   "param3_name",              limit: 100
    t.string   "param3_pattern",           limit: 100
    t.string   "param3_tooltip"
    t.string   "param4_name",              limit: 100
    t.string   "param4_pattern",           limit: 100
    t.string   "param4_tooltip"
    t.string   "param5_name",              limit: 100
    t.string   "param5_pattern",           limit: 100
    t.string   "param5_tooltip"
    t.integer  "lock_version",                         precision: 38,               null: false
    t.datetime "created_at",                                                        null: false
    t.datetime "updated_at",                                                        null: false
    t.string   "approval_status",                                     default: "U", null: false
    t.string   "last_action",              limit: 1
    t.integer  "approved_version",                     precision: 38
    t.integer  "approved_id",              limit: nil
    t.string   "created_by",               limit: 20
    t.string   "updated_by",               limit: 20
    t.string   "partial_pay",              limit: 1
    t.string   "biller_nickname",          limit: 10
    t.string   "biller_mode"
    t.string   "isbillerbbps"
    t.string   "allowed_payment_method"
    t.string   "allowed_payment_channels"
    t.string   "online_validation"
    t.string   "paymentamount_validatio"
    t.string   "paymentamount_validation"
    t.string   "additionalvalidation"
    t.string   "additional_validation"
    t.string   "biller_status"
    t.string   "biller_type"
    t.string   "pay_after_duedate"
    t.string   "objectid"
    t.string   "billerid"
    t.string   "parameter_name"
    t.string   "allowed_autopay"
  end

  add_index "bm_billers", ["biller_category", "biller_location", "approval_status", "is_enabled"], name: "bm_billers_01"
  add_index "bm_billers", ["biller_code", "approval_status"], name: "i_bm_bil_bil_cod_app_sta", unique: true
  add_index "bm_billers", ["biller_code"], name: "i_bm_billers_biller_code", unique: true
  add_index "bm_billers", ["biller_location", "approval_status", "is_enabled"], name: "bm_billers_02"

  create_table "bm_billpay_steps", force: :cascade do |t|
    t.integer  "bm_bill_payment_id", limit: nil,                 null: false
    t.integer  "step_no",                         precision: 38, null: false
    t.integer  "attempt_no",                      precision: 38, null: false
    t.string   "step_name",          limit: 100,                 null: false
    t.string   "status_code",        limit: 25,                  null: false
    t.string   "fault_code",         limit: 50
    t.string   "fault_reason",       limit: 1000
    t.string   "req_reference"
    t.text     "req_bitstream"
    t.datetime "req_timestamp"
    t.string   "rep_reference"
    t.text     "rep_bitstream"
    t.datetime "rep_timestamp"
    t.text     "fault_bitstream"
  end

  add_index "bm_billpay_steps", ["bm_bill_payment_id", "step_no", "attempt_no"], name: "attepmt_no_index_billpay_steps", unique: true

  create_table "bm_del_biller_accts", force: :cascade do |t|
    t.string   "app_id",         limit: 50,                  null: false
    t.string   "req_no",         limit: 32,                  null: false
    t.integer  "attempt_no",                  precision: 38, null: false
    t.string   "req_version",    limit: 5,                   null: false
    t.datetime "req_timestamp",                              null: false
    t.string   "customer_id",    limit: 15,                  null: false
    t.string   "biller_acct_no", limit: 50
    t.string   "status_code",    limit: 50,                  null: false
    t.string   "rep_version",    limit: 5
    t.string   "rep_no",         limit: 32
    t.datetime "rep_timestamp"
    t.string   "fault_code",     limit: 50
    t.string   "fault_reason",   limit: 1000
  end

  add_index "bm_del_biller_accts", ["app_id", "req_no", "attempt_no"], name: "attempt_no_index_del_accts", unique: true

  create_table "bm_delete_auto_pays", force: :cascade do |t|
    t.string   "app_id",         limit: 20,                  null: false
    t.string   "req_no",         limit: 32,                  null: false
    t.integer  "attempt_no",                  precision: 38, null: false
    t.string   "req_version",    limit: 5,                   null: false
    t.datetime "req_timestamp",                              null: false
    t.string   "customer_id",    limit: 15,                  null: false
    t.string   "status_code",    limit: 50,                  null: false
    t.string   "biller_code",    limit: 100,                 null: false
    t.string   "biller_acct_no", limit: 50
    t.string   "rep_version",    limit: 5
    t.string   "rep_no",         limit: 32
    t.datetime "rep_timestamp"
    t.string   "fault_code",     limit: 50
    t.string   "fault_subcode",  limit: 50
    t.string   "fault_reason",   limit: 1000
  end

  add_index "bm_delete_auto_pays", ["customer_id", "req_no", "status_code", "biller_code", "req_timestamp", "rep_timestamp"], name: "bm_delete_auto_pays_02"
  add_index "bm_delete_auto_pays", ["req_no", "app_id", "attempt_no"], name: "bm_delete_auto_pays_01", unique: true

  create_table "bm_modify_auto_pays", force: :cascade do |t|
    t.string   "app_id",         limit: 50,                  null: false
    t.string   "req_no",         limit: 32,                  null: false
    t.integer  "attempt_no",                  precision: 38, null: false
    t.string   "req_version",    limit: 5,                   null: false
    t.datetime "req_timestamp",                              null: false
    t.string   "customer_id",    limit: 15,                  null: false
    t.string   "status_code",    limit: 50,                  null: false
    t.string   "biller_code",    limit: 100,                 null: false
    t.string   "biller_acct_no", limit: 50,                  null: false
    t.decimal  "amount_limit"
    t.date     "start_date"
    t.date     "end_date"
    t.string   "interval",       limit: 20
    t.string   "email_id1",      limit: 100
    t.string   "email_id2",      limit: 100
    t.string   "mobile_no",      limit: 20
    t.string   "rep_version",    limit: 5
    t.string   "rep_no",         limit: 32
    t.datetime "rep_timestamp"
    t.string   "fault_code",     limit: 50
    t.string   "fault_subcode",  limit: 50
    t.string   "fault_reason",   limit: 1000
  end

  add_index "bm_modify_auto_pays", ["customer_id", "req_no", "status_code", "biller_code", "req_timestamp", "rep_timestamp"], name: "bm_modify_auto_pays_02"
  add_index "bm_modify_auto_pays", ["req_no", "app_id", "attempt_no"], name: "bm_modify_auto_pays_01", unique: true

  create_table "bm_pay_bills", force: :cascade do |t|
    t.string   "app_id",              limit: 50,                  null: false
    t.string   "req_no",              limit: 32,                  null: false
    t.integer  "attempt_no",                       precision: 38, null: false
    t.string   "req_version",         limit: 5,                   null: false
    t.datetime "req_timestamp",                                   null: false
    t.string   "customer_id",         limit: 15,                  null: false
    t.string   "debit_account_no",    limit: 50,                  null: false
    t.string   "bill_id",             limit: 50,                  null: false
    t.string   "status_code",         limit: 50,                  null: false
    t.string   "rep_version",         limit: 5
    t.string   "rep_no",              limit: 32
    t.datetime "rep_timestamp"
    t.string   "debit_reference_no",  limit: 32
    t.string   "biller_reference_no", limit: 32
    t.string   "fault_code",          limit: 50
    t.string   "fault_reason",        limit: 1000
  end

  add_index "bm_pay_bills", ["app_id", "req_no", "attempt_no"], name: "attempt_no_index_pay_bills", unique: true

  create_table "bm_pay_to_biller_accts", force: :cascade do |t|
    t.string   "app_id",              limit: 50,                  null: false
    t.string   "req_no",              limit: 32,                  null: false
    t.integer  "attempt_no",                       precision: 38, null: false
    t.string   "req_version",         limit: 5,                   null: false
    t.datetime "req_timestamp",                                   null: false
    t.string   "customer_id",         limit: 15,                  null: false
    t.string   "debit_account_no",    limit: 50,                  null: false
    t.string   "biller_account_no",   limit: 50,                  null: false
    t.string   "payment_kind",        limit: 100,                 null: false
    t.date     "bill_date"
    t.string   "bill_number",         limit: 50
    t.date     "due_date"
    t.string   "status_code",         limit: 50,                  null: false
    t.string   "rep_version",         limit: 5
    t.string   "rep_no",              limit: 32
    t.datetime "rep_timestamp"
    t.string   "debit_reference_no",  limit: 32
    t.string   "biller_reference_no", limit: 32
    t.string   "fault_code",          limit: 50
    t.string   "fault_reason",        limit: 1000
    t.decimal  "payment_amount"
    t.decimal  "bill_amount"
  end

  add_index "bm_pay_to_biller_accts", ["app_id", "req_no", "attempt_no"], name: "attempt_no_index_biller_acct", unique: true

  create_table "bm_pay_to_billers", force: :cascade do |t|
    t.string   "app_id",              limit: 50,                  null: false
    t.string   "req_no",              limit: 32,                  null: false
    t.integer  "attempt_no",                       precision: 38, null: false
    t.string   "req_version",         limit: 5,                   null: false
    t.datetime "req_timestamp",                                   null: false
    t.string   "customer_id",         limit: 15,                  null: false
    t.string   "debit_account_no",    limit: 50,                  null: false
    t.string   "biller_code",         limit: 50,                  null: false
    t.integer  "num_params",                       precision: 38, null: false
    t.string   "param1",              limit: 100
    t.string   "param2",              limit: 100
    t.string   "param3",              limit: 100
    t.string   "param4",              limit: 100
    t.string   "param5",              limit: 100
    t.string   "payment_kind",        limit: 100,                 null: false
    t.date     "bill_date"
    t.string   "bill_number",         limit: 50
    t.date     "due_date"
    t.string   "status_code",         limit: 50,                  null: false
    t.string   "rep_version",         limit: 5
    t.string   "rep_no",              limit: 32
    t.datetime "rep_timestamp"
    t.string   "debit_reference_no",  limit: 32
    t.string   "biller_reference_no", limit: 32
    t.string   "fault_code",          limit: 50
    t.string   "fault_reason",        limit: 1000
    t.decimal  "bill_amount"
    t.decimal  "payment_amount"
  end

  add_index "bm_pay_to_billers", ["app_id", "req_no", "attempt_no"], name: "attempt_no_index_pay_billers", unique: true

  create_table "bm_pending_aggr_payments", force: :cascade do |t|
    t.string   "broker_uuid",              limit: 500
    t.integer  "bm_aggregator_payment_id", limit: nil
    t.datetime "created_at"
  end

  create_table "bm_pending_billpays", force: :cascade do |t|
    t.string   "broker_uuid",                    null: false
    t.integer  "bm_bill_payment_id", limit: nil, null: false
    t.datetime "created_at",                     null: false
  end

  create_table "bm_pending_debit_reversals", force: :cascade do |t|
    t.string   "broker_uuid",                    null: false
    t.integer  "bm_bill_payment_id", limit: nil, null: false
    t.datetime "created_at",                     null: false
  end

  create_table "bm_pending_debits", force: :cascade do |t|
    t.string   "broker_uuid",                    null: false
    t.integer  "bm_bill_payment_id", limit: nil, null: false
    t.datetime "created_at",                     null: false
  end

  create_table "bm_rules", force: :cascade do |t|
    t.string   "customer_id",            limit: 15,                                null: false
    t.string   "bene_acct_no",                                                     null: false
    t.string   "bene_account_ifsc",                                                null: false
    t.string   "neft_sender_ifsc",                                                 null: false
    t.integer  "lock_version",                       precision: 38,                null: false
    t.datetime "created_at",                                                       null: false
    t.datetime "updated_at",                                                       null: false
    t.string   "approval_status",                                   default: "U",  null: false
    t.string   "last_action",                                       default: "C"
    t.integer  "approved_version",                   precision: 38
    t.integer  "approved_id",            limit: nil
    t.string   "created_by",             limit: 20
    t.string   "updated_by",             limit: 20
    t.string   "source_id",              limit: 50,                 default: "qg", null: false
    t.integer  "traceid_prefix",                     precision: 38, default: 1,    null: false
    t.string   "app_id",                 limit: 50
    t.string   "aggregate_cod_acc_no"
    t.string   "payment_mode"
    t.string   "receivable_customer_id"
    t.string   "receivable_account"
    t.string   "bene_account_no"
    t.string   "is_bbps"
    t.string   "aggregare_cod_acc_no"
    t.string   "aggregate_code_acct_no", limit: 100
    t.string   "aggregate_cod_acct_no",  limit: 100
    t.string   "isbbps",                 limit: 100
    t.string   "receivables_account",    limit: 100
  end

  add_index "bm_rules", ["app_id", "approval_status"], name: "bm_rules_01", unique: true

  create_table "bm_set_auto_pays", force: :cascade do |t|
    t.string   "app_id",         limit: 20,                  null: false
    t.string   "req_no",         limit: 32,                  null: false
    t.integer  "attempt_no",                  precision: 38, null: false
    t.string   "req_version",    limit: 5,                   null: false
    t.datetime "req_timestamp",                              null: false
    t.string   "customer_id",    limit: 15,                  null: false
    t.string   "status_code",    limit: 50,                  null: false
    t.string   "biller_code",    limit: 100,                 null: false
    t.string   "debit_acct_no",  limit: 20
    t.string   "credit_card_no", limit: 50
    t.string   "biller_acct_no", limit: 50
    t.decimal  "amount_limit"
    t.date     "start_date"
    t.date     "end_date"
    t.string   "interval",       limit: 50
    t.string   "email_id1",      limit: 100
    t.string   "email_id2",      limit: 100
    t.string   "mobile_no",      limit: 50
    t.string   "rep_version",    limit: 5
    t.string   "rep_no",         limit: 32
    t.datetime "rep_timestamp"
    t.string   "fault_code",     limit: 50
    t.string   "fault_subcode",  limit: 50
    t.string   "fault_reason",   limit: 1000
  end

  add_index "bm_set_auto_pays", ["customer_id", "req_no", "status_code", "biller_code", "req_timestamp", "rep_timestamp"], name: "bm_set_auto_pays_02"
  add_index "bm_set_auto_pays", ["req_no", "app_id", "attempt_no"], name: "bm_set_auto_pays_01", unique: true

  create_table "bm_unapproved_records", force: :cascade do |t|
    t.integer  "bm_approvable_id",   limit: nil
    t.string   "bm_approvable_type"
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
  end

  create_table "bms_add_beneficiaries", force: :cascade do |t|
    t.string   "req_version",                                  null: false
    t.string   "req_no",                                       null: false
    t.integer  "attempt_no",                    precision: 38, null: false
    t.string   "status_code",      limit: 25,                  null: false
    t.datetime "req_timestamp"
    t.string   "app_id",                                       null: false
    t.string   "customer_id",                                  null: false
    t.string   "bene_id"
    t.string   "transfer_type"
    t.string   "bene_name"
    t.string   "bene_acct_no"
    t.string   "bene_acct_ifsc"
    t.string   "bene_description"
    t.string   "bene_email_id"
    t.string   "bene_mobile_no"
    t.string   "rep_version"
    t.string   "rep_no"
    t.datetime "rep_timestamp"
    t.string   "fault_code"
    t.string   "fault_reason",     limit: 1000
    t.string   "notify_status",    limit: 50
  end

  add_index "bms_add_beneficiaries", ["req_no", "app_id", "attempt_no"], name: "uk_bms_add_beneficiaries_1", unique: true

  create_table "bms_audit_logs", force: :cascade do |t|
    t.string   "req_no",             limit: 32,                  null: false
    t.string   "app_id",             limit: 32,                  null: false
    t.integer  "attempt_no",                      precision: 38, null: false
    t.string   "status_code",        limit: 25,                  null: false
    t.string   "bms_auditable_type",                             null: false
    t.integer  "bms_auditable_id",   limit: nil,                 null: false
    t.string   "fault_code"
    t.string   "fault_reason",       limit: 1000
    t.datetime "req_timestamp"
    t.datetime "rep_timestamp"
    t.text     "req_bitstream",                                  null: false
    t.text     "rep_bitstream"
    t.text     "fault_bitstream"
  end

  add_index "bms_audit_logs", ["app_id", "req_no", "attempt_no"], name: "uk_bms_audit_logs_1", unique: true
  add_index "bms_audit_logs", ["bms_auditable_type", "bms_auditable_id"], name: "uk_bms_audit_logs_2", unique: true

  create_table "bms_del_beneficiaries", force: :cascade do |t|
    t.string   "req_version",                               null: false
    t.string   "req_no",                                    null: false
    t.integer  "attempt_no",                 precision: 38, null: false
    t.string   "status_code",   limit: 25,                  null: false
    t.datetime "req_timestamp"
    t.string   "app_id",                                    null: false
    t.string   "customer_id",                               null: false
    t.string   "bene_id"
    t.string   "otp_key"
    t.string   "otp_value"
    t.string   "rep_version"
    t.string   "rep_no"
    t.datetime "rep_timestamp"
    t.string   "fault_code"
    t.string   "fault_reason",  limit: 1000
    t.string   "notify_status", limit: 50
  end

  add_index "bms_del_beneficiaries", ["req_no", "app_id", "attempt_no"], name: "uk_bms_del_beneficiaries_1", unique: true

  create_table "bms_mod_beneficiaries", force: :cascade do |t|
    t.string   "req_version",                                  null: false
    t.string   "req_no",                                       null: false
    t.integer  "attempt_no",                    precision: 38, null: false
    t.string   "status_code",      limit: 25,                  null: false
    t.datetime "req_timestamp"
    t.string   "app_id",                                       null: false
    t.string   "customer_id",                                  null: false
    t.string   "bene_id"
    t.string   "transfer_type"
    t.string   "bene_name"
    t.string   "bene_acct_no"
    t.string   "bene_acct_ifsc"
    t.string   "bene_description"
    t.string   "bene_email_id"
    t.string   "bene_mobile_no"
    t.string   "rep_version"
    t.string   "rep_no"
    t.datetime "rep_timestamp"
    t.string   "fault_code"
    t.string   "fault_reason",     limit: 1000
    t.string   "notify_status",    limit: 50
  end

  add_index "bms_mod_beneficiaries", ["req_no", "app_id", "attempt_no"], name: "uk_bms_mod_beneficiaries_1", unique: true

  create_table "brokers", force: :cascade do |t|
    t.string  "name",                limit: 50
    t.string  "host",                limit: 50
    t.integer "port",                           precision: 38
    t.string  "scheme",              limit: 50
    t.string  "username",            limit: 50
    t.string  "password",            limit: 50
    t.string  "file_path"
    t.integer "no_of_lines_to_read",            precision: 38
    t.string  "encrypted_password"
  end

  create_table "cc_audit_logs", force: :cascade do |t|
    t.string   "req_no",            limit: 32,                  null: false
    t.string   "app_id",            limit: 32,                  null: false
    t.integer  "attempt_no",                     precision: 38, null: false
    t.string   "status_code",       limit: 25,                  null: false
    t.string   "cc_auditable_type",                             null: false
    t.integer  "cc_auditable_id",   limit: nil,                 null: false
    t.string   "fault_code",        limit: 50
    t.string   "fault_subcode",     limit: 50
    t.string   "fault_reason",      limit: 1000
    t.datetime "req_timestamp"
    t.datetime "rep_timestamp"
    t.text     "req_bitstream",                                 null: false
    t.text     "rep_bitstream"
    t.text     "fault_bitstream"
  end

  add_index "cc_audit_logs", ["app_id", "req_no", "attempt_no"], name: "cc_audit_logs_01", unique: true
  add_index "cc_audit_logs", ["cc_auditable_type", "cc_auditable_id"], name: "cc_audit_logs_02", unique: true

  create_table "cc_audit_steps", force: :cascade do |t|
    t.string   "cc_auditable_type",                             null: false
    t.integer  "cc_auditable_id",   limit: nil,                 null: false
    t.integer  "step_no",                        precision: 38, null: false
    t.integer  "attempt_no",                     precision: 38, null: false
    t.string   "step_name",         limit: 100,                 null: false
    t.string   "status_code",       limit: 25,                  null: false
    t.string   "fault_code",        limit: 50
    t.string   "fault_subcode",     limit: 50
    t.string   "fault_reason",      limit: 1000
    t.string   "req_reference"
    t.datetime "req_timestamp"
    t.string   "rep_reference"
    t.datetime "rep_timestamp"
    t.text     "req_bitstream"
    t.text     "rep_bitstream"
    t.text     "fault_bitstream"
    t.string   "remote_host",       limit: 500
    t.string   "req_uri",           limit: 500
    t.text     "req_header"
    t.text     "rep_header"
  end

  add_index "cc_audit_steps", ["cc_auditable_type", "cc_auditable_id", "step_no", "attempt_no"], name: "cc_audit_steps_01", unique: true

  create_table "cc_cust_cards", force: :cascade do |t|
    t.string   "customer_id",      limit: 15,                               null: false
    t.string   "credit_card_no",   limit: 20,                               null: false
    t.string   "is_enabled",       limit: 1,                  default: "Y", null: false
    t.datetime "created_at",                                                null: false
    t.datetime "updated_at",                                                null: false
    t.string   "created_by",       limit: 20
    t.string   "updated_by",       limit: 20
    t.integer  "lock_version",                 precision: 38, default: 0,   null: false
    t.string   "last_action",      limit: 1,                  default: "C", null: false
    t.string   "approval_status",  limit: 1,                  default: "U", null: false
    t.integer  "approved_version",             precision: 38
    t.integer  "approved_id",      limit: nil
  end

  add_index "cc_cust_cards", ["credit_card_no", "approval_status"], name: "cc_cust_cards_01", unique: true

  create_table "cc_customers", force: :cascade do |t|
    t.string   "app_id",             limit: 20,                               null: false
    t.string   "customer_id",        limit: 15,                               null: false
    t.string   "identity_user_id",                                            null: false
    t.string   "allowed_operations", limit: 50,                               null: false
    t.string   "is_enabled",         limit: 1,                  default: "Y", null: false
    t.datetime "created_at",                                                  null: false
    t.datetime "updated_at",                                                  null: false
    t.string   "created_by",         limit: 20
    t.string   "updated_by",         limit: 20
    t.integer  "lock_version",                   precision: 38, default: 0,   null: false
    t.string   "last_action",        limit: 1,                  default: "C", null: false
    t.string   "approval_status",    limit: 1,                  default: "U", null: false
    t.integer  "approved_version",               precision: 38
    t.integer  "approved_id",        limit: nil
  end

  add_index "cc_customers", ["app_id", "customer_id", "approval_status"], name: "cc_customers_01", unique: true

  create_table "cc_fee_rules", force: :cascade do |t|
    t.string   "app_id",           limit: 20,                               null: false
    t.string   "customer_id",      limit: 15,                               null: false
    t.integer  "no_of_tiers",                  precision: 38,               null: false
    t.string   "tier1_method",     limit: 3,                                null: false
    t.string   "tier2_method",     limit: 3
    t.string   "tier3_method",     limit: 3
    t.string   "is_enabled",       limit: 1,                  default: "Y", null: false
    t.datetime "created_at",                                                null: false
    t.datetime "updated_at",                                                null: false
    t.string   "created_by",       limit: 20
    t.string   "updated_by",       limit: 20
    t.integer  "lock_version",                 precision: 38, default: 0,   null: false
    t.string   "last_action",      limit: 1,                  default: "C", null: false
    t.string   "approval_status",  limit: 1,                  default: "U", null: false
    t.integer  "approved_version",             precision: 38
    t.integer  "approved_id",      limit: nil
    t.decimal  "tier1_to_amt",                                              null: false
    t.decimal  "tier1_fixed_amt"
    t.decimal  "tier1_pct_value"
    t.decimal  "tier1_min_sc_amt"
    t.decimal  "tier1_max_sc_amt"
    t.decimal  "tier2_to_amt"
    t.decimal  "tier2_fixed_amt"
    t.decimal  "tier2_pct_value"
    t.decimal  "tier2_min_sc_amt"
    t.decimal  "tier2_max_sc_amt"
    t.decimal  "tier3_fixed_amt"
    t.decimal  "tier3_pct_value"
    t.decimal  "tier3_min_sc_amt"
    t.decimal  "tier3_max_sc_amt"
  end

  add_index "cc_fee_rules", ["app_id", "customer_id", "approval_status"], name: "cc_fee_rules_01", unique: true

  create_table "cc_incoming_files", force: :cascade do |t|
    t.string   "file_name",        limit: 100, null: false
    t.string   "customer_id",      limit: 15
    t.string   "credit_card_no",   limit: 20
    t.string   "pool_account_no",  limit: 20
    t.string   "pool_customer_id", limit: 15
    t.decimal  "debited_limit"
    t.string   "debit_status",     limit: 20
    t.string   "debit_ref_no",     limit: 32
    t.datetime "debited_at"
    t.decimal  "reversed_limit"
    t.string   "reversal_status",  limit: 20
    t.string   "reversal_ref_no",  limit: 32
    t.datetime "reversed_at"
  end

  add_index "cc_incoming_files", ["file_name"], name: "cc_incoming_files_01", unique: true

  create_table "cc_incoming_records", force: :cascade do |t|
    t.integer "incoming_file_record_id",   limit: nil, null: false
    t.string  "file_name",                 limit: 100, null: false
    t.string  "req_version"
    t.string  "req_no"
    t.string  "app_id",                    limit: 20
    t.string  "purpose_code",              limit: 20
    t.string  "customer_id"
    t.string  "credit_card_no",            limit: 20,  null: false
    t.string  "bene_code",                 limit: 50
    t.string  "bene_full_name",            limit: 100
    t.string  "bene_address1"
    t.string  "bene_address2"
    t.string  "bene_address3",             limit: 100
    t.string  "bene_postal_code",          limit: 100
    t.string  "bene_city",                 limit: 100
    t.string  "bene_state",                limit: 100
    t.string  "bene_country",              limit: 100
    t.string  "bene_mobile_no",            limit: 10
    t.string  "bene_email_id",             limit: 100
    t.string  "bene_account_no",           limit: 20
    t.string  "bene_ifsc_code",            limit: 50
    t.string  "req_transfer_type"
    t.string  "transfer_ccy"
    t.decimal "req_transfer_amount"
    t.string  "rmtr_to_bene_note"
    t.string  "rep_version",               limit: 10
    t.string  "rep_no",                    limit: 50
    t.string  "transfer_type",             limit: 4
    t.decimal "transfer_amount"
    t.decimal "fee_amount"
    t.string  "txn_status_code",           limit: 50
    t.string  "txn_status_subcode",        limit: 50
    t.string  "bank_ref_no",               limit: 50
    t.string  "block_card_req_ref_no",     limit: 32
    t.string  "reinstate_card_req_ref_no", limit: 32
    t.string  "crdr",                      limit: 1
    t.string  "trans_code",                limit: 10
    t.string  "trans_desc",                limit: 50
    t.string  "auth_code",                 limit: 10
    t.decimal "card_limit_amount"
  end

  add_index "cc_incoming_records", ["incoming_file_record_id"], name: "cc_incoming_records_01", unique: true

  create_table "cc_pending_transfers", force: :cascade do |t|
    t.string   "app_uuid",                      null: false
    t.string   "cc_auditable_type", limit: 100, null: false
    t.integer  "cc_auditable_id",   limit: nil, null: false
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
  end

  add_index "cc_pending_transfers", ["app_uuid", "created_at"], name: "cc_pending_transfers_02"
  add_index "cc_pending_transfers", ["cc_auditable_type", "cc_auditable_id"], name: "cc_pending_transfers_01", unique: true

  create_table "cc_rules", force: :cascade do |t|
    t.string   "pool_customer_id", limit: 15,                               null: false
    t.string   "pool_account_no",  limit: 20,                               null: false
    t.string   "is_enabled",       limit: 1,                  default: "Y", null: false
    t.datetime "created_at",                                                null: false
    t.datetime "updated_at",                                                null: false
    t.string   "created_by",       limit: 20
    t.string   "updated_by",       limit: 20
    t.integer  "lock_version",                 precision: 38, default: 0,   null: false
    t.string   "last_action",      limit: 1,                  default: "C", null: false
    t.string   "approval_status",  limit: 1,                  default: "U", null: false
    t.integer  "approved_version",             precision: 38
    t.integer  "approved_id",      limit: nil
  end

  add_index "cc_rules", ["pool_customer_id", "approval_status"], name: "cc_rules_01", unique: true

  create_table "cc_transfers", force: :cascade do |t|
    t.string   "req_no",                    limit: 50,                                null: false
    t.string   "req_version",               limit: 10,                                null: false
    t.datetime "req_timestamp",                                                       null: false
    t.string   "app_id",                    limit: 20
    t.string   "purpose_code",              limit: 20
    t.string   "customer_id",               limit: 15,                                null: false
    t.string   "credit_card_no",            limit: 20,                                null: false
    t.string   "bene_code",                 limit: 50
    t.string   "bene_full_name",            limit: 100
    t.string   "bene_address1"
    t.string   "bene_address2"
    t.string   "bene_address3",             limit: 100
    t.string   "bene_postal_code",          limit: 100
    t.string   "bene_city",                 limit: 100
    t.string   "bene_state",                limit: 100
    t.string   "bene_country",              limit: 100
    t.string   "bene_email_id",             limit: 100
    t.string   "bene_mobile_no",            limit: 10
    t.string   "bene_account_no",           limit: 20
    t.string   "bene_ifsc_code",            limit: 50
    t.string   "req_transfer_type",         limit: 4,                                 null: false
    t.decimal  "req_transfer_amount",                                                 null: false
    t.string   "transfer_ccy",              limit: 5,                                 null: false
    t.string   "rmtr_to_bene_note",                                                   null: false
    t.string   "status_code",               limit: 25,                                null: false
    t.string   "limit_status",              limit: 25
    t.integer  "attempt_no",                             precision: 38,               null: false
    t.string   "rep_no",                    limit: 50
    t.string   "rep_version",               limit: 10
    t.datetime "rep_timestamp"
    t.string   "transfer_type",             limit: 4
    t.string   "name_with_bene_bank"
    t.string   "bank_ref_no",               limit: 50
    t.decimal  "fee_amount"
    t.decimal  "transfer_amount"
    t.datetime "reconciled_at"
    t.datetime "reversed_at"
    t.datetime "confirmed_at"
    t.string   "reversal_status",           limit: 1000
    t.string   "fault_code"
    t.string   "fault_subcode",             limit: 50
    t.string   "fault_reason",              limit: 1000
    t.string   "bene_bank_name",            limit: 50
    t.string   "do_saf",                    limit: 1,                   default: "f", null: false
    t.string   "block_card_req_ref_no",     limit: 32
    t.string   "reinstate_card_req_ref_no", limit: 32
    t.string   "ft_customer_id",            limit: 15
  end

  add_index "cc_transfers", ["req_no", "customer_id", "attempt_no"], name: "cc_transfers_01", unique: true

  create_table "cg_dd_testers", force: :cascade do |t|
    t.string   "name"
    t.string   "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "cn_incoming_files", force: :cascade do |t|
    t.string "file_name",       limit: 100
    t.string "batch_no",        limit: 20
    t.string "rej_file_name",   limit: 150
    t.string "rej_file_path"
    t.string "rej_file_status"
    t.string "cnb_file_name",   limit: 150
    t.string "cnb_file_path"
    t.string "cnb_file_status", limit: 50
  end

  add_index "cn_incoming_files", ["file_name"], name: "cn_incoming_files_01", unique: true

  create_table "cn_incoming_records", force: :cascade do |t|
    t.integer "incoming_file_record_id", limit: nil
    t.string  "file_name",               limit: 100
    t.string  "message_type",            limit: 3
    t.string  "debit_account_no",        limit: 20
    t.string  "rmtr_name",               limit: 50
    t.string  "rmtr_address1"
    t.string  "rmtr_address2"
    t.string  "rmtr_address3"
    t.string  "rmtr_address4"
    t.string  "bene_ifsc_code",          limit: 50
    t.string  "bene_account_no",         limit: 34
    t.string  "bene_name"
    t.string  "bene_add_line1"
    t.string  "bene_add_line2"
    t.string  "bene_add_line3"
    t.string  "bene_add_line4"
    t.string  "transaction_ref_no",      limit: 50
    t.date    "upload_date"
    t.decimal "amount"
    t.string  "rmtr_to_bene_note"
    t.string  "add_info1",               limit: 50
    t.string  "add_info2",               limit: 50
    t.string  "add_info3",               limit: 50
    t.string  "add_info4",               limit: 50
  end

  add_index "cn_incoming_records", ["incoming_file_record_id", "file_name"], name: "cn_incoming_records_01", unique: true

  create_table "cn_unapproved_records", force: :cascade do |t|
    t.integer  "cn_approvable_id",   limit: nil
    t.string   "cn_approvable_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "cnb2_incoming_files", force: :cascade do |t|
    t.string "file_name",       limit: 100
    t.string "cnb_file_name",   limit: 100
    t.string "cnb_file_path"
    t.string "cnb_file_status", limit: 50
  end

  add_index "cnb2_incoming_files", ["file_name"], name: "cnb2_incoming_files_01", unique: true

  create_table "cnb2_incoming_records", force: :cascade do |t|
    t.integer "incoming_file_record_id", limit: nil
    t.string  "file_name",               limit: 100
    t.string  "run_date",                limit: 50
    t.string  "add_identification",      limit: 50
    t.string  "pay_comp_code",           limit: 50
    t.string  "doc_no",                  limit: 50
    t.string  "amount",                  limit: 50
    t.string  "currency",                limit: 50
    t.string  "pay_method",              limit: 50
    t.string  "vendor_code",             limit: 50
    t.string  "payee_title",             limit: 50
    t.string  "payee_name"
    t.string  "payee_addr1",             limit: 50
    t.string  "payee_addr2",             limit: 50
    t.string  "payee_addr3",             limit: 50
    t.string  "payee_addr4",             limit: 50
    t.string  "payee_addr5",             limit: 50
    t.string  "house_bank",              limit: 50
    t.string  "acct_dtl_id",             limit: 50
    t.string  "value_date",              limit: 50
    t.string  "system_date",             limit: 50
    t.string  "delivery_mode",           limit: 50
    t.string  "cheque_no",               limit: 50
    t.string  "pay_location",            limit: 50
    t.string  "bene_account_no",         limit: 50
    t.string  "ifsc_code",               limit: 50
    t.string  "bank_name",               limit: 50
    t.string  "bene_email_id"
    t.string  "bene_email_id_2",         limit: 1000
  end

  add_index "cnb2_incoming_records", ["incoming_file_record_id", "file_name"], name: "cnb2_incoming_records_01", unique: true

  create_table "csv_exports", force: :cascade do |t|
    t.integer  "user_id",      limit: nil
    t.string   "state"
    t.string   "request_type"
    t.string   "path"
    t.string   "group"
    t.datetime "executed_at"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.string   "fault_text",   limit: 1000
  end

  create_table "customer_applications", force: :cascade do |t|
    t.integer  "user_id",        limit: nil,                null: false
    t.integer  "application_id", limit: nil,                null: false
    t.string   "value",                                     null: false
    t.integer  "created_by",                 precision: 38
    t.integer  "updated_by",                 precision: 38
    t.datetime "created_at",                                null: false
    t.datetime "updated_at",                                null: false
  end

  create_table "customer_services", force: :cascade do |t|
    t.integer  "user_id",    limit: nil,                null: false
    t.integer  "service_id", limit: nil,                null: false
    t.string   "value",                                 null: false
    t.integer  "created_by",             precision: 38
    t.integer  "updated_by",             precision: 38
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
  end

  create_table "customers", force: :cascade do |t|
    t.integer   "external_organisation_id", limit: nil,                              null: false
    t.string    "customer_id",              limit: 20,                               null: false
    t.integer   "lock_version",                         precision: 38, default: 0,   null: false
    t.integer   "created_by",                           precision: 38
    t.integer   "updated_by",                           precision: 38
    t.timestamp "created_at",               limit: 6,                                null: false
    t.timestamp "updated_at",               limit: 6,                                null: false
    t.string    "approval_status",          limit: 1,                  default: "U", null: false
    t.string    "last_action",              limit: 1,                  default: "C"
    t.integer   "approved_id",              limit: nil
    t.integer   "approved_version",                     precision: 38
    t.string    "accessible_services",                                               null: false
  end

  add_index "customers", ["customer_id", "approval_status"], name: "customers_01", unique: true

  create_table "daily_statistics", force: :cascade do |t|
    t.date     "stats_date"
    t.string   "service_name"
    t.integer  "latest_request_id",     limit: nil
    t.datetime "latest_request_at"
    t.string   "latest_request_status", limit: 1
    t.integer  "total_cnt",             limit: nil
    t.integer  "latest_response_time",              precision: 38
    t.integer  "latest_id",             limit: nil
  end

  create_table "db_archival_rules", force: :cascade do |t|
    t.string   "schema_name"
    t.string   "table_name"
    t.integer  "parent_db_retention",               precision: 38
    t.integer  "archival_db_retention",             precision: 38
    t.datetime "scheduled_time"
    t.boolean  "is_enabled",            limit: nil
  end

  create_table "delayed_job_results", force: :cascade do |t|
    t.integer  "user_id",     limit: nil
    t.integer  "job_id",      limit: nil
    t.string   "state"
    t.string   "report_type"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.datetime "executed_at"
  end

  create_table "delayed_jobs", force: :cascade do |t|
    t.integer  "priority",   precision: 38, default: 0, null: false
    t.integer  "attempts",   precision: 38, default: 0, null: false
    t.text     "handler",                               null: false
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "delayed_jobs", ["priority", "run_at"], name: "delayed_jobs_priority"

  create_table "e_a_l_bkp_181001to190131", id: false, force: :cascade do |t|
    t.integer  "id",                  limit: nil,                 null: false
    t.integer  "ecol_transaction_id", limit: nil,                 null: false
    t.string   "step_name",                                       null: false
    t.integer  "attempt_no",                       precision: 38, null: false
    t.string   "fault_code",          limit: 50
    t.string   "fault_reason",        limit: 1000
    t.datetime "req_timestamp"
    t.datetime "rep_timestamp"
    t.text     "req_bitstream"
    t.text     "rep_bitstream"
    t.text     "fault_bitstream"
    t.datetime "created_at",                                      null: false
    t.datetime "updated_at",                                      null: false
    t.string   "req_ref",             limit: 64
    t.text     "req_header"
    t.text     "rep_header"
    t.string   "req_uri",             limit: 500
    t.string   "remote_host",         limit: 500
    t.integer  "override_user_id",    limit: nil
  end

  create_table "e_bkp_181001to181122", id: false, force: :cascade do |t|
    t.integer  "id",                    limit: nil,                 null: false
    t.string   "status",                limit: 20,                  null: false
    t.string   "transfer_type",         limit: 4,                   null: false
    t.string   "transfer_unique_no",    limit: 64,                  null: false
    t.string   "transfer_status",       limit: 25,                  null: false
    t.datetime "transfer_timestamp",                                null: false
    t.string   "transfer_ccy",          limit: 5,                   null: false
    t.decimal  "transfer_amt",                                      null: false
    t.string   "rmtr_ref",              limit: 64
    t.string   "rmtr_full_name",                                    null: false
    t.string   "rmtr_address"
    t.string   "rmtr_account_type",     limit: 10
    t.string   "rmtr_account_no",       limit: 64,                  null: false
    t.string   "rmtr_account_ifsc",     limit: 20,                  null: false
    t.string   "bene_full_name"
    t.string   "bene_account_type",     limit: 10
    t.string   "bene_account_no",       limit: 64,                  null: false
    t.string   "bene_account_ifsc",     limit: 20,                  null: false
    t.string   "rmtr_to_bene_note"
    t.datetime "received_at",                                       null: false
    t.string   "customer_code",         limit: 15
    t.string   "customer_subcode",      limit: 28
    t.string   "remitter_code",         limit: 28
    t.datetime "validated_at"
    t.string   "validation_status",     limit: 50
    t.datetime "credited_at"
    t.string   "credit_ref",            limit: 64
    t.integer  "credit_attempt_no",                  precision: 38
    t.string   "rmtr_email_notify_ref", limit: 64
    t.string   "rmtr_sms_notify_ref",   limit: 2000
    t.datetime "settled_at"
    t.string   "settle_status",         limit: 50
    t.string   "settle_ref",            limit: 64
    t.integer  "settle_attempt_no",                  precision: 38
    t.datetime "fault_at"
    t.string   "fault_code",            limit: 50
    t.string   "fault_reason",          limit: 1000
    t.datetime "created_at",                                        null: false
    t.datetime "updated_at",                                        null: false
    t.string   "invoice_no",            limit: 28
    t.datetime "validate_attempt_at"
    t.datetime "credit_attempt_at"
    t.datetime "returned_at"
    t.string   "return_ref",            limit: 64
    t.datetime "return_attempt_at"
    t.integer  "return_attempt_no",     limit: 8,    precision: 8
    t.datetime "settle_attempt_at"
    t.string   "bene_full_address"
    t.string   "validation_result",     limit: 1000
    t.string   "credit_acct_no",        limit: 25
    t.string   "settle_result",         limit: 1000
    t.integer  "ecol_remitter_id",      limit: nil
    t.string   "pending_approval"
    t.integer  "notify_attempt_no",     limit: 8,    precision: 8
    t.datetime "notify_attempt_at"
    t.datetime "notified_at"
    t.string   "notify_status",         limit: 50
    t.string   "notify_result",         limit: 1000
    t.integer  "validate_attempt_no",                precision: 38
    t.string   "return_req_ref",        limit: 64
    t.string   "settle_req_ref",        limit: 64
    t.string   "credit_req_ref",        limit: 64
    t.string   "validation_ref",        limit: 50
    t.string   "return_transfer_type",  limit: 10
    t.integer  "approver_id",           limit: nil
    t.string   "remarks"
    t.string   "decision_by",           limit: 1
    t.integer  "va_txn_id",             limit: nil
    t.string   "va_transfer_status",    limit: 20
  end

  create_table "e_bkp_181001to181130", id: false, force: :cascade do |t|
    t.integer  "id",                  limit: nil,                 null: false
    t.integer  "ecol_transaction_id", limit: nil,                 null: false
    t.string   "step_name",                                       null: false
    t.integer  "attempt_no",                       precision: 38, null: false
    t.string   "fault_code",          limit: 50
    t.string   "fault_reason",        limit: 1000
    t.datetime "req_timestamp"
    t.datetime "rep_timestamp"
    t.text     "req_bitstream"
    t.text     "rep_bitstream"
    t.text     "fault_bitstream"
    t.datetime "created_at",                                      null: false
    t.datetime "updated_at",                                      null: false
    t.string   "req_ref",             limit: 64
    t.text     "req_header"
    t.text     "rep_header"
    t.string   "req_uri",             limit: 500
    t.string   "remote_host",         limit: 500
    t.integer  "override_user_id",    limit: nil
  end

  create_table "e_bkp_181101to181130", id: false, force: :cascade do |t|
    t.integer  "id",                    limit: nil,                 null: false
    t.string   "status",                limit: 20,                  null: false
    t.string   "transfer_type",         limit: 4,                   null: false
    t.string   "transfer_unique_no",    limit: 64,                  null: false
    t.string   "transfer_status",       limit: 25,                  null: false
    t.datetime "transfer_timestamp",                                null: false
    t.string   "transfer_ccy",          limit: 5,                   null: false
    t.decimal  "transfer_amt",                                      null: false
    t.string   "rmtr_ref",              limit: 64
    t.string   "rmtr_full_name",                                    null: false
    t.string   "rmtr_address"
    t.string   "rmtr_account_type",     limit: 10
    t.string   "rmtr_account_no",       limit: 64,                  null: false
    t.string   "rmtr_account_ifsc",     limit: 20,                  null: false
    t.string   "bene_full_name"
    t.string   "bene_account_type",     limit: 10
    t.string   "bene_account_no",       limit: 64,                  null: false
    t.string   "bene_account_ifsc",     limit: 20,                  null: false
    t.string   "rmtr_to_bene_note"
    t.datetime "received_at",                                       null: false
    t.string   "customer_code",         limit: 15
    t.string   "customer_subcode",      limit: 28
    t.string   "remitter_code",         limit: 28
    t.datetime "validated_at"
    t.string   "validation_status",     limit: 50
    t.datetime "credited_at"
    t.string   "credit_ref",            limit: 64
    t.integer  "credit_attempt_no",                  precision: 38
    t.string   "rmtr_email_notify_ref", limit: 64
    t.string   "rmtr_sms_notify_ref",   limit: 2000
    t.datetime "settled_at"
    t.string   "settle_status",         limit: 50
    t.string   "settle_ref",            limit: 64
    t.integer  "settle_attempt_no",                  precision: 38
    t.datetime "fault_at"
    t.string   "fault_code",            limit: 50
    t.string   "fault_reason",          limit: 1000
    t.datetime "created_at",                                        null: false
    t.datetime "updated_at",                                        null: false
    t.string   "invoice_no",            limit: 28
    t.datetime "validate_attempt_at"
    t.datetime "credit_attempt_at"
    t.datetime "returned_at"
    t.string   "return_ref",            limit: 64
    t.datetime "return_attempt_at"
    t.integer  "return_attempt_no",     limit: 8,    precision: 8
    t.datetime "settle_attempt_at"
    t.string   "bene_full_address"
    t.string   "validation_result",     limit: 1000
    t.string   "credit_acct_no",        limit: 25
    t.string   "settle_result",         limit: 1000
    t.integer  "ecol_remitter_id",      limit: nil
    t.string   "pending_approval"
    t.integer  "notify_attempt_no",     limit: 8,    precision: 8
    t.datetime "notify_attempt_at"
    t.datetime "notified_at"
    t.string   "notify_status",         limit: 50
    t.string   "notify_result",         limit: 1000
    t.integer  "validate_attempt_no",                precision: 38
    t.string   "return_req_ref",        limit: 64
    t.string   "settle_req_ref",        limit: 64
    t.string   "credit_req_ref",        limit: 64
    t.string   "validation_ref",        limit: 50
    t.string   "return_transfer_type",  limit: 10
    t.integer  "approver_id",           limit: nil
    t.string   "remarks"
    t.string   "decision_by",           limit: 1
    t.integer  "va_txn_id",             limit: nil
    t.string   "va_transfer_status",    limit: 20
  end

  create_table "e_bkp_181104to181112", id: false, force: :cascade do |t|
    t.integer  "id",                  limit: nil,                 null: false
    t.integer  "ecol_transaction_id", limit: nil,                 null: false
    t.string   "step_name",                                       null: false
    t.integer  "attempt_no",                       precision: 38, null: false
    t.string   "fault_code",          limit: 50
    t.string   "fault_reason",        limit: 1000
    t.datetime "req_timestamp"
    t.datetime "rep_timestamp"
    t.text     "req_bitstream"
    t.text     "rep_bitstream"
    t.text     "fault_bitstream"
    t.datetime "created_at",                                      null: false
    t.datetime "updated_at",                                      null: false
    t.string   "req_ref",             limit: 64
    t.text     "req_header"
    t.text     "rep_header"
    t.string   "req_uri",             limit: 500
    t.string   "remote_host",         limit: 500
    t.integer  "override_user_id",    limit: nil
  end

  create_table "e_t_bkp_181001to181130", id: false, force: :cascade do |t|
    t.integer  "id",                    limit: nil,                 null: false
    t.string   "status",                limit: 20,                  null: false
    t.string   "transfer_type",         limit: 4,                   null: false
    t.string   "transfer_unique_no",    limit: 64,                  null: false
    t.string   "transfer_status",       limit: 25,                  null: false
    t.datetime "transfer_timestamp",                                null: false
    t.string   "transfer_ccy",          limit: 5,                   null: false
    t.decimal  "transfer_amt",                                      null: false
    t.string   "rmtr_ref",              limit: 64
    t.string   "rmtr_full_name",                                    null: false
    t.string   "rmtr_address"
    t.string   "rmtr_account_type",     limit: 10
    t.string   "rmtr_account_no",       limit: 64,                  null: false
    t.string   "rmtr_account_ifsc",     limit: 20,                  null: false
    t.string   "bene_full_name"
    t.string   "bene_account_type",     limit: 10
    t.string   "bene_account_no",       limit: 64,                  null: false
    t.string   "bene_account_ifsc",     limit: 20,                  null: false
    t.string   "rmtr_to_bene_note"
    t.datetime "received_at",                                       null: false
    t.string   "customer_code",         limit: 15
    t.string   "customer_subcode",      limit: 28
    t.string   "remitter_code",         limit: 28
    t.datetime "validated_at"
    t.string   "validation_status",     limit: 50
    t.datetime "credited_at"
    t.string   "credit_ref",            limit: 64
    t.integer  "credit_attempt_no",                  precision: 38
    t.string   "rmtr_email_notify_ref", limit: 64
    t.string   "rmtr_sms_notify_ref",   limit: 2000
    t.datetime "settled_at"
    t.string   "settle_status",         limit: 50
    t.string   "settle_ref",            limit: 64
    t.integer  "settle_attempt_no",                  precision: 38
    t.datetime "fault_at"
    t.string   "fault_code",            limit: 50
    t.string   "fault_reason",          limit: 1000
    t.datetime "created_at",                                        null: false
    t.datetime "updated_at",                                        null: false
    t.string   "invoice_no",            limit: 28
    t.datetime "validate_attempt_at"
    t.datetime "credit_attempt_at"
    t.datetime "returned_at"
    t.string   "return_ref",            limit: 64
    t.datetime "return_attempt_at"
    t.integer  "return_attempt_no",     limit: 8,    precision: 8
    t.datetime "settle_attempt_at"
    t.string   "bene_full_address"
    t.string   "validation_result",     limit: 1000
    t.string   "credit_acct_no",        limit: 25
    t.string   "settle_result",         limit: 1000
    t.integer  "ecol_remitter_id",      limit: nil
    t.string   "pending_approval"
    t.integer  "notify_attempt_no",     limit: 8,    precision: 8
    t.datetime "notify_attempt_at"
    t.datetime "notified_at"
    t.string   "notify_status",         limit: 50
    t.string   "notify_result",         limit: 1000
    t.integer  "validate_attempt_no",                precision: 38
    t.string   "return_req_ref",        limit: 64
    t.string   "settle_req_ref",        limit: 64
    t.string   "credit_req_ref",        limit: 64
    t.string   "validation_ref",        limit: 50
    t.string   "return_transfer_type",  limit: 10
    t.integer  "approver_id",           limit: nil
    t.string   "remarks"
    t.string   "decision_by",           limit: 1
    t.integer  "va_txn_id",             limit: nil
    t.string   "va_transfer_status",    limit: 20
  end

  create_table "e_t_bkp_181001to190131", id: false, force: :cascade do |t|
    t.integer  "id",                    limit: nil,                 null: false
    t.string   "status",                limit: 20,                  null: false
    t.string   "transfer_type",         limit: 4,                   null: false
    t.string   "transfer_unique_no",    limit: 64,                  null: false
    t.string   "transfer_status",       limit: 25,                  null: false
    t.datetime "transfer_timestamp",                                null: false
    t.string   "transfer_ccy",          limit: 5,                   null: false
    t.decimal  "transfer_amt",                                      null: false
    t.string   "rmtr_ref",              limit: 64
    t.string   "rmtr_full_name",                                    null: false
    t.string   "rmtr_address"
    t.string   "rmtr_account_type",     limit: 10
    t.string   "rmtr_account_no",       limit: 64,                  null: false
    t.string   "rmtr_account_ifsc",     limit: 20,                  null: false
    t.string   "bene_full_name"
    t.string   "bene_account_type",     limit: 10
    t.string   "bene_account_no",       limit: 64,                  null: false
    t.string   "bene_account_ifsc",     limit: 20,                  null: false
    t.string   "rmtr_to_bene_note"
    t.datetime "received_at",                                       null: false
    t.string   "customer_code",         limit: 15
    t.string   "customer_subcode",      limit: 28
    t.string   "remitter_code",         limit: 28
    t.datetime "validated_at"
    t.string   "validation_status",     limit: 50
    t.datetime "credited_at"
    t.string   "credit_ref",            limit: 64
    t.integer  "credit_attempt_no",                  precision: 38
    t.string   "rmtr_email_notify_ref", limit: 64
    t.string   "rmtr_sms_notify_ref",   limit: 2000
    t.datetime "settled_at"
    t.string   "settle_status",         limit: 50
    t.string   "settle_ref",            limit: 64
    t.integer  "settle_attempt_no",                  precision: 38
    t.datetime "fault_at"
    t.string   "fault_code",            limit: 50
    t.string   "fault_reason",          limit: 1000
    t.datetime "created_at",                                        null: false
    t.datetime "updated_at",                                        null: false
    t.string   "invoice_no",            limit: 28
    t.datetime "validate_attempt_at"
    t.datetime "credit_attempt_at"
    t.datetime "returned_at"
    t.string   "return_ref",            limit: 64
    t.datetime "return_attempt_at"
    t.integer  "return_attempt_no",     limit: 8,    precision: 8
    t.datetime "settle_attempt_at"
    t.string   "bene_full_address"
    t.string   "validation_result",     limit: 1000
    t.string   "credit_acct_no",        limit: 25
    t.string   "settle_result",         limit: 1000
    t.integer  "ecol_remitter_id",      limit: nil
    t.string   "pending_approval"
    t.integer  "notify_attempt_no",     limit: 8,    precision: 8
    t.datetime "notify_attempt_at"
    t.datetime "notified_at"
    t.string   "notify_status",         limit: 50
    t.string   "notify_result",         limit: 1000
    t.integer  "validate_attempt_no",                precision: 38
    t.string   "return_req_ref",        limit: 64
    t.string   "settle_req_ref",        limit: 64
    t.string   "credit_req_ref",        limit: 64
    t.string   "validation_ref",        limit: 50
    t.string   "return_transfer_type",  limit: 10
    t.integer  "approver_id",           limit: nil
    t.string   "remarks"
    t.string   "decision_by",           limit: 1
    t.integer  "va_txn_id",             limit: nil
    t.string   "va_transfer_status",    limit: 20
  end

  create_table "e_t_bkp_181101to181130", id: false, force: :cascade do |t|
    t.integer  "id",                    limit: nil,                 null: false
    t.string   "status",                limit: 20,                  null: false
    t.string   "transfer_type",         limit: 4,                   null: false
    t.string   "transfer_unique_no",    limit: 64,                  null: false
    t.string   "transfer_status",       limit: 25,                  null: false
    t.datetime "transfer_timestamp",                                null: false
    t.string   "transfer_ccy",          limit: 5,                   null: false
    t.decimal  "transfer_amt",                                      null: false
    t.string   "rmtr_ref",              limit: 64
    t.string   "rmtr_full_name",                                    null: false
    t.string   "rmtr_address"
    t.string   "rmtr_account_type",     limit: 10
    t.string   "rmtr_account_no",       limit: 64,                  null: false
    t.string   "rmtr_account_ifsc",     limit: 20,                  null: false
    t.string   "bene_full_name"
    t.string   "bene_account_type",     limit: 10
    t.string   "bene_account_no",       limit: 64,                  null: false
    t.string   "bene_account_ifsc",     limit: 20,                  null: false
    t.string   "rmtr_to_bene_note"
    t.datetime "received_at",                                       null: false
    t.string   "customer_code",         limit: 15
    t.string   "customer_subcode",      limit: 28
    t.string   "remitter_code",         limit: 28
    t.datetime "validated_at"
    t.string   "validation_status",     limit: 50
    t.datetime "credited_at"
    t.string   "credit_ref",            limit: 64
    t.integer  "credit_attempt_no",                  precision: 38
    t.string   "rmtr_email_notify_ref", limit: 64
    t.string   "rmtr_sms_notify_ref",   limit: 2000
    t.datetime "settled_at"
    t.string   "settle_status",         limit: 50
    t.string   "settle_ref",            limit: 64
    t.integer  "settle_attempt_no",                  precision: 38
    t.datetime "fault_at"
    t.string   "fault_code",            limit: 50
    t.string   "fault_reason",          limit: 1000
    t.datetime "created_at",                                        null: false
    t.datetime "updated_at",                                        null: false
    t.string   "invoice_no",            limit: 28
    t.datetime "validate_attempt_at"
    t.datetime "credit_attempt_at"
    t.datetime "returned_at"
    t.string   "return_ref",            limit: 64
    t.datetime "return_attempt_at"
    t.integer  "return_attempt_no",     limit: 8,    precision: 8
    t.datetime "settle_attempt_at"
    t.string   "bene_full_address"
    t.string   "validation_result",     limit: 1000
    t.string   "credit_acct_no",        limit: 25
    t.string   "settle_result",         limit: 1000
    t.integer  "ecol_remitter_id",      limit: nil
    t.string   "pending_approval"
    t.integer  "notify_attempt_no",     limit: 8,    precision: 8
    t.datetime "notify_attempt_at"
    t.datetime "notified_at"
    t.string   "notify_status",         limit: 50
    t.string   "notify_result",         limit: 1000
    t.integer  "validate_attempt_no",                precision: 38
    t.string   "return_req_ref",        limit: 64
    t.string   "settle_req_ref",        limit: 64
    t.string   "credit_req_ref",        limit: 64
    t.string   "validation_ref",        limit: 50
    t.string   "return_transfer_type",  limit: 10
    t.integer  "approver_id",           limit: nil
    t.string   "remarks"
    t.string   "decision_by",           limit: 1
    t.integer  "va_txn_id",             limit: nil
    t.string   "va_transfer_status",    limit: 20
  end

  create_table "eco_tra_bkp_171001to181101", id: false, force: :cascade do |t|
    t.integer  "id",                    limit: nil,                 null: false
    t.string   "status",                limit: 20,                  null: false
    t.string   "transfer_type",         limit: 4,                   null: false
    t.string   "transfer_unique_no",    limit: 64,                  null: false
    t.string   "transfer_status",       limit: 25,                  null: false
    t.datetime "transfer_timestamp",                                null: false
    t.string   "transfer_ccy",          limit: 5,                   null: false
    t.decimal  "transfer_amt",                                      null: false
    t.string   "rmtr_ref",              limit: 64
    t.string   "rmtr_full_name",                                    null: false
    t.string   "rmtr_address"
    t.string   "rmtr_account_type",     limit: 10
    t.string   "rmtr_account_no",       limit: 64,                  null: false
    t.string   "rmtr_account_ifsc",     limit: 20,                  null: false
    t.string   "bene_full_name"
    t.string   "bene_account_type",     limit: 10
    t.string   "bene_account_no",       limit: 64,                  null: false
    t.string   "bene_account_ifsc",     limit: 20,                  null: false
    t.string   "rmtr_to_bene_note"
    t.datetime "received_at",                                       null: false
    t.string   "customer_code",         limit: 15
    t.string   "customer_subcode",      limit: 28
    t.string   "remitter_code",         limit: 28
    t.datetime "validated_at"
    t.string   "validation_status",     limit: 50
    t.datetime "credited_at"
    t.string   "credit_ref",            limit: 64
    t.integer  "credit_attempt_no",                  precision: 38
    t.string   "rmtr_email_notify_ref", limit: 64
    t.string   "rmtr_sms_notify_ref",   limit: 2000
    t.datetime "settled_at"
    t.string   "settle_status",         limit: 50
    t.string   "settle_ref",            limit: 64
    t.integer  "settle_attempt_no",                  precision: 38
    t.datetime "fault_at"
    t.string   "fault_code",            limit: 50
    t.string   "fault_reason",          limit: 1000
    t.datetime "created_at",                                        null: false
    t.datetime "updated_at",                                        null: false
    t.string   "invoice_no",            limit: 28
    t.datetime "validate_attempt_at"
    t.datetime "credit_attempt_at"
    t.datetime "returned_at"
    t.string   "return_ref",            limit: 64
    t.datetime "return_attempt_at"
    t.integer  "return_attempt_no",     limit: 8,    precision: 8
    t.datetime "settle_attempt_at"
    t.string   "bene_full_address"
    t.string   "validation_result",     limit: 1000
    t.string   "credit_acct_no",        limit: 25
    t.string   "settle_result",         limit: 1000
    t.integer  "ecol_remitter_id",      limit: nil
    t.string   "pending_approval"
    t.integer  "notify_attempt_no",     limit: 8,    precision: 8
    t.datetime "notify_attempt_at"
    t.datetime "notified_at"
    t.string   "notify_status",         limit: 50
    t.string   "notify_result",         limit: 1000
    t.integer  "validate_attempt_no",                precision: 38
    t.string   "return_req_ref",        limit: 64
    t.string   "settle_req_ref",        limit: 64
    t.string   "credit_req_ref",        limit: 64
    t.string   "validation_ref",        limit: 50
    t.string   "return_transfer_type",  limit: 10
    t.integer  "approver_id",           limit: nil
    t.string   "remarks"
    t.string   "decision_by",           limit: 1
    t.integer  "va_txn_id",             limit: nil
    t.string   "va_transfer_status",    limit: 20
  end

  create_table "eco_tra_bkp_171026to181101", id: false, force: :cascade do |t|
    t.integer  "id",                    limit: nil,                 null: false
    t.string   "status",                limit: 20,                  null: false
    t.string   "transfer_type",         limit: 4,                   null: false
    t.string   "transfer_unique_no",    limit: 64,                  null: false
    t.string   "transfer_status",       limit: 25,                  null: false
    t.datetime "transfer_timestamp",                                null: false
    t.string   "transfer_ccy",          limit: 5,                   null: false
    t.decimal  "transfer_amt",                                      null: false
    t.string   "rmtr_ref",              limit: 64
    t.string   "rmtr_full_name",                                    null: false
    t.string   "rmtr_address"
    t.string   "rmtr_account_type",     limit: 10
    t.string   "rmtr_account_no",       limit: 64,                  null: false
    t.string   "rmtr_account_ifsc",     limit: 20,                  null: false
    t.string   "bene_full_name"
    t.string   "bene_account_type",     limit: 10
    t.string   "bene_account_no",       limit: 64,                  null: false
    t.string   "bene_account_ifsc",     limit: 20,                  null: false
    t.string   "rmtr_to_bene_note"
    t.datetime "received_at",                                       null: false
    t.string   "customer_code",         limit: 15
    t.string   "customer_subcode",      limit: 28
    t.string   "remitter_code",         limit: 28
    t.datetime "validated_at"
    t.string   "validation_status",     limit: 50
    t.datetime "credited_at"
    t.string   "credit_ref",            limit: 64
    t.integer  "credit_attempt_no",                  precision: 38
    t.string   "rmtr_email_notify_ref", limit: 64
    t.string   "rmtr_sms_notify_ref",   limit: 2000
    t.datetime "settled_at"
    t.string   "settle_status",         limit: 50
    t.string   "settle_ref",            limit: 64
    t.integer  "settle_attempt_no",                  precision: 38
    t.datetime "fault_at"
    t.string   "fault_code",            limit: 50
    t.string   "fault_reason",          limit: 1000
    t.datetime "created_at",                                        null: false
    t.datetime "updated_at",                                        null: false
    t.string   "invoice_no",            limit: 28
    t.datetime "validate_attempt_at"
    t.datetime "credit_attempt_at"
    t.datetime "returned_at"
    t.string   "return_ref",            limit: 64
    t.datetime "return_attempt_at"
    t.integer  "return_attempt_no",     limit: 8,    precision: 8
    t.datetime "settle_attempt_at"
    t.string   "bene_full_address"
    t.string   "validation_result",     limit: 1000
    t.string   "credit_acct_no",        limit: 25
    t.string   "settle_result",         limit: 1000
    t.integer  "ecol_remitter_id",      limit: nil
    t.string   "pending_approval"
    t.integer  "notify_attempt_no",     limit: 8,    precision: 8
    t.datetime "notify_attempt_at"
    t.datetime "notified_at"
    t.string   "notify_status",         limit: 50
    t.string   "notify_result",         limit: 1000
    t.integer  "validate_attempt_no",                precision: 38
    t.string   "return_req_ref",        limit: 64
    t.string   "settle_req_ref",        limit: 64
    t.string   "credit_req_ref",        limit: 64
    t.string   "validation_ref",        limit: 50
    t.string   "return_transfer_type",  limit: 10
    t.integer  "approver_id",           limit: nil
    t.string   "remarks"
    t.string   "decision_by",           limit: 1
    t.integer  "va_txn_id",             limit: nil
    t.string   "va_transfer_status",    limit: 20
  end

  create_table "ecol_app_udtable", force: :cascade do |t|
    t.string   "app_code",                                                  null: false
    t.string   "udf1",             limit: 100,                              null: false
    t.string   "udf2",             limit: 100
    t.string   "udf3",             limit: 100
    t.string   "udf4",             limit: 100
    t.string   "udf5",             limit: 100
    t.datetime "created_at",                                                null: false
    t.datetime "updated_at",                                                null: false
    t.string   "created_by",       limit: 20
    t.string   "updated_by",       limit: 20
    t.integer  "lock_version",                 precision: 38, default: 0,   null: false
    t.string   "approval_status",  limit: 1,                  default: "U", null: false
    t.string   "last_action",      limit: 1,                  default: "C"
    t.integer  "approved_id",      limit: nil
    t.integer  "approved_version",             precision: 38
  end

  add_index "ecol_app_udtable", ["app_code", "udf1", "approval_status"], name: "ecol_app_udtable_01", unique: true
  add_index "ecol_app_udtable", ["app_code", "udf1", "udf2", "udf3", "udf4", "udf5", "approval_status"], name: "ecol_app_udtable_02"

  create_table "ecol_apps", force: :cascade do |t|
    t.string   "app_code",         limit: 50,                               null: false
    t.string   "notify_url",       limit: 500
    t.string   "validate_url",     limit: 500
    t.string   "http_username",    limit: 50
    t.string   "http_password"
    t.integer  "settings_cnt",     limit: nil
    t.string   "setting1"
    t.string   "setting2"
    t.string   "setting3"
    t.string   "setting4"
    t.string   "setting5"
    t.datetime "created_at",                                                null: false
    t.datetime "updated_at",                                                null: false
    t.string   "created_by",       limit: 20
    t.string   "updated_by",       limit: 20
    t.integer  "lock_version",                 precision: 38, default: 0,   null: false
    t.string   "last_action",      limit: 1,                  default: "C", null: false
    t.string   "approval_status",  limit: 1,                  default: "U", null: false
    t.integer  "approved_version",             precision: 38
    t.integer  "approved_id",      limit: nil
    t.integer  "udfs_cnt",         limit: nil,                default: 0
    t.integer  "unique_udfs_cnt",  limit: nil,                default: 0
    t.string   "udf1"
    t.string   "udf2"
    t.string   "udf3"
    t.string   "udf4"
    t.string   "udf5"
    t.string   "customer_code",    limit: 20
  end

  add_index "ecol_apps", ["app_code", "customer_code", "approval_status"], name: "ecol_apps_01", unique: true

  create_table "ecol_audit_logs", force: :cascade do |t|
    t.integer  "ecol_transaction_id", limit: nil,                 null: false
    t.string   "step_name",                                       null: false
    t.integer  "attempt_no",                       precision: 38, null: false
    t.string   "fault_code",          limit: 50
    t.string   "fault_reason",        limit: 1000
    t.datetime "req_timestamp"
    t.datetime "rep_timestamp"
    t.text     "req_bitstream"
    t.text     "rep_bitstream"
    t.text     "fault_bitstream"
    t.datetime "created_at",                                      null: false
    t.datetime "updated_at",                                      null: false
    t.string   "req_ref",             limit: 64
    t.text     "req_header"
    t.text     "rep_header"
    t.string   "req_uri",             limit: 500
    t.string   "remote_host",         limit: 500
    t.integer  "override_user_id",    limit: nil
  end

  add_index "ecol_audit_logs", ["ecol_transaction_id", "step_name", "attempt_no"], name: "uk_ecol_audit_logs", unique: true

  create_table "ecol_audit_logs_bkp_ujyx", id: false, force: :cascade do |t|
    t.integer  "id",                  limit: nil,                 null: false
    t.integer  "ecol_transaction_id", limit: nil,                 null: false
    t.string   "step_name",                                       null: false
    t.integer  "attempt_no",                       precision: 38, null: false
    t.string   "fault_code",          limit: 50
    t.string   "fault_reason",        limit: 1000
    t.datetime "req_timestamp"
    t.datetime "rep_timestamp"
    t.text     "req_bitstream"
    t.text     "rep_bitstream"
    t.text     "fault_bitstream"
    t.datetime "created_at",                                      null: false
    t.datetime "updated_at",                                      null: false
    t.string   "req_ref",             limit: 64
    t.text     "req_header"
    t.text     "rep_header"
    t.string   "req_uri",             limit: 500
    t.string   "remote_host",         limit: 500
    t.integer  "override_user_id",    limit: nil
  end

  create_table "ecol_audits_bkp_181105to181231", id: false, force: :cascade do |t|
    t.integer  "id",                  limit: nil,                 null: false
    t.integer  "ecol_transaction_id", limit: nil,                 null: false
    t.string   "step_name",                                       null: false
    t.integer  "attempt_no",                       precision: 38, null: false
    t.string   "fault_code",          limit: 50
    t.string   "fault_reason",        limit: 1000
    t.datetime "req_timestamp"
    t.datetime "rep_timestamp"
    t.text     "req_bitstream"
    t.text     "rep_bitstream"
    t.text     "fault_bitstream"
    t.datetime "created_at",                                      null: false
    t.datetime "updated_at",                                      null: false
    t.string   "req_ref",             limit: 64
    t.text     "req_header"
    t.text     "rep_header"
    t.string   "req_uri",             limit: 500
    t.string   "remote_host",         limit: 500
    t.integer  "override_user_id",    limit: nil
  end

  create_table "ecol_audits_bkp_190101to190131", id: false, force: :cascade do |t|
    t.integer  "id",                  limit: nil,                 null: false
    t.integer  "ecol_transaction_id", limit: nil,                 null: false
    t.string   "step_name",                                       null: false
    t.integer  "attempt_no",                       precision: 38, null: false
    t.string   "fault_code",          limit: 50
    t.string   "fault_reason",        limit: 1000
    t.datetime "req_timestamp"
    t.datetime "rep_timestamp"
    t.text     "req_bitstream"
    t.text     "rep_bitstream"
    t.text     "fault_bitstream"
    t.datetime "created_at",                                      null: false
    t.datetime "updated_at",                                      null: false
    t.string   "req_ref",             limit: 64
    t.text     "req_header"
    t.text     "rep_header"
    t.string   "req_uri",             limit: 500
    t.string   "remote_host",         limit: 500
    t.integer  "override_user_id",    limit: nil
  end

  create_table "ecol_customers", force: :cascade do |t|
    t.string   "code",                          limit: 15,                               null: false
    t.string   "name",                          limit: 100,                              null: false
    t.string   "is_enabled",                                               default: "Y", null: false
    t.string   "val_method",                    limit: 1,                                null: false
    t.string   "token_1_type",                  limit: 3,                  default: "f", null: false
    t.integer  "token_1_length",                            precision: 38, default: 0,   null: false
    t.string   "val_token_1",                                              default: "f", null: false
    t.string   "token_2_type",                  limit: 3,                  default: "f", null: false
    t.integer  "token_2_length",                            precision: 38, default: 0,   null: false
    t.string   "val_token_2",                   limit: 1,                  default: "f", null: false
    t.string   "token_3_type",                                             default: "f", null: false
    t.integer  "token_3_length",                            precision: 38, default: 0,   null: false
    t.string   "val_token_3",                   limit: 1,                  default: "f", null: false
    t.string   "val_txn_date",                  limit: 1,                  default: "f", null: false
    t.string   "val_txn_amt",                   limit: 1,                  default: "f", null: false
    t.string   "val_ben_name",                  limit: 1,                  default: "f", null: false
    t.string   "val_rem_acct",                  limit: 1,                  default: "f", null: false
    t.string   "return_if_val_reject",          limit: 1,                  default: "f", null: false
    t.string   "file_upld_mthd",                limit: 1
    t.string   "credit_acct_val_pass",          limit: 25,                               null: false
    t.string   "nrtv_sufx_1",                   limit: 5,                  default: "f", null: false
    t.string   "nrtv_sufx_2",                   limit: 5,                  default: "f", null: false
    t.string   "nrtv_sufx_3",                   limit: 5,                  default: "f", null: false
    t.string   "rmtr_alert_on",                 limit: 1,                  default: "f", null: false
    t.string   "rmtr_pass_txt",                 limit: 500
    t.string   "rmtr_return_txt",               limit: 500
    t.string   "created_by",                    limit: 20
    t.string   "updated_by",                    limit: 20
    t.integer  "lock_version",                              precision: 38, default: 0,   null: false
    t.datetime "created_at",                                                             null: false
    t.datetime "updated_at",                                                             null: false
    t.string   "approval_status",               limit: 1,                  default: "U", null: false
    t.string   "last_action",                   limit: 1,                  default: "C"
    t.integer  "approved_version",                          precision: 38
    t.string   "auto_credit",                   limit: 1,                  default: "Y"
    t.string   "auto_return",                   limit: 1,                  default: "Y"
    t.integer  "approved_id",                   limit: nil
    t.string   "val_last_token_length",         limit: 1,                  default: "f"
    t.string   "token_1_starts_with",           limit: 29
    t.string   "token_1_contains",              limit: 29
    t.string   "token_1_ends_with",             limit: 29
    t.string   "token_2_starts_with",           limit: 29
    t.string   "token_2_contains",              limit: 29
    t.string   "token_2_ends_with",             limit: 29
    t.string   "token_3_starts_with",           limit: 29
    t.string   "token_3_contains",              limit: 29
    t.string   "token_3_ends_with",             limit: 29
    t.string   "credit_acct_val_fail",          limit: 25
    t.string   "val_rmtr_name",                 limit: 1,                  default: "f"
    t.string   "cust_alert_on",                 limit: 1,                  default: "f", null: false
    t.string   "customer_id",                   limit: 50,                 default: "0", null: false
    t.string   "pool_acct_no",                  limit: 25
    t.string   "app_code",                      limit: 15
    t.string   "identity_user_id",              limit: 20
    t.string   "should_prevalidate",            limit: 1,                  default: "f", null: false
    t.string   "allowed_operations",            limit: 100
    t.integer  "rmtr_pass_template_id",         limit: nil
    t.integer  "rmtr_return_template_id",       limit: nil
    t.string   "sub_member_bank",               limit: 1,                  default: "f"
    t.string   "sub_member_bank_ifsc"
    t.string   "validation_failed_auto_return",                            default: "f"
    t.string   "autoreturn_validationfailed",   limit: 2,                  default: "f"
    t.string   "intermidate_transaction"
    t.string   "autoreturn_on_failed",          limit: 2,                  default: "f"
    t.string   "auto_return_on_failed",         limit: 2,                  default: "f"
  end

  add_index "ecol_customers", ["code", "approval_status"], name: "customer_index_on_status", unique: true

  create_table "ecol_fetch_statistics", force: :cascade do |t|
    t.datetime "last_neft_at",              null: false
    t.integer  "last_neft_id",  limit: nil, null: false
    t.integer  "last_neft_cnt", limit: nil, null: false
    t.integer  "tot_neft_cnt",  limit: nil, null: false
    t.datetime "last_rtgs_at",              null: false
    t.integer  "last_rtgs_id",  limit: nil, null: false
    t.integer  "last_rtgs_cnt", limit: nil, null: false
    t.integer  "tot_rtgs_cnt",  limit: nil, null: false
  end

  create_table "ecol_incoming_files", force: :cascade do |t|
    t.string "file_name",      limit: 100, null: false
    t.string "customer_id",    limit: 20
    t.string "file_upld_mthd", limit: 1
  end

  add_index "ecol_incoming_files", ["file_name"], name: "ecol_incoming_files_01", unique: true

  create_table "ecol_incoming_records", force: :cascade do |t|
    t.integer "incoming_file_record_id", limit: nil,                 null: false
    t.string  "file_name",               limit: 100,                 null: false
    t.string  "customer_code",           limit: 20
    t.string  "remitter_code",           limit: 20
    t.string  "customer_subcode",        limit: 20
    t.string  "invoice_no",              limit: 20
    t.string  "customer_account_no",     limit: 20
    t.string  "customer_subcode_email",  limit: 100
    t.string  "customer_subcode_mobile", limit: 10
    t.string  "rmtr_name"
    t.string  "rmtr_address",            limit: 100
    t.string  "rmtr_email",              limit: 50
    t.string  "rmtr_mobile",             limit: 50
    t.decimal "invoice_amt"
    t.decimal "min_credit_amt"
    t.decimal "max_credit_amt"
    t.date    "start_date"
    t.date    "due_date"
    t.integer "due_date_tol_days",                    precision: 38
    t.string  "rmtr_acct_no",            limit: 50
    t.string  "misc_field_11"
    t.string  "misc_field_12"
    t.string  "misc_field_13"
    t.string  "misc_field_14"
    t.string  "misc_field_15"
    t.string  "misc_field_16"
    t.string  "misc_field_17"
    t.string  "misc_field_18"
    t.string  "misc_field_19"
    t.string  "misc_field_20"
    t.string  "branch_office_region",    limit: 100
    t.string  "sales_office_region",     limit: 100
    t.string  "regional_code",           limit: 50
    t.string  "branch_code",             limit: 50
    t.string  "project_name",            limit: 50
    t.string  "project_code",            limit: 50
    t.string  "value_variation",         limit: 20
    t.string  "additional_email_ids",    limit: 2000
    t.string  "additional_mobile_nos",   limit: 500
  end

  add_index "ecol_incoming_records", ["incoming_file_record_id", "file_name"], name: "ecol_incoming_records_01", unique: true

  create_table "ecol_notifications", force: :cascade do |t|
    t.integer  "ecol_transaction_id", limit: nil
    t.string   "ecol_customer_id"
    t.string   "notification_for",    limit: 1
    t.string   "status_code",         limit: 10
    t.text     "req_bitstream"
    t.text     "rep_bitstream"
    t.datetime "req_timestamp"
    t.datetime "rep_timestamp"
    t.string   "fault_code"
    t.string   "fault_reason"
  end

  create_table "ecol_pending_credits", force: :cascade do |t|
    t.string   "broker_uuid",                     null: false
    t.integer  "ecol_transaction_id", limit: nil, null: false
    t.datetime "created_at",                      null: false
  end

  create_table "ecol_pending_notifications", force: :cascade do |t|
    t.string   "broker_uuid",         limit: 500
    t.integer  "ecol_transaction_id", limit: nil
    t.datetime "created_at"
  end

  create_table "ecol_pending_returns", force: :cascade do |t|
    t.string   "broker_uuid",                     null: false
    t.integer  "ecol_transaction_id", limit: nil, null: false
    t.datetime "created_at",                      null: false
  end

  create_table "ecol_pending_settlements", force: :cascade do |t|
    t.string   "broker_uuid",                     null: false
    t.integer  "ecol_transaction_id", limit: nil, null: false
    t.datetime "created_at",                      null: false
  end

  create_table "ecol_pending_va_transfers", force: :cascade do |t|
    t.string   "broker_uuid",                     null: false
    t.integer  "ecol_va_transfer_id", limit: nil, null: false
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
  end

  add_index "ecol_pending_va_transfers", ["broker_uuid", "created_at"], name: "ecol_pending_va_transfers_01"

  create_table "ecol_pending_validations", force: :cascade do |t|
    t.string   "broker_uuid",                     null: false
    t.integer  "ecol_transaction_id", limit: nil, null: false
    t.datetime "created_at",                      null: false
  end

  create_table "ecol_remitters", force: :cascade do |t|
    t.integer  "incoming_file_id",        limit: nil
    t.string   "customer_code",           limit: 15,                                         null: false
    t.string   "customer_subcode",        limit: 28
    t.string   "remitter_code",           limit: 28
    t.string   "credit_acct_no",          limit: 25
    t.string   "customer_subcode_email",  limit: 100
    t.string   "customer_subcode_mobile", limit: 10
    t.string   "rmtr_name",               limit: 100,                                        null: false
    t.string   "rmtr_address",            limit: 105
    t.string   "rmtr_acct_no",            limit: 25
    t.string   "rmtr_email",              limit: 100
    t.string   "rmtr_mobile",             limit: 10
    t.string   "invoice_no",              limit: 28
    t.decimal  "invoice_amt",                                                                null: false
    t.decimal  "invoice_amt_tol_pct"
    t.decimal  "min_credit_amt"
    t.decimal  "max_credit_amt"
    t.date     "due_date",                                            default: '2015-01-01', null: false
    t.integer  "due_date_tol_days",                    precision: 38, default: 0
    t.string   "udf1"
    t.string   "udf2"
    t.string   "udf3"
    t.string   "udf4"
    t.string   "udf5"
    t.string   "udf6"
    t.string   "udf7"
    t.string   "udf8"
    t.string   "udf9"
    t.string   "udf10"
    t.string   "udf11"
    t.string   "udf12"
    t.string   "udf13"
    t.string   "udf14"
    t.string   "udf15"
    t.string   "udf16"
    t.string   "udf17"
    t.string   "udf18"
    t.string   "udf19"
    t.string   "udf20"
    t.string   "created_by",              limit: 20
    t.string   "updated_by",              limit: 20
    t.integer  "lock_version",                         precision: 38, default: 0,            null: false
    t.datetime "created_at",                                                                 null: false
    t.datetime "updated_at",                                                                 null: false
    t.string   "approval_status",         limit: 1,                   default: "U",          null: false
    t.string   "last_action",             limit: 1,                   default: "C"
    t.integer  "approved_version",                     precision: 38
    t.integer  "approved_id",             limit: nil
    t.string   "is_enabled",              limit: 1,                   default: "Y",          null: false
    t.string   "additional_mobile_nos",   limit: 500
    t.string   "additional_email_ids",    limit: 2000
  end

  add_index "ecol_remitters", ["customer_code", "customer_subcode", "remitter_code", "invoice_no", "approval_status"], name: "remitter_index_on_status", unique: true

  create_table "ecol_rules", force: :cascade do |t|
    t.string   "ifsc",                 limit: 11,                               null: false
    t.string   "cod_acct_no",          limit: 15,                               null: false
    t.string   "stl_gl_inward",        limit: 15,                               null: false
    t.string   "created_by",           limit: 20
    t.string   "updated_by",           limit: 20
    t.integer  "lock_version",                     precision: 38, default: 0,   null: false
    t.datetime "created_at",                                                    null: false
    t.datetime "updated_at",                                                    null: false
    t.string   "approval_status",      limit: 1,                  default: "U", null: false
    t.string   "last_action",          limit: 1,                  default: "C"
    t.integer  "approved_version",                 precision: 38
    t.integer  "approved_id",          limit: nil
    t.string   "neft_sender_ifsc",                                              null: false
    t.string   "customer_id",                                                   null: false
    t.string   "return_account_no",    limit: 20
    t.string   "allow_return_by_rtgs",                            default: "f", null: false
  end

  create_table "ecol_trans_bkp_181101to181231", id: false, force: :cascade do |t|
    t.integer  "id",                    limit: nil,                 null: false
    t.string   "status",                limit: 20,                  null: false
    t.string   "transfer_type",         limit: 4,                   null: false
    t.string   "transfer_unique_no",    limit: 64,                  null: false
    t.string   "transfer_status",       limit: 25,                  null: false
    t.datetime "transfer_timestamp",                                null: false
    t.string   "transfer_ccy",          limit: 5,                   null: false
    t.decimal  "transfer_amt",                                      null: false
    t.string   "rmtr_ref",              limit: 64
    t.string   "rmtr_full_name",                                    null: false
    t.string   "rmtr_address"
    t.string   "rmtr_account_type",     limit: 10
    t.string   "rmtr_account_no",       limit: 64,                  null: false
    t.string   "rmtr_account_ifsc",     limit: 20,                  null: false
    t.string   "bene_full_name"
    t.string   "bene_account_type",     limit: 10
    t.string   "bene_account_no",       limit: 64,                  null: false
    t.string   "bene_account_ifsc",     limit: 20,                  null: false
    t.string   "rmtr_to_bene_note"
    t.datetime "received_at",                                       null: false
    t.string   "customer_code",         limit: 15
    t.string   "customer_subcode",      limit: 28
    t.string   "remitter_code",         limit: 28
    t.datetime "validated_at"
    t.string   "validation_status",     limit: 50
    t.datetime "credited_at"
    t.string   "credit_ref",            limit: 64
    t.integer  "credit_attempt_no",                  precision: 38
    t.string   "rmtr_email_notify_ref", limit: 64
    t.string   "rmtr_sms_notify_ref",   limit: 2000
    t.datetime "settled_at"
    t.string   "settle_status",         limit: 50
    t.string   "settle_ref",            limit: 64
    t.integer  "settle_attempt_no",                  precision: 38
    t.datetime "fault_at"
    t.string   "fault_code",            limit: 50
    t.string   "fault_reason",          limit: 1000
    t.datetime "created_at",                                        null: false
    t.datetime "updated_at",                                        null: false
    t.string   "invoice_no",            limit: 28
    t.datetime "validate_attempt_at"
    t.datetime "credit_attempt_at"
    t.datetime "returned_at"
    t.string   "return_ref",            limit: 64
    t.datetime "return_attempt_at"
    t.integer  "return_attempt_no",     limit: 8,    precision: 8
    t.datetime "settle_attempt_at"
    t.string   "bene_full_address"
    t.string   "validation_result",     limit: 1000
    t.string   "credit_acct_no",        limit: 25
    t.string   "settle_result",         limit: 1000
    t.integer  "ecol_remitter_id",      limit: nil
    t.string   "pending_approval"
    t.integer  "notify_attempt_no",     limit: 8,    precision: 8
    t.datetime "notify_attempt_at"
    t.datetime "notified_at"
    t.string   "notify_status",         limit: 50
    t.string   "notify_result",         limit: 1000
    t.integer  "validate_attempt_no",                precision: 38
    t.string   "return_req_ref",        limit: 64
    t.string   "settle_req_ref",        limit: 64
    t.string   "credit_req_ref",        limit: 64
    t.string   "validation_ref",        limit: 50
    t.string   "return_transfer_type",  limit: 10
    t.integer  "approver_id",           limit: nil
    t.string   "remarks"
    t.string   "decision_by",           limit: 1
    t.integer  "va_txn_id",             limit: nil
    t.string   "va_transfer_status",    limit: 20
  end

  create_table "ecol_trans_bkp_181107to181231", id: false, force: :cascade do |t|
    t.integer  "id",                    limit: nil,                 null: false
    t.string   "status",                limit: 20,                  null: false
    t.string   "transfer_type",         limit: 4,                   null: false
    t.string   "transfer_unique_no",    limit: 64,                  null: false
    t.string   "transfer_status",       limit: 25,                  null: false
    t.datetime "transfer_timestamp",                                null: false
    t.string   "transfer_ccy",          limit: 5,                   null: false
    t.decimal  "transfer_amt",                                      null: false
    t.string   "rmtr_ref",              limit: 64
    t.string   "rmtr_full_name",                                    null: false
    t.string   "rmtr_address"
    t.string   "rmtr_account_type",     limit: 10
    t.string   "rmtr_account_no",       limit: 64,                  null: false
    t.string   "rmtr_account_ifsc",     limit: 20,                  null: false
    t.string   "bene_full_name"
    t.string   "bene_account_type",     limit: 10
    t.string   "bene_account_no",       limit: 64,                  null: false
    t.string   "bene_account_ifsc",     limit: 20,                  null: false
    t.string   "rmtr_to_bene_note"
    t.datetime "received_at",                                       null: false
    t.string   "customer_code",         limit: 15
    t.string   "customer_subcode",      limit: 28
    t.string   "remitter_code",         limit: 28
    t.datetime "validated_at"
    t.string   "validation_status",     limit: 50
    t.datetime "credited_at"
    t.string   "credit_ref",            limit: 64
    t.integer  "credit_attempt_no",                  precision: 38
    t.string   "rmtr_email_notify_ref", limit: 64
    t.string   "rmtr_sms_notify_ref",   limit: 2000
    t.datetime "settled_at"
    t.string   "settle_status",         limit: 50
    t.string   "settle_ref",            limit: 64
    t.integer  "settle_attempt_no",                  precision: 38
    t.datetime "fault_at"
    t.string   "fault_code",            limit: 50
    t.string   "fault_reason",          limit: 1000
    t.datetime "created_at",                                        null: false
    t.datetime "updated_at",                                        null: false
    t.string   "invoice_no",            limit: 28
    t.datetime "validate_attempt_at"
    t.datetime "credit_attempt_at"
    t.datetime "returned_at"
    t.string   "return_ref",            limit: 64
    t.datetime "return_attempt_at"
    t.integer  "return_attempt_no",     limit: 8,    precision: 8
    t.datetime "settle_attempt_at"
    t.string   "bene_full_address"
    t.string   "validation_result",     limit: 1000
    t.string   "credit_acct_no",        limit: 25
    t.string   "settle_result",         limit: 1000
    t.integer  "ecol_remitter_id",      limit: nil
    t.string   "pending_approval"
    t.integer  "notify_attempt_no",     limit: 8,    precision: 8
    t.datetime "notify_attempt_at"
    t.datetime "notified_at"
    t.string   "notify_status",         limit: 50
    t.string   "notify_result",         limit: 1000
    t.integer  "validate_attempt_no",                precision: 38
    t.string   "return_req_ref",        limit: 64
    t.string   "settle_req_ref",        limit: 64
    t.string   "credit_req_ref",        limit: 64
    t.string   "validation_ref",        limit: 50
    t.string   "return_transfer_type",  limit: 10
    t.integer  "approver_id",           limit: nil
    t.string   "remarks"
    t.string   "decision_by",           limit: 1
    t.integer  "va_txn_id",             limit: nil
    t.string   "va_transfer_status",    limit: 20
  end

  create_table "ecol_trans_bkp_181201to181231", id: false, force: :cascade do |t|
    t.integer  "id",                    limit: nil,                 null: false
    t.string   "status",                limit: 20,                  null: false
    t.string   "transfer_type",         limit: 4,                   null: false
    t.string   "transfer_unique_no",    limit: 64,                  null: false
    t.string   "transfer_status",       limit: 25,                  null: false
    t.datetime "transfer_timestamp",                                null: false
    t.string   "transfer_ccy",          limit: 5,                   null: false
    t.decimal  "transfer_amt",                                      null: false
    t.string   "rmtr_ref",              limit: 64
    t.string   "rmtr_full_name",                                    null: false
    t.string   "rmtr_address"
    t.string   "rmtr_account_type",     limit: 10
    t.string   "rmtr_account_no",       limit: 64,                  null: false
    t.string   "rmtr_account_ifsc",     limit: 20,                  null: false
    t.string   "bene_full_name"
    t.string   "bene_account_type",     limit: 10
    t.string   "bene_account_no",       limit: 64,                  null: false
    t.string   "bene_account_ifsc",     limit: 20,                  null: false
    t.string   "rmtr_to_bene_note"
    t.datetime "received_at",                                       null: false
    t.string   "customer_code",         limit: 15
    t.string   "customer_subcode",      limit: 28
    t.string   "remitter_code",         limit: 28
    t.datetime "validated_at"
    t.string   "validation_status",     limit: 50
    t.datetime "credited_at"
    t.string   "credit_ref",            limit: 64
    t.integer  "credit_attempt_no",                  precision: 38
    t.string   "rmtr_email_notify_ref", limit: 64
    t.string   "rmtr_sms_notify_ref",   limit: 2000
    t.datetime "settled_at"
    t.string   "settle_status",         limit: 50
    t.string   "settle_ref",            limit: 64
    t.integer  "settle_attempt_no",                  precision: 38
    t.datetime "fault_at"
    t.string   "fault_code",            limit: 50
    t.string   "fault_reason",          limit: 1000
    t.datetime "created_at",                                        null: false
    t.datetime "updated_at",                                        null: false
    t.string   "invoice_no",            limit: 28
    t.datetime "validate_attempt_at"
    t.datetime "credit_attempt_at"
    t.datetime "returned_at"
    t.string   "return_ref",            limit: 64
    t.datetime "return_attempt_at"
    t.integer  "return_attempt_no",     limit: 8,    precision: 8
    t.datetime "settle_attempt_at"
    t.string   "bene_full_address"
    t.string   "validation_result",     limit: 1000
    t.string   "credit_acct_no",        limit: 25
    t.string   "settle_result",         limit: 1000
    t.integer  "ecol_remitter_id",      limit: nil
    t.string   "pending_approval"
    t.integer  "notify_attempt_no",     limit: 8,    precision: 8
    t.datetime "notify_attempt_at"
    t.datetime "notified_at"
    t.string   "notify_status",         limit: 50
    t.string   "notify_result",         limit: 1000
    t.integer  "validate_attempt_no",                precision: 38
    t.string   "return_req_ref",        limit: 64
    t.string   "settle_req_ref",        limit: 64
    t.string   "credit_req_ref",        limit: 64
    t.string   "validation_ref",        limit: 50
    t.string   "return_transfer_type",  limit: 10
    t.integer  "approver_id",           limit: nil
    t.string   "remarks"
    t.string   "decision_by",           limit: 1
    t.integer  "va_txn_id",             limit: nil
    t.string   "va_transfer_status",    limit: 20
  end

  create_table "ecol_trans_bkp_181204to181218", id: false, force: :cascade do |t|
    t.integer  "id",                    limit: nil,                 null: false
    t.string   "status",                limit: 20,                  null: false
    t.string   "transfer_type",         limit: 4,                   null: false
    t.string   "transfer_unique_no",    limit: 64,                  null: false
    t.string   "transfer_status",       limit: 25,                  null: false
    t.datetime "transfer_timestamp",                                null: false
    t.string   "transfer_ccy",          limit: 5,                   null: false
    t.decimal  "transfer_amt",                                      null: false
    t.string   "rmtr_ref",              limit: 64
    t.string   "rmtr_full_name",                                    null: false
    t.string   "rmtr_address"
    t.string   "rmtr_account_type",     limit: 10
    t.string   "rmtr_account_no",       limit: 64,                  null: false
    t.string   "rmtr_account_ifsc",     limit: 20,                  null: false
    t.string   "bene_full_name"
    t.string   "bene_account_type",     limit: 10
    t.string   "bene_account_no",       limit: 64,                  null: false
    t.string   "bene_account_ifsc",     limit: 20,                  null: false
    t.string   "rmtr_to_bene_note"
    t.datetime "received_at",                                       null: false
    t.string   "customer_code",         limit: 15
    t.string   "customer_subcode",      limit: 28
    t.string   "remitter_code",         limit: 28
    t.datetime "validated_at"
    t.string   "validation_status",     limit: 50
    t.datetime "credited_at"
    t.string   "credit_ref",            limit: 64
    t.integer  "credit_attempt_no",                  precision: 38
    t.string   "rmtr_email_notify_ref", limit: 64
    t.string   "rmtr_sms_notify_ref",   limit: 2000
    t.datetime "settled_at"
    t.string   "settle_status",         limit: 50
    t.string   "settle_ref",            limit: 64
    t.integer  "settle_attempt_no",                  precision: 38
    t.datetime "fault_at"
    t.string   "fault_code",            limit: 50
    t.string   "fault_reason",          limit: 1000
    t.datetime "created_at",                                        null: false
    t.datetime "updated_at",                                        null: false
    t.string   "invoice_no",            limit: 28
    t.datetime "validate_attempt_at"
    t.datetime "credit_attempt_at"
    t.datetime "returned_at"
    t.string   "return_ref",            limit: 64
    t.datetime "return_attempt_at"
    t.integer  "return_attempt_no",     limit: 8,    precision: 8
    t.datetime "settle_attempt_at"
    t.string   "bene_full_address"
    t.string   "validation_result",     limit: 1000
    t.string   "credit_acct_no",        limit: 25
    t.string   "settle_result",         limit: 1000
    t.integer  "ecol_remitter_id",      limit: nil
    t.string   "pending_approval"
    t.integer  "notify_attempt_no",     limit: 8,    precision: 8
    t.datetime "notify_attempt_at"
    t.datetime "notified_at"
    t.string   "notify_status",         limit: 50
    t.string   "notify_result",         limit: 1000
    t.integer  "validate_attempt_no",                precision: 38
    t.string   "return_req_ref",        limit: 64
    t.string   "settle_req_ref",        limit: 64
    t.string   "credit_req_ref",        limit: 64
    t.string   "validation_ref",        limit: 50
    t.string   "return_transfer_type",  limit: 10
    t.integer  "approver_id",           limit: nil
    t.string   "remarks"
    t.string   "decision_by",           limit: 1
    t.integer  "va_txn_id",             limit: nil
    t.string   "va_transfer_status",    limit: 20
  end

  create_table "ecol_trans_bkp_190101to190131", id: false, force: :cascade do |t|
    t.integer  "id",                    limit: nil,                 null: false
    t.string   "status",                limit: 20,                  null: false
    t.string   "transfer_type",         limit: 4,                   null: false
    t.string   "transfer_unique_no",    limit: 64,                  null: false
    t.string   "transfer_status",       limit: 25,                  null: false
    t.datetime "transfer_timestamp",                                null: false
    t.string   "transfer_ccy",          limit: 5,                   null: false
    t.decimal  "transfer_amt",                                      null: false
    t.string   "rmtr_ref",              limit: 64
    t.string   "rmtr_full_name",                                    null: false
    t.string   "rmtr_address"
    t.string   "rmtr_account_type",     limit: 10
    t.string   "rmtr_account_no",       limit: 64,                  null: false
    t.string   "rmtr_account_ifsc",     limit: 20,                  null: false
    t.string   "bene_full_name"
    t.string   "bene_account_type",     limit: 10
    t.string   "bene_account_no",       limit: 64,                  null: false
    t.string   "bene_account_ifsc",     limit: 20,                  null: false
    t.string   "rmtr_to_bene_note"
    t.datetime "received_at",                                       null: false
    t.string   "customer_code",         limit: 15
    t.string   "customer_subcode",      limit: 28
    t.string   "remitter_code",         limit: 28
    t.datetime "validated_at"
    t.string   "validation_status",     limit: 50
    t.datetime "credited_at"
    t.string   "credit_ref",            limit: 64
    t.integer  "credit_attempt_no",                  precision: 38
    t.string   "rmtr_email_notify_ref", limit: 64
    t.string   "rmtr_sms_notify_ref",   limit: 2000
    t.datetime "settled_at"
    t.string   "settle_status",         limit: 50
    t.string   "settle_ref",            limit: 64
    t.integer  "settle_attempt_no",                  precision: 38
    t.datetime "fault_at"
    t.string   "fault_code",            limit: 50
    t.string   "fault_reason",          limit: 1000
    t.datetime "created_at",                                        null: false
    t.datetime "updated_at",                                        null: false
    t.string   "invoice_no",            limit: 28
    t.datetime "validate_attempt_at"
    t.datetime "credit_attempt_at"
    t.datetime "returned_at"
    t.string   "return_ref",            limit: 64
    t.datetime "return_attempt_at"
    t.integer  "return_attempt_no",     limit: 8,    precision: 8
    t.datetime "settle_attempt_at"
    t.string   "bene_full_address"
    t.string   "validation_result",     limit: 1000
    t.string   "credit_acct_no",        limit: 25
    t.string   "settle_result",         limit: 1000
    t.integer  "ecol_remitter_id",      limit: nil
    t.string   "pending_approval"
    t.integer  "notify_attempt_no",     limit: 8,    precision: 8
    t.datetime "notify_attempt_at"
    t.datetime "notified_at"
    t.string   "notify_status",         limit: 50
    t.string   "notify_result",         limit: 1000
    t.integer  "validate_attempt_no",                precision: 38
    t.string   "return_req_ref",        limit: 64
    t.string   "settle_req_ref",        limit: 64
    t.string   "credit_req_ref",        limit: 64
    t.string   "validation_ref",        limit: 50
    t.string   "return_transfer_type",  limit: 10
    t.integer  "approver_id",           limit: nil
    t.string   "remarks"
    t.string   "decision_by",           limit: 1
    t.integer  "va_txn_id",             limit: nil
    t.string   "va_transfer_status",    limit: 20
  end

  create_table "ecol_transactions", force: :cascade do |t|
    t.string   "status",                         limit: 20,                  default: "f", null: false
    t.string   "transfer_type",                  limit: 4,                                 null: false
    t.string   "transfer_unique_no",             limit: 64,                                null: false
    t.string   "transfer_status",                limit: 25,                                null: false
    t.datetime "transfer_timestamp",                                                       null: false
    t.string   "transfer_ccy",                   limit: 5,                                 null: false
    t.decimal  "transfer_amt",                                                             null: false
    t.string   "rmtr_ref",                       limit: 64
    t.string   "rmtr_full_name",                                                           null: false
    t.string   "rmtr_address"
    t.string   "rmtr_account_type",              limit: 10
    t.string   "rmtr_account_no",                limit: 64,                                null: false
    t.string   "rmtr_account_ifsc",              limit: 20,                                null: false
    t.string   "bene_full_name"
    t.string   "bene_account_type",              limit: 10
    t.string   "bene_account_no",                limit: 64,                                null: false
    t.string   "bene_account_ifsc",              limit: 20,                                null: false
    t.string   "rmtr_to_bene_note"
    t.datetime "received_at",                                                              null: false
    t.string   "customer_code",                  limit: 15
    t.string   "customer_subcode",               limit: 28
    t.string   "remitter_code",                  limit: 28
    t.datetime "validated_at"
    t.string   "validation_status",              limit: 50
    t.datetime "credited_at"
    t.string   "credit_ref",                     limit: 64
    t.integer  "credit_attempt_no",                           precision: 38
    t.string   "rmtr_email_notify_ref",          limit: 64
    t.string   "rmtr_sms_notify_ref",            limit: 2000
    t.datetime "settled_at"
    t.string   "settle_status",                  limit: 50
    t.string   "settle_ref",                     limit: 64
    t.integer  "settle_attempt_no",                           precision: 38
    t.datetime "fault_at"
    t.string   "fault_code",                     limit: 50
    t.string   "fault_reason",                   limit: 1000
    t.datetime "created_at",                                                               null: false
    t.datetime "updated_at",                                                               null: false
    t.string   "invoice_no",                     limit: 28
    t.datetime "validate_attempt_at"
    t.datetime "credit_attempt_at"
    t.datetime "returned_at"
    t.string   "return_ref",                     limit: 64
    t.datetime "return_attempt_at"
    t.integer  "return_attempt_no",              limit: 8,    precision: 8
    t.datetime "settle_attempt_at"
    t.string   "bene_full_address"
    t.string   "validation_result",              limit: 1000
    t.string   "credit_acct_no",                 limit: 25
    t.string   "settle_result",                  limit: 1000
    t.integer  "ecol_remitter_id",               limit: nil
    t.string   "pending_approval",                                           default: "Y"
    t.integer  "notify_attempt_no",              limit: 8,    precision: 8
    t.datetime "notify_attempt_at"
    t.datetime "notified_at"
    t.string   "notify_status",                  limit: 50
    t.string   "notify_result",                  limit: 1000
    t.integer  "validate_attempt_no",                         precision: 38
    t.string   "return_req_ref",                 limit: 64
    t.string   "settle_req_ref",                 limit: 64
    t.string   "credit_req_ref",                 limit: 64
    t.string   "validation_ref",                 limit: 50
    t.string   "return_transfer_type",           limit: 10
    t.integer  "approver_id",                    limit: nil
    t.string   "remarks"
    t.string   "decision_by",                    limit: 1,                   default: "A"
    t.integer  "va_txn_id",                      limit: nil
    t.string   "va_transfer_status",             limit: 20
    t.string   "ecol_new",                                                   default: "Y"
    t.string   "pending_flag",                                               default: "f"
    t.string   "reject_flag",                                                default: "f"
    t.string   "approval_columns"
    t.string   "last_action",                    limit: 1,                   default: "C"
    t.integer  "approved_version",                            precision: 38
    t.integer  "approved_id",                    limit: nil
    t.string   "intermidiate_transaction_state"
    t.string   "approval_status",                limit: 2
  end

  add_index "ecol_transactions", ["CASE  WHEN \"TRANSFER_TYPE\"<>'NEFT' THEN \"TRANSFER_UNIQUE_NO\" END ", "CASE  WHEN \"TRANSFER_TYPE\"<>'NEFT' THEN \"TRANSFER_TYPE\" END "], name: "ecol_transactions_04", unique: true

  create_table "ecol_transactions_bkp_axlq", id: false, force: :cascade do |t|
    t.integer  "id",                    limit: nil,                 null: false
    t.string   "status",                limit: 20,                  null: false
    t.string   "transfer_type",         limit: 4,                   null: false
    t.string   "transfer_unique_no",    limit: 64,                  null: false
    t.string   "transfer_status",       limit: 25,                  null: false
    t.datetime "transfer_timestamp",                                null: false
    t.string   "transfer_ccy",          limit: 5,                   null: false
    t.decimal  "transfer_amt",                                      null: false
    t.string   "rmtr_ref",              limit: 64
    t.string   "rmtr_full_name",                                    null: false
    t.string   "rmtr_address"
    t.string   "rmtr_account_type",     limit: 10
    t.string   "rmtr_account_no",       limit: 64,                  null: false
    t.string   "rmtr_account_ifsc",     limit: 20,                  null: false
    t.string   "bene_full_name"
    t.string   "bene_account_type",     limit: 10
    t.string   "bene_account_no",       limit: 64,                  null: false
    t.string   "bene_account_ifsc",     limit: 20,                  null: false
    t.string   "rmtr_to_bene_note"
    t.datetime "received_at",                                       null: false
    t.string   "customer_code",         limit: 15
    t.string   "customer_subcode",      limit: 28
    t.string   "remitter_code",         limit: 28
    t.datetime "validated_at"
    t.string   "validation_status",     limit: 50
    t.datetime "credited_at"
    t.string   "credit_ref",            limit: 64
    t.integer  "credit_attempt_no",                  precision: 38
    t.string   "rmtr_email_notify_ref", limit: 64
    t.string   "rmtr_sms_notify_ref",   limit: 2000
    t.datetime "settled_at"
    t.string   "settle_status",         limit: 50
    t.string   "settle_ref",            limit: 64
    t.integer  "settle_attempt_no",                  precision: 38
    t.datetime "fault_at"
    t.string   "fault_code",            limit: 50
    t.string   "fault_reason",          limit: 1000
    t.datetime "created_at",                                        null: false
    t.datetime "updated_at",                                        null: false
    t.string   "invoice_no",            limit: 28
    t.datetime "validate_attempt_at"
    t.datetime "credit_attempt_at"
    t.datetime "returned_at"
    t.string   "return_ref",            limit: 64
    t.datetime "return_attempt_at"
    t.integer  "return_attempt_no",     limit: 8,    precision: 8
    t.datetime "settle_attempt_at"
    t.string   "bene_full_address"
    t.string   "validation_result",     limit: 1000
    t.string   "credit_acct_no",        limit: 25
    t.string   "settle_result",         limit: 1000
    t.integer  "ecol_remitter_id",      limit: nil
    t.string   "pending_approval"
    t.integer  "notify_attempt_no",     limit: 8,    precision: 8
    t.datetime "notify_attempt_at"
    t.datetime "notified_at"
    t.string   "notify_status",         limit: 50
    t.string   "notify_result",         limit: 1000
    t.integer  "validate_attempt_no",                precision: 38
    t.string   "return_req_ref",        limit: 64
    t.string   "settle_req_ref",        limit: 64
    t.string   "credit_req_ref",        limit: 64
    t.string   "validation_ref",        limit: 50
    t.string   "return_transfer_type",  limit: 10
    t.integer  "approver_id",           limit: nil
    t.string   "remarks"
    t.string   "decision_by",           limit: 1
    t.integer  "va_txn_id",             limit: nil
    t.string   "va_transfer_status",    limit: 20
  end

  create_table "ecol_transactions_bkp_quhi", id: false, force: :cascade do |t|
    t.integer  "id",                    limit: nil,                 null: false
    t.string   "status",                limit: 20,                  null: false
    t.string   "transfer_type",         limit: 4,                   null: false
    t.string   "transfer_unique_no",    limit: 64,                  null: false
    t.string   "transfer_status",       limit: 25,                  null: false
    t.datetime "transfer_timestamp",                                null: false
    t.string   "transfer_ccy",          limit: 5,                   null: false
    t.decimal  "transfer_amt",                                      null: false
    t.string   "rmtr_ref",              limit: 64
    t.string   "rmtr_full_name",                                    null: false
    t.string   "rmtr_address"
    t.string   "rmtr_account_type",     limit: 10
    t.string   "rmtr_account_no",       limit: 64,                  null: false
    t.string   "rmtr_account_ifsc",     limit: 20,                  null: false
    t.string   "bene_full_name"
    t.string   "bene_account_type",     limit: 10
    t.string   "bene_account_no",       limit: 64,                  null: false
    t.string   "bene_account_ifsc",     limit: 20,                  null: false
    t.string   "rmtr_to_bene_note"
    t.datetime "received_at",                                       null: false
    t.string   "customer_code",         limit: 15
    t.string   "customer_subcode",      limit: 28
    t.string   "remitter_code",         limit: 28
    t.datetime "validated_at"
    t.string   "validation_status",     limit: 50
    t.datetime "credited_at"
    t.string   "credit_ref",            limit: 64
    t.integer  "credit_attempt_no",                  precision: 38
    t.string   "rmtr_email_notify_ref", limit: 64
    t.string   "rmtr_sms_notify_ref",   limit: 2000
    t.datetime "settled_at"
    t.string   "settle_status",         limit: 50
    t.string   "settle_ref",            limit: 64
    t.integer  "settle_attempt_no",                  precision: 38
    t.datetime "fault_at"
    t.string   "fault_code",            limit: 50
    t.string   "fault_reason",          limit: 1000
    t.datetime "created_at",                                        null: false
    t.datetime "updated_at",                                        null: false
    t.string   "invoice_no",            limit: 28
    t.datetime "validate_attempt_at"
    t.datetime "credit_attempt_at"
    t.datetime "returned_at"
    t.string   "return_ref",            limit: 64
    t.datetime "return_attempt_at"
    t.integer  "return_attempt_no",     limit: 8,    precision: 8
    t.datetime "settle_attempt_at"
    t.string   "bene_full_address"
    t.string   "validation_result",     limit: 1000
    t.string   "credit_acct_no",        limit: 25
    t.string   "settle_result",         limit: 1000
    t.integer  "ecol_remitter_id",      limit: nil
    t.string   "pending_approval"
    t.integer  "notify_attempt_no",     limit: 8,    precision: 8
    t.datetime "notify_attempt_at"
    t.datetime "notified_at"
    t.string   "notify_status",         limit: 50
    t.string   "notify_result",         limit: 1000
    t.integer  "validate_attempt_no",                precision: 38
    t.string   "return_req_ref",        limit: 64
    t.string   "settle_req_ref",        limit: 64
    t.string   "credit_req_ref",        limit: 64
    t.string   "validation_ref",        limit: 50
    t.string   "return_transfer_type",  limit: 10
    t.integer  "approver_id",           limit: nil
    t.string   "remarks"
    t.string   "decision_by",           limit: 1
    t.integer  "va_txn_id",             limit: nil
    t.string   "va_transfer_status",    limit: 20
  end

  create_table "ecol_va_accounts", force: :cascade do |t|
    t.string   "account_no",      limit: 64,                              null: false
    t.string   "customer_code",   limit: 20,                              null: false
    t.decimal  "account_balance",                           default: 0.0, null: false
    t.decimal  "hold_amount",                               default: 0.0, null: false
    t.string   "app_id",          limit: 50,                              null: false
    t.string   "created_by",      limit: 20
    t.string   "updated_by",      limit: 20
    t.datetime "created_at",                                              null: false
    t.datetime "updated_at",                                              null: false
    t.integer  "lock_version",               precision: 38, default: 0,   null: false
  end

  add_index "ecol_va_accounts", ["account_no", "customer_code"], name: "ecol_va_accounts_01", unique: true

  create_table "ecol_va_audit_steps", force: :cascade do |t|
    t.string   "ecol_auditable_type",                             null: false
    t.integer  "ecol_auditable_id",   limit: nil,                 null: false
    t.integer  "step_no",                          precision: 38, null: false
    t.integer  "attempt_no",                       precision: 38, null: false
    t.string   "step_name",           limit: 100,                 null: false
    t.string   "status_code",         limit: 25,                  null: false
    t.string   "fault_code",          limit: 50
    t.string   "fault_subcode",       limit: 50
    t.string   "fault_reason",        limit: 1000
    t.string   "req_reference"
    t.datetime "req_timestamp"
    t.string   "rep_reference"
    t.datetime "rep_timestamp"
    t.text     "req_bitstream"
    t.text     "rep_bitstream"
    t.text     "fault_bitstream"
    t.string   "remote_host",         limit: 500
    t.string   "req_uri",             limit: 500
    t.text     "req_header"
    t.text     "rep_header"
  end

  add_index "ecol_va_audit_steps", ["ecol_auditable_type", "ecol_auditable_id", "step_no", "attempt_no"], name: "ecol_va_audit_steps_01", unique: true

  create_table "ecol_va_earmarks", force: :cascade do |t|
    t.string   "account_no",    limit: 64,               null: false
    t.string   "hold_no",       limit: 64,               null: false
    t.decimal  "hold_amount",              default: 0.0, null: false
    t.string   "hold_desc",                              null: false
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.string   "customer_code",                          null: false
  end

  add_index "ecol_va_earmarks", ["account_no", "hold_no", "customer_code"], name: "ecol_va_earmarks_01", unique: true

  create_table "ecol_va_memo_txns", force: :cascade do |t|
    t.string   "reference_no",                                                null: false
    t.string   "account_no",         limit: 64,                               null: false
    t.decimal  "txn_amount",                                                  null: false
    t.string   "hold_no",            limit: 64
    t.string   "txn_type",           limit: 50,                               null: false
    t.string   "txn_desc"
    t.decimal  "hold_amount"
    t.string   "customer_code",      limit: 20,                               null: false
    t.integer  "ecol_va_txn_id",     limit: nil
    t.integer  "ecol_va_earmark_id", limit: nil
    t.datetime "created_at",                                                  null: false
    t.datetime "updated_at",                                                  null: false
    t.string   "created_by",         limit: 20
    t.string   "updated_by",         limit: 20
    t.integer  "lock_version",                   precision: 38, default: 0,   null: false
    t.string   "last_action",        limit: 1,                  default: "C", null: false
    t.string   "approval_status",    limit: 1,                  default: "U", null: false
    t.integer  "approved_version",               precision: 38
    t.integer  "approved_id",        limit: nil
  end

  add_index "ecol_va_memo_txns", ["reference_no", "approval_status"], name: "ecol_va_memo_txns_01", unique: true

  create_table "ecol_va_transfers", force: :cascade do |t|
    t.string   "account_no",                limit: 64,   null: false
    t.string   "external_req_no",           limit: 64,   null: false
    t.datetime "req_timestamp",                          null: false
    t.string   "hold_no",                   limit: 64,   null: false
    t.string   "transfer_type"
    t.decimal  "transfer_amount",                        null: false
    t.string   "bene_account_no",           limit: 64,   null: false
    t.string   "bene_account_ifsc",         limit: 20,   null: false
    t.string   "bene_account_name",                      null: false
    t.string   "rmtr_bene_note"
    t.string   "status_code",               limit: 32,   null: false
    t.datetime "picked_at"
    t.string   "bank_ref_no",               limit: 64
    t.datetime "reconciled_at"
    t.datetime "returned_at"
    t.integer  "ecol_va_txn_id",            limit: nil
    t.string   "customer_id",               limit: 50
    t.string   "fault_code",                limit: 50
    t.string   "fault_subcode",             limit: 50
    t.string   "fault_reason",              limit: 1000
    t.string   "app_id",                    limit: 20
    t.string   "rev_unblock_status",        limit: 32
    t.integer  "rev_unblock_va_txn_id",     limit: nil
    t.string   "rev_unblock_fault_code",    limit: 50
    t.string   "rev_unblock_fault_subcode", limit: 50
    t.string   "rev_unblock_fault_reason",  limit: 1000
    t.string   "debit_account_no",                       null: false
    t.string   "customer_code",                          null: false
  end

  add_index "ecol_va_transfers", ["external_req_no"], name: "ecol_va_transfers_01", unique: true

  create_table "ecol_va_txns", force: :cascade do |t|
    t.string   "account_no",      limit: 64,  null: false
    t.string   "hold_no",         limit: 64
    t.string   "txn_type",        limit: 50,  null: false
    t.datetime "txn_timestamp",               null: false
    t.decimal  "txn_amount",                  null: false
    t.string   "txn_desc"
    t.decimal  "account_balance",             null: false
    t.decimal  "hold_amount",                 null: false
    t.string   "auditable_type",  limit: 50,  null: false
    t.integer  "auditable_id",    limit: nil, null: false
    t.string   "created_by",      limit: 20
    t.string   "approved_by",     limit: 20
    t.string   "customer_code",               null: false
  end

  add_index "ecol_va_txns", ["customer_code", "account_no", "hold_no", "txn_type", "txn_timestamp"], name: "ecol_va_txns_01"

  create_table "ecol_vacd_incoming_files", force: :cascade do |t|
    t.string "file_name", limit: 100
  end

  add_index "ecol_vacd_incoming_files", ["file_name"], name: "ecol_vacd_incoming_files_01", unique: true

  create_table "ecol_vacd_incoming_records", force: :cascade do |t|
    t.integer "incoming_file_record_id", limit: nil, null: false
    t.string  "file_name",               limit: 100, null: false
    t.string  "account_no",              limit: 64,  null: false
    t.decimal "txn_amount",                          null: false
    t.string  "txn_type",                limit: 50,  null: false
    t.string  "txn_desc"
  end

  add_index "ecol_vacd_incoming_records", ["incoming_file_record_id", "file_name"], name: "ecol_vacd_incoming_records_01", unique: true

  create_table "ecol_validations", force: :cascade do |t|
    t.integer  "ecol_transaction_id", limit: nil
    t.string   "ecol_customer_id"
    t.string   "status_code",         limit: 10
    t.text     "req_bitstream"
    t.text     "rep_bitstream"
    t.datetime "req_timestamp"
    t.datetime "datetime"
    t.datetime "rep_timestamp"
    t.string   "fault_code"
    t.string   "string"
    t.string   "fault_reason"
  end

  create_table "email_setups", force: :cascade do |t|
    t.string   "service_name"
    t.string   "app_id"
    t.string   "app_code"
    t.string   "customer_id"
    t.string   "email1"
    t.string   "email2"
    t.string   "email3"
    t.string   "email4"
    t.string   "email5"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "esb_configs", force: :cascade do |t|
    t.string   "key"
    t.string   "value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "external_organisations", force: :cascade do |t|
    t.string    "name",                 limit: 100,                               null: false
    t.integer   "external_users_count",             precision: 38, default: 0,    null: false
    t.boolean   "active",               limit: nil,                default: true, null: false
    t.integer   "lock_version",                     precision: 38, default: 0,    null: false
    t.integer   "created_by",                       precision: 38
    t.integer   "updated_by",                       precision: 38
    t.timestamp "created_at",           limit: 6,                                 null: false
    t.timestamp "updated_at",           limit: 6,                                 null: false
    t.string    "username_suffix",      limit: 3,                                 null: false
    t.string    "approval_status",      limit: 1,                  default: "U",  null: false
    t.string    "last_action",          limit: 1,                  default: "C"
    t.integer   "approved_id",          limit: nil
    t.integer   "approved_version",                 precision: 38
  end

  add_index "external_organisations", ["name", "approval_status"], name: "external_organisations_02", unique: true
  add_index "external_organisations", ["username_suffix", "approval_status"], name: "external_organisations_01", unique: true

  create_table "fm_audit_steps", force: :cascade do |t|
    t.string    "auditable_type",                              null: false
    t.integer   "auditable_id",    limit: nil,                 null: false
    t.integer   "step_no",                      precision: 38, null: false
    t.integer   "attempt_no",                   precision: 38, null: false
    t.string    "step_name",       limit: 100,                 null: false
    t.string    "status_code",     limit: 25
    t.string    "fault_code",      limit: 50
    t.string    "fault_subcode",   limit: 50
    t.string    "fault_reason",    limit: 1000
    t.string    "req_reference"
    t.timestamp "req_timestamp",   limit: 6
    t.string    "rep_reference"
    t.timestamp "rep_timestamp",   limit: 6
    t.datetime  "reconciled_at"
    t.text      "req_bitstream"
    t.text      "rep_bitstream"
    t.text      "fault_bitstream"
  end

  add_index "fm_audit_steps", ["auditable_type", "auditable_id", "step_no", "attempt_no"], name: "uk_fm_audit_steps", unique: true

  create_table "fm_output_files", force: :cascade do |t|
    t.integer  "incoming_file_id", limit: nil,                 null: false
    t.string   "step_name",        limit: 50,                  null: false
    t.string   "status_code",      limit: 50,                  null: false
    t.string   "file_name",        limit: 100
    t.string   "file_path"
    t.datetime "started_at",                                   null: false
    t.datetime "ended_at"
    t.string   "fault_code",       limit: 50
    t.string   "fault_subcode",    limit: 50
    t.string   "fault_reason",     limit: 1000
    t.text     "fault_bitstream"
    t.integer  "size_in_bytes",                 precision: 38
  end

  add_index "fm_output_files", ["incoming_file_id", "step_name", "status_code"], name: "fm_output_files_01", unique: true

  create_table "fp_aud_log_bkp_180101to181225", id: false, force: :cascade do |t|
    t.integer "id",                limit: nil, null: false
    t.integer "fp_transaction_id", limit: nil, null: false
    t.text    "req_bitstream",                 null: false
    t.text    "rep_bitstream"
    t.text    "fault_bitstream"
  end

  create_table "fp_aud_log_bkp_180701to181231", id: false, force: :cascade do |t|
    t.integer "id",                limit: nil, null: false
    t.integer "fp_transaction_id", limit: nil, null: false
    t.text    "req_bitstream",                 null: false
    t.text    "rep_bitstream"
    t.text    "fault_bitstream"
  end

  create_table "fp_aud_log_bkp_180801to181226", id: false, force: :cascade do |t|
    t.integer "id",                limit: nil, null: false
    t.integer "fp_transaction_id", limit: nil, null: false
    t.text    "req_bitstream",                 null: false
    t.text    "rep_bitstream"
    t.text    "fault_bitstream"
  end

  create_table "fp_aud_log_bkp_180910to181231", id: false, force: :cascade do |t|
    t.integer "id",                limit: nil, null: false
    t.integer "fp_transaction_id", limit: nil, null: false
    t.text    "req_bitstream",                 null: false
    t.text    "rep_bitstream"
    t.text    "fault_bitstream"
  end

  create_table "fp_aud_log_bkp_181101to181224", id: false, force: :cascade do |t|
    t.integer "id",                limit: nil, null: false
    t.integer "fp_transaction_id", limit: nil, null: false
    t.text    "req_bitstream",                 null: false
    t.text    "rep_bitstream"
    t.text    "fault_bitstream"
  end

  create_table "fp_aud_log_bkp_181101to181231", id: false, force: :cascade do |t|
    t.integer "id",                limit: nil, null: false
    t.integer "fp_transaction_id", limit: nil, null: false
    t.text    "req_bitstream",                 null: false
    t.text    "rep_bitstream"
    t.text    "fault_bitstream"
  end

  create_table "fp_aud_log_bkp_181205to181224", id: false, force: :cascade do |t|
    t.integer "id",                limit: nil, null: false
    t.integer "fp_transaction_id", limit: nil, null: false
    t.text    "req_bitstream",                 null: false
    t.text    "rep_bitstream"
    t.text    "fault_bitstream"
  end

  create_table "fp_aud_log_bkp_181212to181231", id: false, force: :cascade do |t|
    t.integer "id",                limit: nil, null: false
    t.integer "fp_transaction_id", limit: nil, null: false
    t.text    "req_bitstream",                 null: false
    t.text    "rep_bitstream"
    t.text    "fault_bitstream"
  end

  create_table "fp_aud_log_bkp_181226to181225", id: false, force: :cascade do |t|
    t.integer "id",                limit: nil, null: false
    t.integer "fp_transaction_id", limit: nil, null: false
    t.text    "req_bitstream",                 null: false
    t.text    "rep_bitstream"
    t.text    "fault_bitstream"
  end

  create_table "fp_audit_logs", force: :cascade do |t|
    t.integer "fp_transaction_id", limit: nil, null: false
    t.text    "req_bitstream",                 null: false
    t.text    "rep_bitstream"
    t.text    "fault_bitstream"
  end

  add_index "fp_audit_logs", ["fp_transaction_id"], name: "fp_audit_logs_index", unique: true

  create_table "fp_auth_rules", force: :cascade do |t|
    t.string   "username",                                                   null: false
    t.string   "operation_name",   limit: 4000,                              null: false
    t.string   "is_enabled",       limit: 1,                   default: "f", null: false
    t.integer  "lock_version",                  precision: 38,               null: false
    t.string   "approval_status",  limit: 1,                   default: "U", null: false
    t.string   "last_action",      limit: 1
    t.integer  "approved_version",              precision: 38
    t.integer  "approved_id",      limit: nil
    t.string   "created_by",       limit: 20
    t.string   "updated_by",       limit: 20
    t.datetime "created_at",                                                 null: false
    t.datetime "updated_at",                                                 null: false
    t.string   "source_ips",       limit: 4000
    t.string   "any_source_ip",    limit: 1,                   default: "f", null: false
    t.string   "system_name",                                                null: false
    t.string   "service_name"
    t.string   "all_operations",   limit: 1
  end

  add_index "fp_auth_rules", ["username", "approval_status", "system_name", "service_name"], name: "fp_auth_rules_01", unique: true

  create_table "fp_fcc_audit_logs", force: :cascade do |t|
    t.integer "fp_fcc_transaction_id", limit: nil, null: false
    t.text    "req_bitstream"
    t.text    "rep_bitstream"
    t.text    "fault_bitstream"
  end

  add_index "fp_fcc_audit_logs", ["fp_fcc_transaction_id"], name: "fp_fcc_audit_logs_01", unique: true

  create_table "fp_fcc_transactions", force: :cascade do |t|
    t.string   "server_name"
    t.string   "server_port"
    t.string   "service_name"
    t.string   "operation_name"
    t.string   "service_url"
    t.string   "remote_address"
    t.string   "remote_host"
    t.string   "http_scheme",      limit: 5
    t.string   "http_method",      limit: 10
    t.integer  "content_length",                precision: 38
    t.datetime "req_timestamp"
    t.integer  "http_status_code",              precision: 38
    t.string   "http_status_line"
    t.string   "ex_error_code"
    t.string   "ex_error_msg"
    t.datetime "rep_timestamp"
    t.string   "fault_code",       limit: 50
    t.string   "fault_reason",     limit: 1000
  end

  create_table "fp_operations", force: :cascade do |t|
    t.string   "operation_name",                                            null: false
    t.integer  "lock_version",                 precision: 38,               null: false
    t.string   "approval_status",  limit: 1,                  default: "U", null: false
    t.string   "last_action",      limit: 1
    t.integer  "approved_version",             precision: 38
    t.integer  "approved_id",      limit: nil
    t.string   "created_by",       limit: 20
    t.string   "updated_by",       limit: 20
    t.datetime "created_at",                                                null: false
    t.datetime "updated_at",                                                null: false
    t.string   "system_name",                                               null: false
    t.string   "service_name"
  end

  add_index "fp_operations", ["operation_name", "approval_status", "system_name", "service_name"], name: "fp_operations_01", unique: true

  create_table "fp_services", force: :cascade do |t|
    t.string   "system_name",      limit: 50,                               null: false
    t.string   "service_name",                                              null: false
    t.string   "service_url",      limit: 100,                              null: false
    t.string   "is_enabled",       limit: 1,                  default: "f", null: false
    t.datetime "created_at",                                                null: false
    t.datetime "updated_at",                                                null: false
    t.string   "created_by",       limit: 20
    t.string   "updated_by",       limit: 20
    t.integer  "lock_version",                 precision: 38, default: 0,   null: false
    t.string   "last_action",      limit: 1,                  default: "C", null: false
    t.string   "approval_status",  limit: 1,                  default: "U", null: false
    t.integer  "approved_version",             precision: 38
    t.integer  "approved_id",      limit: nil
  end

  add_index "fp_services", ["system_name", "service_name", "approval_status"], name: "fp_services_01", unique: true

  create_table "fp_tra_bkp_181101to181225", id: false, force: :cascade do |t|
    t.integer  "id",                limit: nil,                 null: false
    t.string   "server_name"
    t.string   "server_port"
    t.string   "service_name"
    t.string   "operation_name"
    t.string   "remote_address"
    t.string   "remote_host"
    t.string   "http_scheme",       limit: 5
    t.string   "http_method",       limit: 10
    t.integer  "content_length",                 precision: 38
    t.string   "ctx_user_id"
    t.string   "ctx_channel"
    t.string   "ctx_usr_ref_no"
    t.string   "ctx_service_code"
    t.string   "ext_unique_ref_id"
    t.datetime "req_timestamp",                                 null: false
    t.integer  "http_status_code",               precision: 38
    t.string   "http_status_line"
    t.string   "external_ref_no"
    t.string   "ex_error_code"
    t.string   "ex_error_msg"
    t.datetime "rep_timestamp"
    t.string   "fault_code",        limit: 50
    t.string   "fault_reason",      limit: 1000
  end

  create_table "fp_tra_bkp_181201to181231", id: false, force: :cascade do |t|
    t.integer  "id",                limit: nil,                 null: false
    t.string   "server_name"
    t.string   "server_port"
    t.string   "service_name"
    t.string   "operation_name"
    t.string   "remote_address"
    t.string   "remote_host"
    t.string   "http_scheme",       limit: 5
    t.string   "http_method",       limit: 10
    t.integer  "content_length",                 precision: 38
    t.string   "ctx_user_id"
    t.string   "ctx_channel"
    t.string   "ctx_usr_ref_no"
    t.string   "ctx_service_code"
    t.string   "ext_unique_ref_id"
    t.datetime "req_timestamp",                                 null: false
    t.integer  "http_status_code",               precision: 38
    t.string   "http_status_line"
    t.string   "external_ref_no"
    t.string   "ex_error_code"
    t.string   "ex_error_msg"
    t.datetime "rep_timestamp"
    t.string   "fault_code",        limit: 50
    t.string   "fault_reason",      limit: 1000
  end

  create_table "fp_trans_bkp_180903to181231", id: false, force: :cascade do |t|
    t.integer  "id",                limit: nil,                 null: false
    t.string   "server_name"
    t.string   "server_port"
    t.string   "service_name"
    t.string   "operation_name"
    t.string   "remote_address"
    t.string   "remote_host"
    t.string   "http_scheme",       limit: 5
    t.string   "http_method",       limit: 10
    t.integer  "content_length",                 precision: 38
    t.string   "ctx_user_id"
    t.string   "ctx_channel"
    t.string   "ctx_usr_ref_no"
    t.string   "ctx_service_code"
    t.string   "ext_unique_ref_id"
    t.datetime "req_timestamp",                                 null: false
    t.integer  "http_status_code",               precision: 38
    t.string   "http_status_line"
    t.string   "external_ref_no"
    t.string   "ex_error_code"
    t.string   "ex_error_msg"
    t.datetime "rep_timestamp"
    t.string   "fault_code",        limit: 50
    t.string   "fault_reason",      limit: 1000
  end

  create_table "fp_trans_bkp_180904to181231", id: false, force: :cascade do |t|
    t.integer  "id",                limit: nil,                 null: false
    t.string   "server_name"
    t.string   "server_port"
    t.string   "service_name"
    t.string   "operation_name"
    t.string   "remote_address"
    t.string   "remote_host"
    t.string   "http_scheme",       limit: 5
    t.string   "http_method",       limit: 10
    t.integer  "content_length",                 precision: 38
    t.string   "ctx_user_id"
    t.string   "ctx_channel"
    t.string   "ctx_usr_ref_no"
    t.string   "ctx_service_code"
    t.string   "ext_unique_ref_id"
    t.datetime "req_timestamp",                                 null: false
    t.integer  "http_status_code",               precision: 38
    t.string   "http_status_line"
    t.string   "external_ref_no"
    t.string   "ex_error_code"
    t.string   "ex_error_msg"
    t.datetime "rep_timestamp"
    t.string   "fault_code",        limit: 50
    t.string   "fault_reason",      limit: 1000
  end

  create_table "fp_trans_bkp_181101to181231", id: false, force: :cascade do |t|
    t.integer  "id",                limit: nil,                 null: false
    t.string   "server_name"
    t.string   "server_port"
    t.string   "service_name"
    t.string   "operation_name"
    t.string   "remote_address"
    t.string   "remote_host"
    t.string   "http_scheme",       limit: 5
    t.string   "http_method",       limit: 10
    t.integer  "content_length",                 precision: 38
    t.string   "ctx_user_id"
    t.string   "ctx_channel"
    t.string   "ctx_usr_ref_no"
    t.string   "ctx_service_code"
    t.string   "ext_unique_ref_id"
    t.datetime "req_timestamp",                                 null: false
    t.integer  "http_status_code",               precision: 38
    t.string   "http_status_line"
    t.string   "external_ref_no"
    t.string   "ex_error_code"
    t.string   "ex_error_msg"
    t.datetime "rep_timestamp"
    t.string   "fault_code",        limit: 50
    t.string   "fault_reason",      limit: 1000
  end

  create_table "fp_trans_bkp_181220to181231", id: false, force: :cascade do |t|
    t.integer  "id",                limit: nil,                 null: false
    t.string   "server_name"
    t.string   "server_port"
    t.string   "service_name"
    t.string   "operation_name"
    t.string   "remote_address"
    t.string   "remote_host"
    t.string   "http_scheme",       limit: 5
    t.string   "http_method",       limit: 10
    t.integer  "content_length",                 precision: 38
    t.string   "ctx_user_id"
    t.string   "ctx_channel"
    t.string   "ctx_usr_ref_no"
    t.string   "ctx_service_code"
    t.string   "ext_unique_ref_id"
    t.datetime "req_timestamp",                                 null: false
    t.integer  "http_status_code",               precision: 38
    t.string   "http_status_line"
    t.string   "external_ref_no"
    t.string   "ex_error_code"
    t.string   "ex_error_msg"
    t.datetime "rep_timestamp"
    t.string   "fault_code",        limit: 50
    t.string   "fault_reason",      limit: 1000
  end

  create_table "fp_trans_bkp_190101to190131", id: false, force: :cascade do |t|
    t.integer  "id",                limit: nil,                 null: false
    t.string   "server_name"
    t.string   "server_port"
    t.string   "service_name"
    t.string   "operation_name"
    t.string   "remote_address"
    t.string   "remote_host"
    t.string   "http_scheme",       limit: 5
    t.string   "http_method",       limit: 10
    t.integer  "content_length",                 precision: 38
    t.string   "ctx_user_id"
    t.string   "ctx_channel"
    t.string   "ctx_usr_ref_no"
    t.string   "ctx_service_code"
    t.string   "ext_unique_ref_id"
    t.datetime "req_timestamp",                                 null: false
    t.integer  "http_status_code",               precision: 38
    t.string   "http_status_line"
    t.string   "external_ref_no"
    t.string   "ex_error_code"
    t.string   "ex_error_msg"
    t.datetime "rep_timestamp"
    t.string   "fault_code",        limit: 50
    t.string   "fault_reason",      limit: 1000
  end

  create_table "fp_transactions", force: :cascade do |t|
    t.string   "server_name"
    t.string   "server_port"
    t.string   "service_name"
    t.string   "operation_name"
    t.string   "remote_address"
    t.string   "remote_host"
    t.string   "http_scheme",       limit: 5
    t.string   "http_method",       limit: 10
    t.integer  "content_length",                 precision: 38
    t.string   "ctx_user_id"
    t.string   "ctx_channel"
    t.string   "ctx_usr_ref_no"
    t.string   "ctx_service_code"
    t.string   "ext_unique_ref_id"
    t.datetime "req_timestamp",                                 null: false
    t.integer  "http_status_code",               precision: 38
    t.string   "http_status_line"
    t.string   "external_ref_no"
    t.string   "ex_error_code"
    t.string   "ex_error_msg"
    t.datetime "rep_timestamp"
    t.string   "fault_code",        limit: 50
    t.string   "fault_reason",      limit: 1000
  end

  create_table "fp_unapproved_records", force: :cascade do |t|
    t.integer  "fp_approvable_id",   limit: nil
    t.string   "fp_approvable_type"
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
  end

  create_table "fr_r01_incoming_files", force: :cascade do |t|
    t.string "file_name", limit: 100
  end

  add_index "fr_r01_incoming_files", ["file_name"], name: "fr_r01_incoming_files_01", unique: true

  create_table "fr_r01_incoming_records", force: :cascade do |t|
    t.integer "incoming_file_record_id", limit: nil
    t.string  "file_name",               limit: 100
    t.string  "account_no",              limit: 100
    t.decimal "available_balance"
    t.decimal "onhold_amount"
    t.decimal "sweepin_balance"
    t.decimal "overdraft_limit"
    t.decimal "total_balance"
    t.string  "customer_name"
  end

  add_index "fr_r01_incoming_records", ["incoming_file_record_id", "file_name"], name: "fr_r01_incoming_records_01", unique: true

  create_table "ft_apbs_incoming_files", force: :cascade do |t|
    t.string "file_name", limit: 100
  end

  add_index "ft_apbs_incoming_files", ["file_name"], name: "ft_apbs_incoming_files_01", unique: true

  create_table "ft_apbs_incoming_records", force: :cascade do |t|
    t.integer "incoming_file_record_id", limit: nil
    t.string  "file_name",               limit: 100
    t.decimal "apbs_trans_code"
    t.string  "dest_bank_iin",           limit: 15
    t.string  "dest_acctype",            limit: 4
    t.string  "ledger_folio_num",        limit: 6
    t.string  "bene_aadhar_num",         limit: 20
    t.string  "bene_acct_name",          limit: 50
    t.string  "sponser_bank_iin",        limit: 15
    t.string  "user_num",                limit: 10
    t.string  "user_name",               limit: 30
    t.string  "user_credit_ref",         limit: 20
    t.decimal "amount"
    t.string  "item_seq_num",            limit: 20
    t.string  "checksum",                limit: 20
    t.string  "success_flag",            limit: 1
    t.string  "filler",                  limit: 10
    t.string  "reason_code",             limit: 20
    t.string  "dest_bank_acctnum",       limit: 20
    t.string  "file_ref_no",             limit: 20
  end

  add_index "ft_apbs_incoming_records", ["incoming_file_record_id", "file_name"], name: "ft_apbs_incoming_records_01", unique: true

  create_table "ft_apbs_outgoing_files", force: :cascade do |t|
    t.string  "customer_id",   limit: 15
    t.integer "serial_no",                precision: 38
    t.date    "creation_date"
  end

  add_index "ft_apbs_outgoing_files", ["customer_id", "serial_no", "creation_date"], name: "ft_apbs_outgoing_files_01", unique: true

  create_table "ft_aud_log_180801to190124", id: false, force: :cascade do |t|
    t.integer "id",                limit: nil, null: false
    t.integer "funds_transfer_id", limit: nil
    t.text    "request_bitstream"
    t.text    "reply_bitstream"
  end

  create_table "ft_aud_log_181001to181231", id: false, force: :cascade do |t|
    t.integer "id",                limit: nil, null: false
    t.integer "funds_transfer_id", limit: nil
    t.text    "request_bitstream"
    t.text    "reply_bitstream"
  end

  create_table "ft_aud_log_bkp_180821to181227", id: false, force: :cascade do |t|
    t.integer "id",                limit: nil, null: false
    t.integer "funds_transfer_id", limit: nil
    t.text    "request_bitstream"
    t.text    "reply_bitstream"
  end

  create_table "ft_aud_log_bkp_181001to181130", id: false, force: :cascade do |t|
    t.integer "id",                limit: nil, null: false
    t.integer "funds_transfer_id", limit: nil
    t.text    "request_bitstream"
    t.text    "reply_bitstream"
  end

  create_table "ft_aud_log_bkp_181101to181231", id: false, force: :cascade do |t|
    t.integer "id",                limit: nil, null: false
    t.integer "funds_transfer_id", limit: nil
    t.text    "request_bitstream"
    t.text    "reply_bitstream"
  end

  create_table "ft_aud_log_bkp_181105to190122", id: false, force: :cascade do |t|
    t.integer "id",                limit: nil, null: false
    t.integer "funds_transfer_id", limit: nil
    t.text    "request_bitstream"
    t.text    "reply_bitstream"
  end

  create_table "ft_aud_log_bkp_181203to181231", id: false, force: :cascade do |t|
    t.integer "id",                limit: nil, null: false
    t.integer "funds_transfer_id", limit: nil
    t.text    "request_bitstream"
    t.text    "reply_bitstream"
  end

  create_table "ft_aud_log_bkp_181204to181231", id: false, force: :cascade do |t|
    t.integer "id",                limit: nil, null: false
    t.integer "funds_transfer_id", limit: nil
    t.text    "request_bitstream"
    t.text    "reply_bitstream"
  end

  create_table "ft_aud_ste_bkp_181001to181231", id: false, force: :cascade do |t|
    t.integer  "id",                limit: nil,                 null: false
    t.string   "ft_auditable_type",                             null: false
    t.integer  "ft_auditable_id",   limit: nil,                 null: false
    t.integer  "step_no",                        precision: 38, null: false
    t.integer  "attempt_no",                     precision: 38, null: false
    t.string   "step_name",         limit: 100,                 null: false
    t.string   "status_code",       limit: 30,                  null: false
    t.string   "fault_code"
    t.string   "fault_subcode",     limit: 50
    t.string   "fault_reason",      limit: 1000
    t.string   "req_reference"
    t.datetime "req_timestamp"
    t.string   "rep_reference"
    t.datetime "rep_timestamp"
    t.text     "req_bitstream"
    t.text     "rep_bitstream"
    t.text     "fault_bitstream"
    t.string   "remote_host",       limit: 500
    t.string   "req_uri",           limit: 500
    t.text     "req_header"
    t.text     "rep_header"
  end

  create_table "ft_aud_ste_bkp_181101to181231", id: false, force: :cascade do |t|
    t.integer  "id",                limit: nil,                 null: false
    t.string   "ft_auditable_type",                             null: false
    t.integer  "ft_auditable_id",   limit: nil,                 null: false
    t.integer  "step_no",                        precision: 38, null: false
    t.integer  "attempt_no",                     precision: 38, null: false
    t.string   "step_name",         limit: 100,                 null: false
    t.string   "status_code",       limit: 30,                  null: false
    t.string   "fault_code"
    t.string   "fault_subcode",     limit: 50
    t.string   "fault_reason",      limit: 1000
    t.string   "req_reference"
    t.datetime "req_timestamp"
    t.string   "rep_reference"
    t.datetime "rep_timestamp"
    t.text     "req_bitstream"
    t.text     "rep_bitstream"
    t.text     "fault_bitstream"
    t.string   "remote_host",       limit: 500
    t.string   "req_uri",           limit: 500
    t.text     "req_header"
    t.text     "rep_header"
  end

  create_table "ft_aud_step_bkp_180101to181231", id: false, force: :cascade do |t|
    t.integer  "id",                limit: nil,                 null: false
    t.string   "ft_auditable_type",                             null: false
    t.integer  "ft_auditable_id",   limit: nil,                 null: false
    t.integer  "step_no",                        precision: 38, null: false
    t.integer  "attempt_no",                     precision: 38, null: false
    t.string   "step_name",         limit: 100,                 null: false
    t.string   "status_code",       limit: 30,                  null: false
    t.string   "fault_code"
    t.string   "fault_subcode",     limit: 50
    t.string   "fault_reason",      limit: 1000
    t.string   "req_reference"
    t.datetime "req_timestamp"
    t.string   "rep_reference"
    t.datetime "rep_timestamp"
    t.text     "req_bitstream"
    t.text     "rep_bitstream"
    t.text     "fault_bitstream"
    t.string   "remote_host",       limit: 500
    t.string   "req_uri",           limit: 500
    t.text     "req_header"
    t.text     "rep_header"
  end

  create_table "ft_aud_step_bkp_181102to181231", id: false, force: :cascade do |t|
    t.integer  "id",                limit: nil,                 null: false
    t.string   "ft_auditable_type",                             null: false
    t.integer  "ft_auditable_id",   limit: nil,                 null: false
    t.integer  "step_no",                        precision: 38, null: false
    t.integer  "attempt_no",                     precision: 38, null: false
    t.string   "step_name",         limit: 100,                 null: false
    t.string   "status_code",       limit: 30,                  null: false
    t.string   "fault_code"
    t.string   "fault_subcode",     limit: 50
    t.string   "fault_reason",      limit: 1000
    t.string   "req_reference"
    t.datetime "req_timestamp"
    t.string   "rep_reference"
    t.datetime "rep_timestamp"
    t.text     "req_bitstream"
    t.text     "rep_bitstream"
    t.text     "fault_bitstream"
    t.string   "remote_host",       limit: 500
    t.string   "req_uri",           limit: 500
    t.text     "req_header"
    t.text     "rep_header"
  end

  create_table "ft_aud_step_bkp_181201to181231", id: false, force: :cascade do |t|
    t.integer  "id",                limit: nil,                 null: false
    t.string   "ft_auditable_type",                             null: false
    t.integer  "ft_auditable_id",   limit: nil,                 null: false
    t.integer  "step_no",                        precision: 38, null: false
    t.integer  "attempt_no",                     precision: 38, null: false
    t.string   "step_name",         limit: 100,                 null: false
    t.string   "status_code",       limit: 30,                  null: false
    t.string   "fault_code"
    t.string   "fault_subcode",     limit: 50
    t.string   "fault_reason",      limit: 1000
    t.string   "req_reference"
    t.datetime "req_timestamp"
    t.string   "rep_reference"
    t.datetime "rep_timestamp"
    t.text     "req_bitstream"
    t.text     "rep_bitstream"
    t.text     "fault_bitstream"
    t.string   "remote_host",       limit: 500
    t.string   "req_uri",           limit: 500
    t.text     "req_header"
    t.text     "rep_header"
  end

  create_table "ft_aud_step_bkp_181211to181226", id: false, force: :cascade do |t|
    t.integer  "id",                limit: nil,                 null: false
    t.string   "ft_auditable_type",                             null: false
    t.integer  "ft_auditable_id",   limit: nil,                 null: false
    t.integer  "step_no",                        precision: 38, null: false
    t.integer  "attempt_no",                     precision: 38, null: false
    t.string   "step_name",         limit: 100,                 null: false
    t.string   "status_code",       limit: 30,                  null: false
    t.string   "fault_code"
    t.string   "fault_subcode",     limit: 50
    t.string   "fault_reason",      limit: 1000
    t.string   "req_reference"
    t.datetime "req_timestamp"
    t.string   "rep_reference"
    t.datetime "rep_timestamp"
    t.text     "req_bitstream"
    t.text     "rep_bitstream"
    t.text     "fault_bitstream"
    t.string   "remote_host",       limit: 500
    t.string   "req_uri",           limit: 500
    t.text     "req_header"
    t.text     "rep_header"
  end

  create_table "ft_aud_step_bkp_190101to190130", id: false, force: :cascade do |t|
    t.integer  "id",                limit: nil,                 null: false
    t.string   "ft_auditable_type",                             null: false
    t.integer  "ft_auditable_id",   limit: nil,                 null: false
    t.integer  "step_no",                        precision: 38, null: false
    t.integer  "attempt_no",                     precision: 38, null: false
    t.string   "step_name",         limit: 100,                 null: false
    t.string   "status_code",       limit: 30,                  null: false
    t.string   "fault_code"
    t.string   "fault_subcode",     limit: 50
    t.string   "fault_reason",      limit: 1000
    t.string   "req_reference"
    t.datetime "req_timestamp"
    t.string   "rep_reference"
    t.datetime "rep_timestamp"
    t.text     "req_bitstream"
    t.text     "rep_bitstream"
    t.text     "fault_bitstream"
    t.string   "remote_host",       limit: 500
    t.string   "req_uri",           limit: 500
    t.text     "req_header"
    t.text     "rep_header"
  end

  create_table "ft_aud_step_bkp_190101to190131", id: false, force: :cascade do |t|
    t.integer  "id",                limit: nil,                 null: false
    t.string   "ft_auditable_type",                             null: false
    t.integer  "ft_auditable_id",   limit: nil,                 null: false
    t.integer  "step_no",                        precision: 38, null: false
    t.integer  "attempt_no",                     precision: 38, null: false
    t.string   "step_name",         limit: 100,                 null: false
    t.string   "status_code",       limit: 30,                  null: false
    t.string   "fault_code"
    t.string   "fault_subcode",     limit: 50
    t.string   "fault_reason",      limit: 1000
    t.string   "req_reference"
    t.datetime "req_timestamp"
    t.string   "rep_reference"
    t.datetime "rep_timestamp"
    t.text     "req_bitstream"
    t.text     "rep_bitstream"
    t.text     "fault_bitstream"
    t.string   "remote_host",       limit: 500
    t.string   "req_uri",           limit: 500
    t.text     "req_header"
    t.text     "rep_header"
  end

  create_table "ft_aud_step_bkp_190131to191231", id: false, force: :cascade do |t|
    t.integer  "id",                limit: nil,                 null: false
    t.string   "ft_auditable_type",                             null: false
    t.integer  "ft_auditable_id",   limit: nil,                 null: false
    t.integer  "step_no",                        precision: 38, null: false
    t.integer  "attempt_no",                     precision: 38, null: false
    t.string   "step_name",         limit: 100,                 null: false
    t.string   "status_code",       limit: 30,                  null: false
    t.string   "fault_code"
    t.string   "fault_subcode",     limit: 50
    t.string   "fault_reason",      limit: 1000
    t.string   "req_reference"
    t.datetime "req_timestamp"
    t.string   "rep_reference"
    t.datetime "rep_timestamp"
    t.text     "req_bitstream"
    t.text     "rep_bitstream"
    t.text     "fault_bitstream"
    t.string   "remote_host",       limit: 500
    t.string   "req_uri",           limit: 500
    t.text     "req_header"
    t.text     "rep_header"
  end

  create_table "ft_audit_steps", force: :cascade do |t|
    t.string   "ft_auditable_type",                             null: false
    t.integer  "ft_auditable_id",   limit: nil,                 null: false
    t.integer  "step_no",                        precision: 38, null: false
    t.integer  "attempt_no",                     precision: 38, null: false
    t.string   "step_name",         limit: 100,                 null: false
    t.string   "status_code",       limit: 30,                  null: false
    t.string   "fault_code"
    t.string   "fault_subcode",     limit: 50
    t.string   "fault_reason",      limit: 1000
    t.string   "req_reference"
    t.datetime "req_timestamp"
    t.string   "rep_reference"
    t.datetime "rep_timestamp"
    t.text     "req_bitstream"
    t.text     "rep_bitstream"
    t.text     "fault_bitstream"
    t.string   "remote_host",       limit: 500
    t.string   "req_uri",           limit: 500
    t.text     "req_header"
    t.text     "rep_header"
  end

  add_index "ft_audit_steps", ["ft_auditable_type", "ft_auditable_id", "step_no", "attempt_no"], name: "uk_ft_audit_steps", unique: true

  create_table "ft_cust_accounts", force: :cascade do |t|
    t.string   "customer_id",      limit: 15,                               null: false
    t.string   "account_no",       limit: 20,                               null: false
    t.string   "is_enabled",       limit: 1,                                null: false
    t.datetime "created_at",                                                null: false
    t.datetime "updated_at",                                                null: false
    t.string   "created_by",       limit: 20
    t.string   "updated_by",       limit: 20
    t.integer  "lock_version",                 precision: 38, default: 0,   null: false
    t.string   "approval_status",  limit: 1,                  default: "U", null: false
    t.string   "last_action",      limit: 1,                  default: "C", null: false
    t.integer  "approved_version",             precision: 38
    t.integer  "approved_id",      limit: nil
  end

  add_index "ft_cust_accounts", ["customer_id", "account_no", "approval_status"], name: "ft_cust_accounts_01", unique: true

  create_table "ft_customers", force: :cascade do |t|
    t.string   "app_id",                    limit: 20,                                  null: false
    t.string   "name",                      limit: 100,                                 null: false
    t.integer  "low_balance_alert_at",                  precision: 38,                  null: false
    t.string   "identity_user_id",                                                      null: false
    t.string   "allow_neft",                limit: 1,                                   null: false
    t.string   "allow_imps",                limit: 1,                                   null: false
    t.string   "allow_rtgs",                limit: 1
    t.string   "string",                    limit: 15
    t.string   "enabled",                   limit: 1,                  default: "f",    null: false
    t.string   "is_retail",                 limit: 1
    t.string   "customer_id",               limit: 15
    t.string   "created_by",                limit: 20
    t.string   "updated_by",                limit: 20
    t.datetime "created_at",                                                            null: false
    t.datetime "updated_at",                                                            null: false
    t.integer  "lock_version",                          precision: 38, default: 0,      null: false
    t.string   "approval_status",           limit: 1,                  default: "U",    null: false
    t.string   "last_action",               limit: 1,                  default: "C",    null: false
    t.integer  "approved_version",                      precision: 38
    t.integer  "approved_id",               limit: nil
    t.string   "needs_purpose_code",        limit: 1
    t.string   "reply_with_bene_name",      limit: 1,                  default: "f"
    t.string   "allow_all_accounts",        limit: 1,                  default: "Y",    null: false
    t.string   "notify_app_code",           limit: 20
    t.string   "notify_on_status_change",   limit: 1,                  default: "f",    null: false
    t.string   "is_filetoapi_allowed",      limit: 1,                  default: "f"
    t.string   "allow_apbs",                limit: 1
    t.string   "apbs_user_no",              limit: 50
    t.string   "apbs_user_name",            limit: 50
    t.datetime "notification_sent_at"
    t.string   "force_saf",                 limit: 1,                  default: "f",    null: false
    t.string   "allowed_relns"
    t.string   "bene_backend",              limit: 50,                 default: "NETB", null: false
    t.string   "allow_upi",                 limit: 1,                  default: "f",    null: false
    t.string   "is_special_client",                                    default: "f"
    t.string   "is_payment",                                           default: "f"
    t.string   "funds_transfer_customers",                             default: "f"
    t.string   "beneficiary_sms_allowed",                              default: "f"
    t.string   "beneficiary_email_allowed",                            default: "f"
  end

  add_index "ft_customers", ["app_id", "customer_id", "approval_status"], name: "in_ft_customers_2", unique: true
  add_index "ft_customers", ["name"], name: "in_ft_customers_1"

  create_table "ft_incoming_files", force: :cascade do |t|
    t.string "file_name",     limit: 100
    t.string "customer_code", limit: 15
  end

  add_index "ft_incoming_files", ["file_name"], name: "ft_incoming_files_01", unique: true

  create_table "ft_incoming_records", force: :cascade do |t|
    t.integer "incoming_file_record_id", limit: nil
    t.string  "file_name",               limit: 100
    t.string  "req_version",             limit: 10
    t.string  "req_no",                  limit: 50
    t.string  "app_id",                  limit: 20
    t.string  "purpose_code",            limit: 20
    t.string  "customer_code",           limit: 50
    t.string  "debit_account_no",        limit: 20
    t.string  "bene_code",               limit: 50
    t.string  "bene_full_name",          limit: 100
    t.string  "bene_address1"
    t.string  "bene_address2"
    t.string  "bene_address3",           limit: 100
    t.string  "bene_postal_code",        limit: 100
    t.string  "bene_city",               limit: 100
    t.string  "bene_state",              limit: 100
    t.string  "bene_country",            limit: 100
    t.string  "bene_mobile_no",          limit: 10
    t.string  "bene_email_id",           limit: 100
    t.string  "bene_account_no",         limit: 20
    t.string  "bene_ifsc_code",          limit: 50
    t.string  "bene_mmid",               limit: 50
    t.string  "bene_mmid_mobile_no",     limit: 50
    t.string  "req_transfer_type",       limit: 4
    t.string  "transfer_ccy",            limit: 5
    t.decimal "transfer_amount"
    t.string  "rmtr_to_bene_note"
    t.string  "rep_version",             limit: 10
    t.string  "rep_no",                  limit: 50
    t.integer "rep_attempt_no",                      precision: 38
    t.string  "transfer_type",           limit: 4
    t.string  "low_balance_alert"
    t.string  "txn_status_code",         limit: 50
    t.string  "txn_status_subcode",      limit: 50
    t.string  "bank_ref_no",             limit: 50
    t.string  "bene_ref_no",             limit: 50
    t.string  "name_with_bene_bank"
    t.string  "aadhaar_no",              limit: 12
    t.string  "aadhaar_mobile_no",       limit: 20
  end

  add_index "ft_incoming_records", ["incoming_file_record_id"], name: "ft_incoming_records_01", unique: true

  create_table "ft_invoice_details", force: :cascade do |t|
    t.string   "req_no",                limit: 50,                  null: false
    t.string   "req_version",           limit: 10,                  null: false
    t.datetime "req_timestamp",                                     null: false
    t.string   "app_id",                limit: 20,                  null: false
    t.string   "customer_id",           limit: 15,                  null: false
    t.string   "customer_name",         limit: 50
    t.string   "status_code",           limit: 50,                  null: false
    t.integer  "attempt_no",                         precision: 38, null: false
    t.string   "supplier_code",         limit: 20
    t.string   "purchase_order_number", limit: 50
    t.string   "invoice_number",        limit: 50
    t.date     "invoice_date"
    t.decimal  "invoice_amount"
    t.decimal  "retained_amount"
    t.decimal  "deducted_amount"
    t.decimal  "tds_amount"
    t.decimal  "paid_amount"
    t.string   "payment_reference"
    t.string   "note"
    t.decimal  "cgst_amount"
    t.decimal  "sgst_amount"
    t.decimal  "igst_amount"
    t.string   "gstin",                 limit: 50
    t.string   "advice_file_name",      limit: 100
    t.string   "cnb_file_name",         limit: 100
    t.string   "advice_status",         limit: 50
    t.string   "advice_email_id",       limit: 100
    t.datetime "advice_sent_at"
    t.integer  "funds_transfer_id",     limit: nil
    t.string   "rep_no",                limit: 50
    t.string   "rep_version",           limit: 10
    t.datetime "rep_timestamp"
    t.string   "fault_code",            limit: 50
    t.string   "fault_reason",          limit: 1000
    t.string   "fault_subcode",         limit: 50
  end

  add_index "ft_invoice_details", ["customer_id", "req_no", "attempt_no"], name: "ft_invoice_details_01", unique: true

  create_table "ft_pending_advices", force: :cascade do |t|
    t.string   "broker_uuid",                      null: false
    t.integer  "ft_invoice_detail_id", limit: nil, null: false
    t.integer  "funds_transfer_id",    limit: nil
    t.datetime "created_at",                       null: false
  end

  add_index "ft_pending_advices", ["ft_invoice_detail_id", "funds_transfer_id"], name: "ft_pending_advices_01", unique: true

  create_table "ft_pending_confirmations", force: :cascade do |t|
    t.string   "broker_uuid",                   null: false
    t.string   "ft_auditable_type",             null: false
    t.integer  "ft_auditable_id",   limit: nil, null: false
    t.datetime "created_at",                    null: false
  end

  add_index "ft_pending_confirmations", ["broker_uuid"], name: "ft_confirmations_02"
  add_index "ft_pending_confirmations", ["ft_auditable_type", "ft_auditable_id"], name: "ft_confirmations_01", unique: true

  create_table "ft_purge_saf_transfers", force: :cascade do |t|
    t.string   "reference_no",       limit: 100,                              null: false
    t.datetime "from_req_timestamp",                                          null: false
    t.datetime "to_req_timestamp",                                            null: false
    t.string   "customer_id",        limit: 15
    t.string   "op_name",            limit: 32
    t.string   "req_transfer_type",  limit: 4
    t.datetime "created_at",                                                  null: false
    t.datetime "updated_at",                                                  null: false
    t.string   "created_by",         limit: 20
    t.string   "updated_by",         limit: 20
    t.integer  "lock_version",                   precision: 38, default: 0,   null: false
    t.string   "last_action",        limit: 1,                  default: "C", null: false
    t.string   "approval_status",    limit: 1,                  default: "U", null: false
    t.integer  "approved_version",               precision: 38
    t.integer  "approved_id",        limit: nil
    t.string   "status_code",        limit: 25
    t.integer  "row_count",                      precision: 38
  end

  add_index "ft_purge_saf_transfers", ["reference_no", "approval_status"], name: "ft_purge_saf_transfers_01", unique: true

  create_table "ft_purpose_codes", force: :cascade do |t|
    t.string   "code",                       limit: 20,                                            null: false
    t.string   "description",                limit: 100
    t.string   "is_enabled",                 limit: 1
    t.string   "allow_only_registered_bene", limit: 1
    t.string   "created_by",                 limit: 20
    t.string   "updated_by",                 limit: 20
    t.datetime "created_at",                                                                       null: false
    t.datetime "updated_at",                                                                       null: false
    t.integer  "lock_version",                           precision: 38, default: 0,                null: false
    t.string   "approval_status",            limit: 1,                  default: "U",              null: false
    t.string   "last_action",                limit: 1,                  default: "C",              null: false
    t.integer  "approved_version",                       precision: 38
    t.integer  "approved_id",                limit: nil
    t.string   "allowed_transfer_types",                                default: "IMPS,NEFT,RTGS", null: false
    t.string   "is_frozen",                  limit: 1,                  default: "f",              null: false
    t.string   "setting1"
    t.string   "setting2"
    t.string   "setting3"
    t.string   "setting4"
    t.string   "setting5"
    t.integer  "settings_cnt",               limit: nil,                default: 0,                null: false
  end

  add_index "ft_purpose_codes", ["code", "approval_status"], name: "uk_ft_purpose_codes", unique: true

  create_table "ft_saf_transfers", force: :cascade do |t|
    t.string   "app_uuid"
    t.string   "customer_id",                    null: false
    t.string   "req_no",            limit: 32,   null: false
    t.string   "op_name",           limit: 32,   null: false
    t.string   "req_transfer_type", limit: 4
    t.datetime "req_timestamp",                  null: false
    t.datetime "rep_timestamp"
    t.text     "req_bitstream"
    t.text     "rep_bitstream"
    t.string   "app_id",                         null: false
    t.string   "fault_code",        limit: 50
    t.string   "fault_subcode",     limit: 50
    t.string   "fault_reason",      limit: 1000
    t.text     "fault_bitstream"
    t.datetime "fault_timestamp"
    t.string   "status_code",                    null: false
    t.decimal  "transfer_amount"
    t.string   "transfer_ccy",      limit: 5
  end

  add_index "ft_saf_transfers", ["customer_id", "req_no"], name: "ft_saf_transfers_01", unique: true
  add_index "ft_saf_transfers", ["req_timestamp", "customer_id", "req_transfer_type"], name: "ft_saf_transfers_02"

  create_table "ft_tmp_audit_logs", force: :cascade do |t|
    t.string   "req_no",               limit: 50,  null: false
    t.string   "app_id",               limit: 20,  null: false
    t.string   "customer_id",          limit: 15,  null: false
    t.integer  "ft_invoice_detail_id", limit: nil
    t.datetime "created_at",                       null: false
    t.text     "req_bitstream"
  end

  add_index "ft_tmp_audit_logs", ["ft_invoice_detail_id", "req_no", "app_id", "customer_id"], name: "ft_tmp_audit_logs_01", unique: true

  create_table "ft_unapproved_records", force: :cascade do |t|
    t.integer  "ft_approvable_id",   limit: nil
    t.string   "ft_approvable_type"
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
  end

  create_table "fun_tra_bkp_180801to181231", id: false, force: :cascade do |t|
    t.integer  "id",                     limit: nil,                 null: false
    t.string   "req_no",                                             null: false
    t.string   "req_version",            limit: 10,                  null: false
    t.datetime "req_timestamp",                                      null: false
    t.string   "customer_id",            limit: 20,                  null: false
    t.string   "debit_account_no",                                   null: false
    t.string   "bene_code"
    t.string   "bene_full_name"
    t.string   "bene_address1"
    t.string   "bene_address2"
    t.string   "bene_address3"
    t.string   "bene_postal_code"
    t.string   "bene_city"
    t.string   "bene_state"
    t.string   "bene_country"
    t.string   "bene_contact_email_id"
    t.string   "bene_contact_mobile_no"
    t.string   "bene_account_no"
    t.string   "bene_account_ifsc"
    t.string   "bene_account_mobile_no"
    t.string   "bene_account_mmid"
    t.string   "transfer_type"
    t.integer  "transfer_amount",                     precision: 38
    t.string   "transfer_ccy"
    t.string   "rmtr_to_bene_note"
    t.string   "status_code",            limit: 25
    t.string   "bank_ref",               limit: 30
    t.string   "rep_no"
    t.string   "rep_version",            limit: 10
    t.datetime "rep_timestamp"
    t.integer  "attempt_no",                          precision: 38, null: false
    t.string   "fault_code",             limit: 50
    t.string   "fault_reason",           limit: 1000
    t.string   "req_transfer_type",      limit: 4
  end

  create_table "fun_tra_bkp_181001to181231", id: false, force: :cascade do |t|
    t.integer  "id",                     limit: nil,                 null: false
    t.string   "req_no",                                             null: false
    t.string   "req_version",            limit: 10,                  null: false
    t.datetime "req_timestamp",                                      null: false
    t.string   "customer_id",            limit: 20,                  null: false
    t.string   "debit_account_no",                                   null: false
    t.string   "bene_code"
    t.string   "bene_full_name"
    t.string   "bene_address1"
    t.string   "bene_address2"
    t.string   "bene_address3"
    t.string   "bene_postal_code"
    t.string   "bene_city"
    t.string   "bene_state"
    t.string   "bene_country"
    t.string   "bene_contact_email_id"
    t.string   "bene_contact_mobile_no"
    t.string   "bene_account_no"
    t.string   "bene_account_ifsc"
    t.string   "bene_account_mobile_no"
    t.string   "bene_account_mmid"
    t.string   "transfer_type"
    t.integer  "transfer_amount",                     precision: 38
    t.string   "transfer_ccy"
    t.string   "rmtr_to_bene_note"
    t.string   "status_code",            limit: 25
    t.string   "bank_ref",               limit: 30
    t.string   "rep_no"
    t.string   "rep_version",            limit: 10
    t.datetime "rep_timestamp"
    t.integer  "attempt_no",                          precision: 38, null: false
    t.string   "fault_code",             limit: 50
    t.string   "fault_reason",           limit: 1000
    t.string   "req_transfer_type",      limit: 4
  end

  create_table "fun_tra_bkp_181101to181231", id: false, force: :cascade do |t|
    t.integer  "id",                     limit: nil,                 null: false
    t.string   "req_no",                                             null: false
    t.string   "req_version",            limit: 10,                  null: false
    t.datetime "req_timestamp",                                      null: false
    t.string   "customer_id",            limit: 20,                  null: false
    t.string   "debit_account_no",                                   null: false
    t.string   "bene_code"
    t.string   "bene_full_name"
    t.string   "bene_address1"
    t.string   "bene_address2"
    t.string   "bene_address3"
    t.string   "bene_postal_code"
    t.string   "bene_city"
    t.string   "bene_state"
    t.string   "bene_country"
    t.string   "bene_contact_email_id"
    t.string   "bene_contact_mobile_no"
    t.string   "bene_account_no"
    t.string   "bene_account_ifsc"
    t.string   "bene_account_mobile_no"
    t.string   "bene_account_mmid"
    t.string   "transfer_type"
    t.integer  "transfer_amount",                     precision: 38
    t.string   "transfer_ccy"
    t.string   "rmtr_to_bene_note"
    t.string   "status_code",            limit: 25
    t.string   "bank_ref",               limit: 30
    t.string   "rep_no"
    t.string   "rep_version",            limit: 10
    t.datetime "rep_timestamp"
    t.integer  "attempt_no",                          precision: 38, null: false
    t.string   "fault_code",             limit: 50
    t.string   "fault_reason",           limit: 1000
    t.string   "req_transfer_type",      limit: 4
  end

  create_table "funds_trans_bkp_181101to181231", id: false, force: :cascade do |t|
    t.integer  "id",                     limit: nil,                 null: false
    t.string   "req_no",                                             null: false
    t.string   "req_version",            limit: 10,                  null: false
    t.datetime "req_timestamp",                                      null: false
    t.string   "customer_id",            limit: 20,                  null: false
    t.string   "debit_account_no",                                   null: false
    t.string   "bene_code"
    t.string   "bene_full_name"
    t.string   "bene_address1"
    t.string   "bene_address2"
    t.string   "bene_address3"
    t.string   "bene_postal_code"
    t.string   "bene_city"
    t.string   "bene_state"
    t.string   "bene_country"
    t.string   "bene_contact_email_id"
    t.string   "bene_contact_mobile_no"
    t.string   "bene_account_no"
    t.string   "bene_account_ifsc"
    t.string   "bene_account_mobile_no"
    t.string   "bene_account_mmid"
    t.string   "transfer_type"
    t.integer  "transfer_amount",                     precision: 38
    t.string   "transfer_ccy"
    t.string   "rmtr_to_bene_note"
    t.string   "status_code",            limit: 25
    t.string   "bank_ref",               limit: 30
    t.string   "rep_no"
    t.string   "rep_version",            limit: 10
    t.datetime "rep_timestamp"
    t.integer  "attempt_no",                          precision: 38, null: false
    t.string   "fault_code",             limit: 50
    t.string   "fault_reason",           limit: 1000
    t.string   "req_transfer_type",      limit: 4
  end

  create_table "funds_trans_bkp_181113to181218", id: false, force: :cascade do |t|
    t.integer  "id",                     limit: nil,                 null: false
    t.string   "req_no",                                             null: false
    t.string   "req_version",            limit: 10,                  null: false
    t.datetime "req_timestamp",                                      null: false
    t.string   "customer_id",            limit: 20,                  null: false
    t.string   "debit_account_no",                                   null: false
    t.string   "bene_code"
    t.string   "bene_full_name"
    t.string   "bene_address1"
    t.string   "bene_address2"
    t.string   "bene_address3"
    t.string   "bene_postal_code"
    t.string   "bene_city"
    t.string   "bene_state"
    t.string   "bene_country"
    t.string   "bene_contact_email_id"
    t.string   "bene_contact_mobile_no"
    t.string   "bene_account_no"
    t.string   "bene_account_ifsc"
    t.string   "bene_account_mobile_no"
    t.string   "bene_account_mmid"
    t.string   "transfer_type"
    t.integer  "transfer_amount",                     precision: 38
    t.string   "transfer_ccy"
    t.string   "rmtr_to_bene_note"
    t.string   "status_code",            limit: 25
    t.string   "bank_ref",               limit: 30
    t.string   "rep_no"
    t.string   "rep_version",            limit: 10
    t.datetime "rep_timestamp"
    t.integer  "attempt_no",                          precision: 38, null: false
    t.string   "fault_code",             limit: 50
    t.string   "fault_reason",           limit: 1000
    t.string   "req_transfer_type",      limit: 4
  end

  create_table "funds_trans_bkp_181201to181228", id: false, force: :cascade do |t|
    t.integer  "id",                     limit: nil,                 null: false
    t.string   "req_no",                                             null: false
    t.string   "req_version",            limit: 10,                  null: false
    t.datetime "req_timestamp",                                      null: false
    t.string   "customer_id",            limit: 20,                  null: false
    t.string   "debit_account_no",                                   null: false
    t.string   "bene_code"
    t.string   "bene_full_name"
    t.string   "bene_address1"
    t.string   "bene_address2"
    t.string   "bene_address3"
    t.string   "bene_postal_code"
    t.string   "bene_city"
    t.string   "bene_state"
    t.string   "bene_country"
    t.string   "bene_contact_email_id"
    t.string   "bene_contact_mobile_no"
    t.string   "bene_account_no"
    t.string   "bene_account_ifsc"
    t.string   "bene_account_mobile_no"
    t.string   "bene_account_mmid"
    t.string   "transfer_type"
    t.integer  "transfer_amount",                     precision: 38
    t.string   "transfer_ccy"
    t.string   "rmtr_to_bene_note"
    t.string   "status_code",            limit: 25
    t.string   "bank_ref",               limit: 30
    t.string   "rep_no"
    t.string   "rep_version",            limit: 10
    t.datetime "rep_timestamp"
    t.integer  "attempt_no",                          precision: 38, null: false
    t.string   "fault_code",             limit: 50
    t.string   "fault_reason",           limit: 1000
    t.string   "req_transfer_type",      limit: 4
  end

  create_table "funds_trans_bkp_181204to181205", id: false, force: :cascade do |t|
    t.integer  "id",                     limit: nil,                 null: false
    t.string   "req_no",                                             null: false
    t.string   "req_version",            limit: 10,                  null: false
    t.datetime "req_timestamp",                                      null: false
    t.string   "customer_id",            limit: 20,                  null: false
    t.string   "debit_account_no",                                   null: false
    t.string   "bene_code"
    t.string   "bene_full_name"
    t.string   "bene_address1"
    t.string   "bene_address2"
    t.string   "bene_address3"
    t.string   "bene_postal_code"
    t.string   "bene_city"
    t.string   "bene_state"
    t.string   "bene_country"
    t.string   "bene_contact_email_id"
    t.string   "bene_contact_mobile_no"
    t.string   "bene_account_no"
    t.string   "bene_account_ifsc"
    t.string   "bene_account_mobile_no"
    t.string   "bene_account_mmid"
    t.string   "transfer_type"
    t.integer  "transfer_amount",                     precision: 38
    t.string   "transfer_ccy"
    t.string   "rmtr_to_bene_note"
    t.string   "status_code",            limit: 25
    t.string   "bank_ref",               limit: 30
    t.string   "rep_no"
    t.string   "rep_version",            limit: 10
    t.datetime "rep_timestamp"
    t.integer  "attempt_no",                          precision: 38, null: false
    t.string   "fault_code",             limit: 50
    t.string   "fault_reason",           limit: 1000
    t.string   "req_transfer_type",      limit: 4
  end

  create_table "funds_trans_bkp_181227to181224", id: false, force: :cascade do |t|
    t.integer  "id",                     limit: nil,                 null: false
    t.string   "req_no",                                             null: false
    t.string   "req_version",            limit: 10,                  null: false
    t.datetime "req_timestamp",                                      null: false
    t.string   "customer_id",            limit: 20,                  null: false
    t.string   "debit_account_no",                                   null: false
    t.string   "bene_code"
    t.string   "bene_full_name"
    t.string   "bene_address1"
    t.string   "bene_address2"
    t.string   "bene_address3"
    t.string   "bene_postal_code"
    t.string   "bene_city"
    t.string   "bene_state"
    t.string   "bene_country"
    t.string   "bene_contact_email_id"
    t.string   "bene_contact_mobile_no"
    t.string   "bene_account_no"
    t.string   "bene_account_ifsc"
    t.string   "bene_account_mobile_no"
    t.string   "bene_account_mmid"
    t.string   "transfer_type"
    t.integer  "transfer_amount",                     precision: 38
    t.string   "transfer_ccy"
    t.string   "rmtr_to_bene_note"
    t.string   "status_code",            limit: 25
    t.string   "bank_ref",               limit: 30
    t.string   "rep_no"
    t.string   "rep_version",            limit: 10
    t.datetime "rep_timestamp"
    t.integer  "attempt_no",                          precision: 38, null: false
    t.string   "fault_code",             limit: 50
    t.string   "fault_reason",           limit: 1000
    t.string   "req_transfer_type",      limit: 4
  end

  create_table "funds_transfer_audit_logs", force: :cascade do |t|
    t.integer "funds_transfer_id", limit: nil
    t.text    "request_bitstream"
    t.text    "reply_bitstream"
  end

  create_table "funds_transfers", force: :cascade do |t|
    t.string   "req_no",                                             null: false
    t.string   "req_version",            limit: 10,                  null: false
    t.datetime "req_timestamp",                                      null: false
    t.string   "customer_id",            limit: 20,                  null: false
    t.string   "debit_account_no",                                   null: false
    t.string   "bene_code"
    t.string   "bene_full_name"
    t.string   "bene_address1"
    t.string   "bene_address2"
    t.string   "bene_address3"
    t.string   "bene_postal_code"
    t.string   "bene_city"
    t.string   "bene_state"
    t.string   "bene_country"
    t.string   "bene_contact_email_id"
    t.string   "bene_contact_mobile_no"
    t.string   "bene_account_no"
    t.string   "bene_account_ifsc"
    t.string   "bene_account_mobile_no"
    t.string   "bene_account_mmid"
    t.string   "transfer_type"
    t.integer  "transfer_amount",                     precision: 38
    t.string   "transfer_ccy"
    t.string   "rmtr_to_bene_note"
    t.string   "status_code",            limit: 25
    t.string   "bank_ref",               limit: 30
    t.string   "rep_no"
    t.string   "rep_version",            limit: 10
    t.datetime "rep_timestamp"
    t.integer  "attempt_no",                          precision: 38, null: false
    t.string   "fault_code",             limit: 50
    t.string   "fault_reason",           limit: 1000
    t.string   "req_transfer_type",      limit: 4
  end

  create_table "gem_audit_logs", force: :cascade do |t|
    t.string   "req_no",             limit: 50,                  null: false
    t.integer  "attempt_no",                      precision: 38, null: false
    t.string   "status_code",        limit: 25,                  null: false
    t.string   "gem_auditable_type", limit: 100,                 null: false
    t.integer  "gem_auditable_id",   limit: nil,                 null: false
    t.string   "fault_code",         limit: 50
    t.string   "fault_subcode",      limit: 50
    t.string   "fault_reason",       limit: 1000
    t.datetime "req_timestamp"
    t.datetime "rep_timestamp"
    t.text     "req_bitstream",                                  null: false
    t.text     "rep_bitstream"
    t.text     "fault_bitstream"
  end

  add_index "gem_audit_logs", ["gem_auditable_type", "gem_auditable_id"], name: "gem_audit_logs_02", unique: true
  add_index "gem_audit_logs", ["req_no", "attempt_no"], name: "gem_audit_logs_01", unique: true

  create_table "gem_audit_steps", force: :cascade do |t|
    t.string   "gem_auditable_type", limit: 100,                 null: false
    t.integer  "gem_auditable_id",   limit: nil,                 null: false
    t.string   "step_name",          limit: 100,                 null: false
    t.integer  "step_no",                         precision: 38, null: false
    t.integer  "attempt_no",                      precision: 38, null: false
    t.string   "status_code",        limit: 25,                  null: false
    t.string   "fault_code"
    t.string   "fault_subcode",      limit: 50
    t.string   "fault_reason",       limit: 1000
    t.string   "req_reference"
    t.datetime "req_timestamp"
    t.string   "rep_reference"
    t.datetime "rep_timestamp"
    t.text     "req_bitstream"
    t.text     "rep_bitstream"
  end

  add_index "gem_audit_steps", ["gem_auditable_type", "gem_auditable_id", "step_name", "step_no", "attempt_no"], name: "gem_audit_steps_01", unique: true

  create_table "gem_bgs", force: :cascade do |t|
    t.string   "kind",                limit: 3,                  null: false
    t.decimal  "amendment_no"
    t.string   "txn_ref_no",          limit: 16,                 null: false
    t.datetime "received_at",                                    null: false
    t.string   "buyer_regno",         limit: 210,                null: false
    t.string   "seller_regno",        limit: 210,                null: false
    t.string   "bid_name",            limit: 210
    t.datetime "bg_validity",                                    null: false
    t.decimal  "bg_amount",                                      null: false
    t.integer  "original_bid_id",     limit: nil
    t.string   "match_result",        limit: 2
    t.string   "match_result_text",   limit: 1000
    t.datetime "matched_at"
    t.integer  "matched_bid_id",      limit: nil
    t.string   "notification_status", limit: 20
    t.datetime "notified_at"
    t.text     "sfms_msg_text",                                  null: false
    t.text     "gem_msg_text",                                   null: false
    t.string   "pending_approval",    limit: 1,    default: "f", null: false
  end

  add_index "gem_bgs", ["kind", "amendment_no", "txn_ref_no"], name: "gem_bgs_01", unique: true

  create_table "gem_bid_calls", force: :cascade do |t|
    t.string   "bank_token",                 null: false
    t.datetime "sent_at",                    null: false
    t.integer  "num_bids",    precision: 38
    t.datetime "received_at"
  end

  create_table "gem_buyers", force: :cascade do |t|
    t.string   "state_code",           limit: 5,                                null: false
    t.string   "ecol_customer_code",   limit: 15,                               null: false
    t.string   "pool_account_no",      limit: 38,                               null: false
    t.string   "ifsc_code",            limit: 11
    t.string   "account_holder_name",  limit: 100,                              null: false
    t.string   "is_enabled",           limit: 1,                  default: "Y", null: false
    t.string   "identity_user_id"
    t.datetime "created_at",                                                    null: false
    t.datetime "updated_at",                                                    null: false
    t.string   "created_by",           limit: 20
    t.string   "updated_by",           limit: 20
    t.integer  "lock_version",                     precision: 38, default: 0,   null: false
    t.string   "last_action",          limit: 1,                  default: "C", null: false
    t.string   "approval_status",      limit: 1,                  default: "U", null: false
    t.integer  "approved_version",                 precision: 38
    t.integer  "approved_id",          limit: nil
    t.string   "gem_type"
    t.string   "non_challan_category"
    t.string   "reversal_account_no"
    t.string   "external_ifsc"
    t.boolean  "is_external",          limit: nil
  end

  add_index "gem_buyers", ["ecol_customer_code", "approval_status"], name: "gem_buyers_02", unique: true
  add_index "gem_buyers", ["state_code", "approval_status"], name: "gem_buyers_01", unique: true

  create_table "gem_ddo_earmark_details", force: :cascade do |t|
    t.string  "ecol_va_earmark_id",  limit: 20
    t.string  "supply_order_no",     limit: 30
    t.string  "buyer_id",            limit: 20
    t.string  "buyer_dept",          limit: 100
    t.string  "function_head",       limit: 10
    t.string  "object_code",         limit: 10
    t.string  "grant_no",            limit: 10
    t.string  "category",            limit: 20
    t.string  "fund_block_txn_id",   limit: 50,  null: false
    t.string  "ddo_registration_no", limit: 20,  null: false
    t.integer "gem_buyer_id",        limit: nil, null: false
  end

  add_index "gem_ddo_earmark_details", ["fund_block_txn_id", "ddo_registration_no", "gem_buyer_id"], name: "gem_ddo_earmark_details_01", unique: true

  create_table "gem_ddo_earmark_txns", force: :cascade do |t|
    t.string   "req_no",                limit: 50,                 null: false
    t.string   "ddo_registration_no",   limit: 20,                 null: false
    t.string   "req_fund_block_txn_id", limit: 50,                 null: false
    t.string   "buyer_state_code",      limit: 5,                  null: false
    t.string   "supply_order_no",       limit: 30
    t.string   "buyer_id",              limit: 20
    t.string   "buyer_dept",            limit: 100
    t.string   "ddo_code",              limit: 10,                 null: false
    t.string   "function_head",         limit: 10
    t.string   "object_code",           limit: 10
    t.string   "grant_no",              limit: 10
    t.string   "category",              limit: 20
    t.decimal  "amount",                                           null: false
    t.string   "req_type",              limit: 1,                  null: false
    t.string   "rep_no",                limit: 50
    t.string   "rep_fund_block_txn_id", limit: 50
    t.string   "status_code",           limit: 1
    t.datetime "req_timestamp",                                    null: false
    t.datetime "rep_timestamp"
    t.string   "fault_code",            limit: 50
    t.string   "fault_subcode",         limit: 50
    t.string   "fault_reason",          limit: 1000
    t.integer  "ecol_va_txn_id",        limit: nil
    t.string   "is_cached_response",    limit: 1,    default: "f", null: false
  end

  add_index "gem_ddo_earmark_txns", ["req_fund_block_txn_id", "req_type", "status_code", "is_cached_response"], name: "gem_ddo_earmark_txns_02"
  add_index "gem_ddo_earmark_txns", ["req_no"], name: "gem_ddo_earmark_txns_01", unique: true

  create_table "gem_ddo_incoming_files", force: :cascade do |t|
    t.string "file_name", limit: 100, null: false
  end

  add_index "gem_ddo_incoming_files", ["file_name"], name: "gem_ddo_incoming_files_01", unique: true

  create_table "gem_ddo_incoming_records", force: :cascade do |t|
    t.integer "incoming_file_record_id", limit: nil, null: false
    t.string  "file_name",               limit: 100, null: false
    t.string  "state_code",              limit: 5,   null: false
    t.string  "ddo_code",                limit: 10,  null: false
    t.string  "ddo_registration_no",     limit: 20,  null: false
    t.string  "action",                  limit: 20,  null: false
    t.string  "buyer_dept",              limit: 100
    t.string  "buyer_id",                limit: 20
  end

  add_index "gem_ddo_incoming_records", ["incoming_file_record_id", "file_name"], name: "gem_ddo_incoming_records_01", unique: true

  create_table "gem_ddo_payments", force: :cascade do |t|
    t.string   "req_no",              limit: 50,                 null: false
    t.string   "ddo_registration_no", limit: 20,                 null: false
    t.string   "fund_block_txnid",    limit: 50,                 null: false
    t.string   "buyer_state_code",    limit: 5,                  null: false
    t.string   "supply_order_no",     limit: 30
    t.string   "invoice_no",          limit: 20,                 null: false
    t.date     "invoice_date",                                   null: false
    t.string   "buyer_id",            limit: 20
    t.string   "buyer_dept",          limit: 100
    t.string   "ddo_code",            limit: 10,                 null: false
    t.string   "function_head",       limit: 10
    t.string   "object_code",         limit: 10
    t.string   "grant_no",            limit: 10
    t.string   "category",            limit: 20
    t.decimal  "amount",                                         null: false
    t.string   "req_type",            limit: 1,                  null: false
    t.string   "bene_account_no",     limit: 20,                 null: false
    t.string   "bene_ifsc_code",      limit: 11,                 null: false
    t.string   "bene_account_name",   limit: 100,                null: false
    t.string   "rep_no",              limit: 50
    t.decimal  "amount_blocked"
    t.string   "status_code",         limit: 1
    t.datetime "req_timestamp",                                  null: false
    t.datetime "rep_timestamp"
    t.string   "fault_code",          limit: 50
    t.string   "fault_subcode",       limit: 50
    t.string   "fault_reason",        limit: 1000
    t.integer  "ecol_va_txn_id",      limit: nil
    t.string   "is_cached_response",  limit: 1,    default: "f", null: false
  end

  add_index "gem_ddo_payments", ["fund_block_txnid", "supply_order_no", "invoice_no", "status_code", "is_cached_response"], name: "gem_ddo_payments_02"
  add_index "gem_ddo_payments", ["req_no"], name: "gem_ddo_payments_01", unique: true

  create_table "gem_ddos", force: :cascade do |t|
    t.string   "ddo_code",            limit: 10,                               null: false
    t.integer  "gem_buyer_id",        limit: nil,                              null: false
    t.string   "ddo_registration_no", limit: 20,                               null: false
    t.integer  "incoming_file_id",    limit: nil
    t.string   "is_enabled",          limit: 1,                  default: "Y", null: false
    t.datetime "created_at",                                                   null: false
    t.datetime "updated_at",                                                   null: false
    t.string   "created_by",          limit: 20
    t.string   "updated_by",          limit: 20
    t.integer  "lock_version",                    precision: 38, default: 0,   null: false
    t.string   "last_action",         limit: 1,                  default: "C", null: false
    t.string   "approval_status",     limit: 1,                  default: "U", null: false
    t.integer  "approved_version",                precision: 38
    t.integer  "approved_id",         limit: nil
    t.string   "buyer_dept",          limit: 100
    t.string   "buyer_id",            limit: 20
  end

  add_index "gem_ddos", ["gem_buyer_id", "ddo_code", "approval_status"], name: "gem_ddos_01", unique: true
  add_index "gem_ddos", ["gem_buyer_id", "ddo_registration_no", "approval_status"], name: "gem_ddos_02", unique: true

  create_table "gem_failed_messages", force: :cascade do |t|
    t.datetime "received_at",                  null: false
    t.string   "fault_code",      limit: 50,   null: false
    t.string   "fault_reason",    limit: 1000
    t.text     "fault_bitstream"
    t.text     "msg_text",                     null: false
  end

  create_table "gem_operations_enquiries", force: :cascade do |t|
    t.string   "operation_name",      limit: 30,   null: false
    t.string   "req_no",              limit: 50,   null: false
    t.string   "state_code",          limit: 5
    t.string   "pool_account_no",     limit: 38
    t.string   "ifsc_code",           limit: 11
    t.string   "account_holder_name", limit: 100
    t.string   "rep_no",              limit: 50
    t.string   "status_code",         limit: 1
    t.datetime "req_timestamp",                    null: false
    t.datetime "rep_timestamp"
    t.string   "fault_code",          limit: 50
    t.string   "fault_subcode",       limit: 50
    t.string   "fault_reason",        limit: 1000
  end

  add_index "gem_operations_enquiries", ["req_no"], name: "gem_operations_enquiries_01", unique: true

  create_table "gem_pending_matches", force: :cascade do |t|
    t.string   "app_uuid",               null: false
    t.datetime "created_at",             null: false
    t.integer  "gem_bg_id",  limit: nil
  end

  add_index "gem_pending_matches", ["gem_bg_id"], name: "gem_pending_matches_01", unique: true

  create_table "gem_pending_notifications", force: :cascade do |t|
    t.string   "app_uuid",               null: false
    t.datetime "created_at",             null: false
    t.integer  "gem_bg_id",  limit: nil
  end

  add_index "gem_pending_notifications", ["gem_bg_id"], name: "gem_pending_notifications_01", unique: true

  create_table "gem_received_bids", force: :cascade do |t|
    t.integer  "bid_call_id",  limit: nil, null: false
    t.string   "buyer_regno",  limit: 210, null: false
    t.string   "seller_regno", limit: 210, null: false
    t.string   "bid_name",     limit: 210, null: false
    t.datetime "bid_validity",             null: false
    t.decimal  "bid_amount",               null: false
    t.datetime "received_at"
  end

  add_index "gem_received_bids", ["buyer_regno", "seller_regno", "bid_name", "bid_validity", "bid_amount"], name: "gem_received_bids_01", unique: true

  create_table "gem_todays_bgs", force: :cascade do |t|
    t.string   "kind",            limit: 3,   null: false
    t.decimal  "amendment_no"
    t.string   "txn_ref_no",      limit: 16,  null: false
    t.datetime "received_at",                 null: false
    t.string   "buyer_regno",     limit: 210, null: false
    t.string   "seller_regno",    limit: 210, null: false
    t.string   "bid_name",        limit: 210
    t.datetime "bg_validity",                 null: false
    t.decimal  "bg_amount",                   null: false
    t.text     "sfms_msg_text",               null: false
    t.text     "gem_msg_text",                null: false
    t.integer  "original_bid_id", limit: nil
  end

  add_index "gem_todays_bgs", ["kind", "amendment_no", "txn_ref_no"], name: "gem_todays_bgs_01", unique: true

  create_table "getbiller_details", force: :cascade do |t|
    t.string   "biller_code",       limit: 100,                null: false
    t.string   "biller_name",       limit: 100,                null: false
    t.string   "biller_category",   limit: 100,                null: false
    t.string   "biller_location",   limit: 100,                null: false
    t.string   "processing_method", limit: 100,                null: false
    t.string   "is_enabled",        limit: 1,                  null: false
    t.integer  "num_params",                    precision: 38, null: false
    t.string   "param1_name",       limit: 100
    t.string   "param1_pattern",    limit: 100
    t.string   "param1_tooltip",    limit: 100
    t.string   "param2_name",       limit: 100
    t.string   "param2_pattern",    limit: 100
    t.string   "param2_tooltip",    limit: 100
    t.string   "param3_name",       limit: 100
    t.string   "param3_pattern",    limit: 100
    t.string   "param3_tooltip",    limit: 100
    t.string   "param4_name",       limit: 100
    t.string   "param4_pattern",    limit: 100
    t.string   "param4_tooltip",    limit: 100
    t.string   "param5_name",       limit: 100
    t.string   "param5_pattern",    limit: 100
    t.string   "param5_tooltip",    limit: 100
    t.integer  "lock_version",                  precision: 38, null: false
    t.datetime "created_at",                                   null: false
    t.datetime "updated_at",                                   null: false
    t.string   "approval_status",   limit: 1,                  null: false
    t.string   "last_action",       limit: 1
    t.integer  "approved_version",              precision: 38
    t.integer  "approved_id",       limit: nil
  end

  create_table "groups", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.text     "description"
  end

  create_table "groups_bkp_sysdate", id: false, force: :cascade do |t|
    t.integer  "id",         limit: nil, null: false
    t.string   "name"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "iam_audit_logs", force: :cascade do |t|
    t.string   "org_uuid",                   null: false
    t.string   "cert_dn",       limit: 300
    t.string   "source_ip",     limit: 100
    t.text     "req_bitstream"
    t.text     "rep_bitstream"
    t.datetime "req_timestamp",              null: false
    t.datetime "rep_timestamp"
    t.string   "fault_code",    limit: 50
    t.string   "fault_reason",  limit: 1000
  end

  add_index "iam_audit_logs", ["org_uuid"], name: "iam_audit_logs_01"

  create_table "iam_audit_rules", force: :cascade do |t|
    t.integer  "interval_in_mins",                precision: 38, default: 15,                    null: false
    t.string   "created_by",          limit: 20
    t.string   "updated_by",          limit: 20
    t.datetime "created_at",                                                                     null: false
    t.datetime "updated_at",                                                                     null: false
    t.integer  "lock_version",                    precision: 38, default: 0,                     null: false
    t.string   "log_bad_org_uuid",    limit: 1,                  default: "f",                   null: false
    t.integer  "iam_organisation_id", limit: nil
    t.datetime "enabled_at",                                     default: '2018-10-30 13:21:46', null: false
  end

  create_table "iam_cust_users", force: :cascade do |t|
    t.string   "username",               limit: 100,                                null: false
    t.string   "first_name"
    t.string   "last_name",              limit: 100
    t.string   "email",                  limit: 100
    t.string   "mobile_no",              limit: 20
    t.string   "encrypted_password"
    t.string   "should_reset_password",  limit: 1
    t.string   "was_user_added",         limit: 1
    t.datetime "last_password_reset_at"
    t.datetime "created_at",                                                        null: false
    t.datetime "updated_at",                                                        null: false
    t.string   "created_by",             limit: 20
    t.string   "updated_by",             limit: 20
    t.integer  "lock_version",                       precision: 38, default: 0,     null: false
    t.string   "last_action",            limit: 1,                  default: "C",   null: false
    t.string   "approval_status",        limit: 1,                  default: "U",   null: false
    t.integer  "approved_version",                   precision: 38
    t.integer  "approved_id",            limit: nil
    t.datetime "notification_sent_at"
    t.string   "is_enabled",                                        default: "Y"
    t.string   "secondary_email"
    t.string   "secondary_mobile_no"
    t.boolean  "is_sms",                 limit: nil,                default: false
    t.boolean  "is_email",               limit: nil,                default: false
    t.string   "send_password_via"
  end

  add_index "iam_cust_users", ["username", "approval_status"], name: "iam_cust_users_01", unique: true

  create_table "iam_organisations", force: :cascade do |t|
    t.string   "name",                                                           null: false
    t.string   "org_uuid",                                                       null: false
    t.string   "on_vpn",               limit: 1,                                 null: false
    t.string   "cert_dn",              limit: 300
    t.string   "source_ips",           limit: 4000
    t.string   "is_enabled",                                       default: "Y", null: false
    t.string   "created_by",           limit: 20
    t.string   "updated_by",           limit: 20
    t.datetime "created_at",                                                     null: false
    t.datetime "updated_at",                                                     null: false
    t.integer  "lock_version",                      precision: 38, default: 0,   null: false
    t.string   "approval_status",      limit: 1,                   default: "U", null: false
    t.string   "last_action",          limit: 1,                   default: "C"
    t.integer  "approved_id",          limit: nil
    t.integer  "approved_version",                  precision: 38
    t.string   "email_id",                                                       null: false
    t.datetime "notification_sent_at"
  end

  add_index "iam_organisations", ["org_uuid", "approval_status"], name: "iam_organisations_01", unique: true

  create_table "ic001_incoming_files", force: :cascade do |t|
    t.string "file_name", limit: 100
  end

  add_index "ic001_incoming_files", ["file_name"], name: "ic001_incoming_files_01", unique: true

  create_table "ic001_incoming_records", force: :cascade do |t|
    t.integer "incoming_file_record_id", limit: nil
    t.string  "file_name",               limit: 100
    t.string  "anchor_cust_id",          limit: 50
    t.string  "anchor_account_id",       limit: 50
    t.string  "dealer_account_id",       limit: 50
    t.string  "dealer_cust_id",          limit: 50
    t.decimal "drawdown_amount"
    t.string  "remarks"
    t.string  "invoice_no",              limit: 50
    t.decimal "invoice_amount"
    t.date    "book_date"
    t.string  "additional_field1",       limit: 50
    t.string  "additional_field2",       limit: 50
    t.string  "status",                  limit: 50
    t.string  "failure_reason"
    t.string  "ref_number",              limit: 50
    t.decimal "sl_no"
    t.date    "created_date"
  end

  add_index "ic001_incoming_records", ["incoming_file_record_id", "file_name"], name: "ic001_incoming_records_01", unique: true

  create_table "ic_audit_logs", force: :cascade do |t|
    t.string   "req_no",            limit: 32,                  null: false
    t.string   "app_id",            limit: 32,                  null: false
    t.integer  "attempt_no",                     precision: 38, null: false
    t.string   "status_code",       limit: 25,                  null: false
    t.string   "ic_auditable_type",                             null: false
    t.integer  "ic_auditable_id",   limit: nil,                 null: false
    t.string   "fault_code"
    t.string   "fault_subcode",     limit: 50
    t.string   "fault_reason",      limit: 1000
    t.datetime "req_timestamp"
    t.datetime "rep_timestamp"
    t.text     "req_bitstream",                                 null: false
    t.text     "rep_bitstream"
    t.text     "fault_bitstream"
  end

  add_index "ic_audit_logs", ["app_id", "req_no", "attempt_no"], name: "uk_ic_audit_logs_1", unique: true
  add_index "ic_audit_logs", ["ic_auditable_type", "ic_auditable_id"], name: "uk_ic_audit_logs_2", unique: true

  create_table "ic_audit_steps", force: :cascade do |t|
    t.string   "ic_auditable_type",                             null: false
    t.integer  "ic_auditable_id",   limit: nil,                 null: false
    t.integer  "step_no",                        precision: 38, null: false
    t.integer  "attempt_no",                     precision: 38, null: false
    t.string   "step_name",         limit: 100,                 null: false
    t.string   "status_code",       limit: 25,                  null: false
    t.string   "fault_code"
    t.string   "fault_subcode",     limit: 50
    t.string   "fault_reason",      limit: 1000
    t.string   "req_reference"
    t.datetime "req_timestamp"
    t.string   "rep_reference"
    t.datetime "rep_timestamp"
    t.text     "req_bitstream"
    t.text     "rep_bitstream"
    t.text     "fault_bitstream"
    t.datetime "reconciled_at"
  end

  add_index "ic_audit_steps", ["ic_auditable_type", "ic_auditable_id", "step_no", "attempt_no"], name: "uk_ic_audit_steps", unique: true

  create_table "ic_customers", force: :cascade do |t|
    t.string   "customer_id",          limit: 15,                               null: false
    t.string   "app_id",               limit: 20,                               null: false
    t.string   "identity_user_id",     limit: 20
    t.string   "repay_account_no",     limit: 20,                               null: false
    t.decimal  "fee_pct"
    t.string   "fee_income_gl"
    t.decimal  "max_overdue_pct"
    t.string   "cust_contact_email"
    t.string   "cust_contact_mobile"
    t.string   "ops_email"
    t.string   "rm_email"
    t.string   "is_enabled",           limit: 1,                                null: false
    t.string   "created_by",           limit: 20
    t.string   "updated_by",           limit: 20
    t.datetime "created_at",                                                    null: false
    t.datetime "updated_at",                                                    null: false
    t.integer  "lock_version",                     precision: 38, default: 0,   null: false
    t.string   "approval_status",      limit: 1,                  default: "U", null: false
    t.string   "last_action",          limit: 1,                  default: "C", null: false
    t.integer  "approved_version",                 precision: 38
    t.integer  "approved_id",          limit: nil
    t.string   "customer_name",        limit: 100
    t.string   "sc_backend_code",      limit: 20
    t.datetime "notification_sent_at"
    t.string   "push_url_enabled",     limit: 1,                  default: "f"
    t.string   "push_url"
  end

  add_index "ic_customers", ["app_id", "approval_status"], name: "i_ic_cust_app_id", unique: true
  add_index "ic_customers", ["customer_id", "approval_status"], name: "i_ic_cust_cust_id", unique: true
  add_index "ic_customers", ["identity_user_id", "approval_status"], name: "i_ic_cust_identity_id", unique: true
  add_index "ic_customers", ["repay_account_no", "approval_status"], name: "i_ic_cust_repay_no", unique: true

  create_table "ic_incoming_files", force: :cascade do |t|
    t.string "file_name",        limit: 100
    t.string "corp_customer_id", limit: 15
    t.string "pm_utr",           limit: 64
  end

  add_index "ic_incoming_files", ["file_name"], name: "ic_file_index", unique: true

  create_table "ic_incoming_records", force: :cascade do |t|
    t.integer "incoming_file_record_id", limit: nil, null: false
    t.string  "supplier_code",           limit: 15
    t.string  "invoice_no",              limit: 28
    t.date    "invoice_date"
    t.date    "invoice_due_date"
    t.decimal "invoice_amount"
    t.string  "debit_ref_no",            limit: 64
    t.string  "corp_customer_id",        limit: 15
    t.string  "pm_utr",                  limit: 64
    t.string  "file_name",               limit: 100, null: false
  end

  add_index "ic_incoming_records", ["incoming_file_record_id", "file_name"], name: "ic_record_index", unique: true

  create_table "ic_invoices", force: :cascade do |t|
    t.string  "corp_customer_id",  limit: 15,               null: false
    t.string  "supplier_code",     limit: 15,               null: false
    t.string  "invoice_no",        limit: 28,               null: false
    t.date    "invoice_date",                               null: false
    t.date    "invoice_due_date",                           null: false
    t.decimal "invoice_amount",                             null: false
    t.decimal "fee_amount",                                 null: false
    t.decimal "discounted_amount",                          null: false
    t.date    "credit_date"
    t.string  "credit_ref_no",     limit: 64
    t.string  "pm_utr",            limit: 64
    t.decimal "repaid_amount",                default: 0.0, null: false
    t.date    "repayment_date"
    t.string  "repayment_ref_no",  limit: 64
    t.string  "approval_status",   limit: 1,                null: false
  end

  add_index "ic_invoices", ["supplier_code", "invoice_no", "corp_customer_id"], name: "i_ic_inv_supp_code", unique: true

  create_table "ic_paynows", force: :cascade do |t|
    t.string   "req_no",                                            null: false
    t.integer  "attempt_no",                         precision: 38, null: false
    t.string   "status_code",           limit: 50,                  null: false
    t.string   "req_version",           limit: 20,                  null: false
    t.datetime "req_timestamp",                                     null: false
    t.string   "app_id",                limit: 20,                  null: false
    t.string   "customer_id",           limit: 50,                  null: false
    t.string   "supplier_code",         limit: 50,                  null: false
    t.string   "invoice_no",            limit: 50,                  null: false
    t.date     "invoice_date",                                      null: false
    t.date     "invoice_due_date",                                  null: false
    t.decimal  "invoice_amount",                                    null: false
    t.decimal  "discounted_amount",                                 null: false
    t.decimal  "fee_amount",                                        null: false
    t.string   "rep_no"
    t.string   "rep_version",           limit: 20
    t.datetime "rep_timestamp"
    t.string   "credit_reference_no"
    t.string   "fault_code",            limit: 50
    t.string   "fault_reason",          limit: 1000
    t.string   "cust_email_notify_ref", limit: 50
    t.string   "fault_subcode",         limit: 50
    t.datetime "sent_at"
    t.datetime "credited_at"
  end

  add_index "ic_paynows", ["customer_id", "req_no", "status_code", "attempt_no", "app_id"], name: "ic_paynows_01"
  add_index "ic_paynows", ["req_no", "app_id", "attempt_no", "customer_id"], name: "uk_ic_paynows_1", unique: true

  create_table "ic_pending_steps", force: :cascade do |t|
    t.string   "broker_uuid",                  null: false
    t.integer  "ic_audit_step_id", limit: nil, null: false
    t.datetime "created_at",                   null: false
  end

  create_table "ic_suppliers", force: :cascade do |t|
    t.string   "supplier_code",    limit: 15,                               null: false
    t.string   "supplier_name",    limit: 100,                              null: false
    t.string   "customer_id",      limit: 15,                               null: false
    t.string   "od_account_no",    limit: 20,                               null: false
    t.string   "ca_account_no",    limit: 20,                               null: false
    t.string   "is_enabled",       limit: 1,                                null: false
    t.string   "created_by",       limit: 20
    t.string   "updated_by",       limit: 20
    t.datetime "created_at",                                                null: false
    t.datetime "updated_at",                                                null: false
    t.integer  "lock_version",                 precision: 38, default: 0,   null: false
    t.string   "approval_status",  limit: 1,                  default: "U", null: false
    t.string   "last_action",      limit: 1,                  default: "C", null: false
    t.integer  "approved_version",             precision: 38
    t.integer  "approved_id",      limit: nil
    t.string   "corp_customer_id", limit: 15,                               null: false
  end

  add_index "ic_suppliers", ["supplier_code", "customer_id", "corp_customer_id", "approval_status"], name: "ic_suppliers_01", unique: true

  create_table "ic_unapproved_records", force: :cascade do |t|
    t.integer  "ic_approvable_id",   limit: nil
    t.string   "ic_approvable_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "icol_apps", force: :cascade do |t|
    t.string   "app_code",                 limit: 50, null: false
    t.datetime "created_at",                          null: false
    t.string   "created_by",               limit: 20
    t.text     "expected_validate_input"
    t.text     "expected_validate_output"
    t.text     "expected_notify_input"
    t.text     "expected_notify_output"
  end

  add_index "icol_apps", ["app_code"], name: "icol_apps_01", unique: true

  create_table "icol_customers", force: :cascade do |t|
    t.string   "customer_code",          limit: 15,                               null: false
    t.string   "app_code",               limit: 50,                               null: false
    t.string   "notify_url",             limit: 100
    t.string   "validate_url",           limit: 100
    t.string   "http_username",          limit: 100
    t.string   "http_password"
    t.integer  "max_retries_for_notify",             precision: 38, default: 3
    t.integer  "retry_notify_in_mins",               precision: 38, default: 3
    t.integer  "settings_cnt",           limit: nil
    t.string   "setting1"
    t.string   "setting2"
    t.string   "setting3"
    t.string   "setting4"
    t.string   "setting5"
    t.datetime "created_at",                                                      null: false
    t.datetime "updated_at",                                                      null: false
    t.string   "created_by",             limit: 20
    t.string   "updated_by",             limit: 20
    t.integer  "lock_version",                       precision: 38, default: 0,   null: false
    t.string   "last_action",            limit: 1,                  default: "C", null: false
    t.string   "approval_status",        limit: 1,                  default: "U", null: false
    t.integer  "approved_version",                   precision: 38
    t.integer  "approved_id",            limit: nil
    t.string   "is_enabled",             limit: 1,                  default: "Y", null: false
    t.integer  "template_code",                      precision: 38,               null: false
    t.string   "use_proxy",              limit: 1,                  default: "Y", null: false
    t.string   "setting6"
    t.string   "setting7"
    t.string   "setting8"
    t.string   "setting9"
    t.string   "setting10"
    t.string   "customer_name",          limit: 100
  end

  add_index "icol_customers", ["customer_code", "template_code", "approval_status"], name: "icol_customers_01", unique: true

  create_table "icol_notifications", force: :cascade do |t|
    t.string   "app_code",         limit: 50
    t.string   "customer_code",    limit: 15
    t.string   "status_code",      limit: 100,                               null: false
    t.string   "company_name",     limit: 100,                               null: false
    t.integer  "txn_number",                    precision: 38,               null: false
    t.string   "txn_mode",         limit: 3,                                 null: false
    t.date     "txn_date",                                                   null: false
    t.string   "payment_status",   limit: 3,                                 null: false
    t.integer  "template_id",      limit: nil
    t.datetime "created_at",                                                 null: false
    t.string   "pending_approval", limit: 1,                                 null: false
    t.string   "fault_code",       limit: 50
    t.string   "fault_subcode",    limit: 50
    t.string   "fault_reason",     limit: 1000
    t.integer  "attempt_no",                    precision: 38
    t.integer  "company_id",       limit: nil
    t.datetime "updated_at"
    t.text     "fault_bitstream"
    t.text     "template_data",                                default: "a", null: false
  end

  add_index "icol_notifications", ["txn_number", "customer_code", "company_name"], name: "icol_notifications_01", unique: true

  create_table "icol_notify_steps", force: :cascade do |t|
    t.integer  "icol_notification_id", limit: nil,                 null: false
    t.string   "step_name",            limit: 100,                 null: false
    t.integer  "attempt_no",                        precision: 38, null: false
    t.string   "status_code",          limit: 100,                 null: false
    t.datetime "req_timestamp",                                    null: false
    t.string   "remote_host",          limit: 500
    t.string   "req_uri",              limit: 500
    t.datetime "rep_timestamp"
    t.string   "fault_code",           limit: 50
    t.string   "fault_subcode",        limit: 50
    t.string   "fault_reason",         limit: 1000
    t.text     "rep_header"
    t.text     "req_header"
    t.text     "req_bitstream",                                    null: false
    t.text     "rep_bitstream"
    t.text     "fault_bitstream"
  end

  add_index "icol_notify_steps", ["icol_notification_id", "step_name", "attempt_no"], name: "icol_notify_steps_01", unique: true

  create_table "icol_pending_notifications", force: :cascade do |t|
    t.string   "broker_uuid",          null: false
    t.string   "icol_notification_id", null: false
    t.datetime "created_at",           null: false
  end

  add_index "icol_pending_notifications", ["broker_uuid", "icol_notification_id"], name: "icol_p_notifications_01", unique: true

  create_table "icol_validate_steps", force: :cascade do |t|
    t.string   "step_name",        limit: 100,                 null: false
    t.string   "status_code",      limit: 100,                 null: false
    t.string   "app_code",         limit: 50
    t.string   "customer_code",    limit: 15
    t.datetime "req_timestamp",                                null: false
    t.datetime "rep_timestamp"
    t.datetime "up_req_timestamp"
    t.string   "up_host",          limit: 500
    t.string   "up_req_uri",       limit: 500
    t.datetime "up_rep_timestamp"
    t.string   "fault_code",       limit: 50
    t.string   "fault_subcode",    limit: 50
    t.string   "fault_reason",     limit: 1000
    t.text     "up_req_header"
    t.text     "up_rep_header"
    t.text     "up_req_bitstream"
    t.text     "up_rep_bitstream"
    t.text     "req_bitstream",                                null: false
    t.text     "rep_bitstream"
    t.text     "fault_bitstream"
    t.integer  "template_code",                 precision: 38
  end

  create_table "ifsc_details", force: :cascade do |t|
    t.string "ifsccode"
    t.string "last_mod_time"
  end

  create_table "imt_add_beneficiaries", force: :cascade do |t|
    t.string   "req_no",                                        null: false
    t.integer  "attempt_no",                     precision: 38, null: false
    t.string   "status_code",       limit: 25,                  null: false
    t.string   "req_version",       limit: 10,                  null: false
    t.datetime "req_timestamp",                                 null: false
    t.string   "app_id",            limit: 50,                  null: false
    t.string   "customer_id",       limit: 50,                  null: false
    t.string   "bene_mobile_no",    limit: 50,                  null: false
    t.string   "bene_name",         limit: 50,                  null: false
    t.string   "bene_address_line",                             null: false
    t.string   "bene_city",                                     null: false
    t.string   "bene_postal_code",                              null: false
    t.string   "rep_no"
    t.string   "rep_version",       limit: 10
    t.datetime "rep_timestamp"
    t.string   "fault_code",        limit: 50
    t.string   "fault_reason",      limit: 1000
    t.string   "fault_subcode",     limit: 50
  end

  add_index "imt_add_beneficiaries", ["customer_id", "app_id", "req_no", "attempt_no", "status_code", "req_timestamp", "rep_timestamp"], name: "imt_add_beneficiaries_01"
  add_index "imt_add_beneficiaries", ["req_no", "app_id", "attempt_no"], name: "uk_imt_add_bene", unique: true

  create_table "imt_audit_logs", force: :cascade do |t|
    t.string   "req_no",             limit: 32,                  null: false
    t.string   "app_id",             limit: 32,                  null: false
    t.integer  "attempt_no",                      precision: 38, null: false
    t.string   "status_code",        limit: 25,                  null: false
    t.string   "imt_auditable_type",                             null: false
    t.integer  "imt_auditable_id",   limit: nil,                 null: false
    t.string   "fault_code"
    t.string   "fault_reason",       limit: 1000
    t.datetime "req_timestamp"
    t.datetime "rep_timestamp"
    t.text     "req_bitstream",                                  null: false
    t.text     "rep_bitstream"
    t.text     "fault_bitstream"
    t.string   "fault_subcode",      limit: 50
  end

  add_index "imt_audit_logs", ["app_id", "req_no", "attempt_no", "imt_auditable_type"], name: "uk_imt_audit_logs_1", unique: true
  add_index "imt_audit_logs", ["imt_auditable_type", "imt_auditable_id"], name: "uk_imt_audit_logs_2", unique: true

  create_table "imt_audit_steps", force: :cascade do |t|
    t.string   "imt_auditable_type",                             null: false
    t.integer  "imt_auditable_id",   limit: nil,                 null: false
    t.integer  "step_no",                         precision: 38, null: false
    t.integer  "attempt_no",                      precision: 38, null: false
    t.string   "step_name",          limit: 100,                 null: false
    t.string   "status_code",        limit: 25,                  null: false
    t.string   "fault_code"
    t.string   "fault_reason",       limit: 1000
    t.string   "req_reference"
    t.datetime "req_timestamp"
    t.string   "rep_reference"
    t.datetime "rep_timestamp"
    t.text     "req_bitstream"
    t.text     "rep_bitstream"
    t.text     "fault_bitstream"
    t.string   "fault_subcode",      limit: 50
    t.datetime "reconciled_at"
  end

  add_index "imt_audit_steps", ["imt_auditable_type", "imt_auditable_id", "step_no", "attempt_no"], name: "uk_imt_audit_steps", unique: true

  create_table "imt_cancel_transfers", force: :cascade do |t|
    t.string   "req_no",                                                     null: false
    t.integer  "attempt_no",                    precision: 38,               null: false
    t.string   "status_code",      limit: 25,                                null: false
    t.string   "req_version",      limit: 10,                                null: false
    t.datetime "req_timestamp",                                              null: false
    t.string   "app_id",           limit: 50,                                null: false
    t.string   "customer_id",      limit: 50,                                null: false
    t.string   "req_ref_no",       limit: 50,                                null: false
    t.string   "cancel_reason",    limit: 50,                                null: false
    t.string   "rep_no"
    t.string   "rep_version",      limit: 10
    t.datetime "rep_timestamp"
    t.string   "imt_ref_no"
    t.string   "bank_ref_no"
    t.string   "fault_code",       limit: 50
    t.string   "fault_reason",     limit: 1000
    t.string   "fault_subcode",    limit: 50
    t.string   "pending_approval", limit: 1,                   default: "Y"
  end

  add_index "imt_cancel_transfers", ["bank_ref_no"], name: "i_imt_can_tra_ban_ref_no", unique: true
  add_index "imt_cancel_transfers", ["customer_id", "app_id", "req_no", "attempt_no", "status_code", "req_timestamp", "rep_timestamp"], name: "imt_cancel_transfers_01"
  add_index "imt_cancel_transfers", ["req_no", "app_id", "attempt_no"], name: "uk_imt_cancel_trans", unique: true

  create_table "imt_customers", force: :cascade do |t|
    t.string   "customer_code",                                                 null: false
    t.string   "customer_name",                                                 null: false
    t.string   "contact_person",                                                null: false
    t.string   "email_id",                                                      null: false
    t.string   "is_enabled",           limit: 1,                                null: false
    t.string   "mobile_no",                                                     null: false
    t.string   "account_no",                                                    null: false
    t.integer  "expiry_period",                    precision: 38,               null: false
    t.string   "txn_mode",             limit: 4,                                null: false
    t.string   "address_line1"
    t.string   "address_line2"
    t.string   "address_line3"
    t.string   "country"
    t.integer  "lock_version",                     precision: 38,               null: false
    t.string   "approval_status",      limit: 1,                  default: "U", null: false
    t.string   "last_action",                                     default: "C"
    t.integer  "approved_version",                 precision: 38
    t.integer  "approved_id",          limit: nil
    t.string   "created_by",           limit: 20
    t.string   "updated_by",           limit: 20
    t.datetime "created_at",                                                    null: false
    t.datetime "updated_at",                                                    null: false
    t.string   "app_id",                                                        null: false
    t.string   "identity_user_id",     limit: 20,                               null: false
    t.datetime "notification_sent_at"
  end

  add_index "imt_customers", ["account_no"], name: "i_imt_customers_account_no"
  add_index "imt_customers", ["app_id", "approval_status"], name: "uk1_imt_customers", unique: true
  add_index "imt_customers", ["customer_code"], name: "i_imt_customers_customer_code"
  add_index "imt_customers", ["customer_name"], name: "i_imt_customers_customer_name"

  create_table "imt_del_beneficiaries", force: :cascade do |t|
    t.string   "req_no",                                     null: false
    t.integer  "attempt_no",                  precision: 38, null: false
    t.string   "status_code",    limit: 25,                  null: false
    t.string   "req_version",    limit: 10,                  null: false
    t.datetime "req_timestamp",                              null: false
    t.string   "app_id",         limit: 50,                  null: false
    t.string   "customer_id",    limit: 50,                  null: false
    t.string   "bene_mobile_no", limit: 50,                  null: false
    t.string   "rep_no"
    t.string   "rep_version",    limit: 10
    t.datetime "rep_timestamp"
    t.string   "fault_code",     limit: 50
    t.string   "fault_reason",   limit: 1000
    t.string   "fault_subcode",  limit: 50
  end

  add_index "imt_del_beneficiaries", ["customer_id", "app_id", "req_no", "attempt_no", "status_code", "req_timestamp", "rep_timestamp"], name: "imt_del_beneficiaries_01"
  add_index "imt_del_beneficiaries", ["req_no", "app_id", "attempt_no"], name: "uk_imt_del_bene", unique: true

  create_table "imt_incoming_files", force: :cascade do |t|
    t.string "file_name", limit: 100
  end

  add_index "imt_incoming_files", ["file_name"], name: "imt_incoming_files_01", unique: true

  create_table "imt_incoming_records", force: :cascade do |t|
    t.integer  "incoming_file_record_id", limit: nil,                null: false
    t.string   "file_name",               limit: 50,                 null: false
    t.integer  "record_no",                           precision: 38
    t.string   "issuing_bank"
    t.string   "acquiring_bank"
    t.string   "imt_ref_no"
    t.date     "txn_issue_date"
    t.date     "txn_acquire_date"
    t.date     "chargeback_action_date"
    t.string   "issuing_bank_txn_id"
    t.string   "acquiring_bank_txn_id"
    t.string   "txn_status"
    t.string   "crdr"
    t.decimal  "transfer_amount"
    t.decimal  "acquiring_fee"
    t.decimal  "sc_on_acquiring_fee"
    t.decimal  "npci_charges"
    t.decimal  "sc_on_npci_charges"
    t.string   "total_net_position",      limit: 50
    t.datetime "settlement_at"
    t.string   "settlement_status",       limit: 15
    t.integer  "settlement_attempt_no",               precision: 38
    t.string   "settlement_bank_ref"
    t.string   "txn_acquire_time"
    t.string   "acquiring_txn_id"
    t.string   "atm_id",                  limit: 20
    t.string   "channel_id",              limit: 50
  end

  add_index "imt_incoming_records", ["incoming_file_record_id", "file_name"], name: "imt_incoming_records_01", unique: true

  create_table "imt_initiate_transfers", force: :cascade do |t|
    t.string   "req_no",                                                      null: false
    t.integer  "attempt_no",                     precision: 38,               null: false
    t.string   "status_code",       limit: 25,                                null: false
    t.string   "req_version",       limit: 10,                                null: false
    t.datetime "req_timestamp",                                               null: false
    t.string   "app_id",            limit: 50,                                null: false
    t.string   "customer_id",       limit: 50,                                null: false
    t.string   "bene_mobile_no",    limit: 50,                                null: false
    t.string   "pass_code",         limit: 5,                                 null: false
    t.string   "rmtr_to_bene_note",                                           null: false
    t.date     "expiry_date"
    t.string   "rep_no"
    t.string   "rep_version",       limit: 10
    t.datetime "rep_timestamp"
    t.string   "imt_ref_no"
    t.string   "bank_ref_no"
    t.string   "fault_code",        limit: 50
    t.string   "fault_reason",      limit: 1000
    t.string   "fault_subcode",     limit: 50
    t.string   "pending_approval",  limit: 1,                   default: "Y"
    t.decimal  "transfer_amount",                                             null: false
  end

  add_index "imt_initiate_transfers", ["bank_ref_no"], name: "i_imt_ini_tra_ban_ref_no", unique: true
  add_index "imt_initiate_transfers", ["customer_id", "app_id", "req_no", "attempt_no", "status_code", "req_timestamp", "rep_timestamp"], name: "imt_initiate_transfers_01"
  add_index "imt_initiate_transfers", ["req_no", "app_id", "attempt_no"], name: "uk_imt_tranfers", unique: true

  create_table "imt_initiate_withdrawals", force: :cascade do |t|
    t.string   "req_no",          limit: 32,                  null: false
    t.integer  "attempt_no",                   precision: 38, null: false
    t.string   "req_version",     limit: 10,                  null: false
    t.datetime "req_timestamp",                               null: false
    t.string   "app_id",          limit: 50,                  null: false
    t.string   "status_code",     limit: 25,                  null: false
    t.string   "partner_code",    limit: 20,                  null: false
    t.string   "bc_agent_id",     limit: 20,                  null: false
    t.string   "bene_mobile_no",  limit: 20,                  null: false
    t.decimal  "withdraw_amount",                             null: false
    t.string   "passcode1",       limit: 4,                   null: false
    t.string   "passcode2",       limit: 4,                   null: false
    t.string   "bank_ref_no",     limit: 20,                  null: false
    t.string   "rep_no",          limit: 32
    t.string   "rep_version",     limit: 10
    t.string   "imt_ref_no",      limit: 20
    t.string   "withdraw_ref_no", limit: 20
    t.datetime "rep_timestamp"
    t.string   "fault_code",      limit: 50
    t.string   "fault_subcode",   limit: 50
    t.string   "fault_reason",    limit: 1000
  end

  add_index "imt_initiate_withdrawals", ["req_no", "app_id", "attempt_no"], name: "imt_initiate_withdrawals_01", unique: true

  create_table "imt_partners", force: :cascade do |t|
    t.string   "partner_code",     limit: 20,                               null: false
    t.string   "app_id",           limit: 50,                               null: false
    t.string   "partner_name",     limit: 100,                              null: false
    t.string   "gl_account",       limit: 15
    t.string   "is_enabled",       limit: 1,                  default: "Y", null: false
    t.datetime "created_at",                                                null: false
    t.datetime "updated_at",                                                null: false
    t.string   "created_by",       limit: 20
    t.string   "updated_by",       limit: 20
    t.integer  "lock_version",                 precision: 38, default: 0,   null: false
    t.string   "last_action",      limit: 1,                  default: "C", null: false
    t.string   "approval_status",  limit: 1,                  default: "U", null: false
    t.integer  "approved_version",             precision: 38
    t.integer  "approved_id",      limit: nil
  end

  add_index "imt_partners", ["partner_code", "app_id", "approval_status"], name: "imt_partners_01", unique: true

  create_table "imt_pending_settlements", force: :cascade do |t|
    t.string   "app_uuid",                      null: false
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.integer  "imt_withdrawal_id", limit: nil
  end

  add_index "imt_pending_settlements", ["app_uuid", "created_at"], name: "imt_pending_settlements_02"

  create_table "imt_pending_steps", force: :cascade do |t|
    t.string   "broker_uuid",                               null: false
    t.datetime "created_at",                                null: false
    t.integer  "imt_audit_step_id", limit: nil, default: 1, null: false
  end

  create_table "imt_pending_withdraw_reversals", force: :cascade do |t|
    t.string   "app_uuid",                      null: false
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.integer  "imt_withdrawal_id", limit: nil
  end

  add_index "imt_pending_withdraw_reversals", ["app_uuid", "created_at"], name: "imt_pending_reversals_02"

  create_table "imt_resend_otp", force: :cascade do |t|
    t.string   "req_no",               limit: 30,                  null: false
    t.integer  "attempt_no",                        precision: 38, null: false
    t.string   "status_code",          limit: 25,                  null: false
    t.string   "req_version",          limit: 10,                  null: false
    t.datetime "req_timestamp",                                    null: false
    t.string   "app_id",               limit: 50,                  null: false
    t.string   "customer_id",          limit: 50,                  null: false
    t.string   "imt_ref_no",           limit: 32
    t.string   "initiate_transfer_no", limit: 50,                  null: false
    t.string   "rep_no",               limit: 32
    t.string   "rep_version",          limit: 10
    t.integer  "otp_attempt_no",                    precision: 38
    t.datetime "rep_timestamp"
    t.string   "fault_code",           limit: 50
    t.string   "fault_subcode",        limit: 50
    t.string   "fault_reason",         limit: 1000
  end

  add_index "imt_resend_otp", ["customer_id", "app_id", "req_no", "attempt_no", "status_code", "req_timestamp", "rep_timestamp"], name: "imt_resend_otp_01"
  add_index "imt_resend_otp", ["req_no", "app_id", "attempt_no"], name: "uk_imt_resend_otp", unique: true

  create_table "imt_rules", force: :cascade do |t|
    t.string   "stl_gl_account",                limit: 16,                               null: false
    t.string   "chargeback_gl_account",         limit: 16,                               null: false
    t.datetime "created_at",                                                             null: false
    t.datetime "updated_at",                                                             null: false
    t.string   "created_by",                    limit: 20
    t.string   "updated_by",                    limit: 20
    t.integer  "lock_version",                              precision: 38, default: 0,   null: false
    t.string   "last_action",                   limit: 1,                  default: "C", null: false
    t.string   "approval_status",               limit: 1,                  default: "U", null: false
    t.integer  "approved_version",                          precision: 38
    t.integer  "approved_id",                   limit: nil
    t.string   "bc_gl_account",                 limit: 15
    t.string   "rbi_stl_gl_account",            limit: 15
    t.integer  "reverse_withdraw_till_in_mins",             precision: 38
  end

  create_table "imt_transfers", force: :cascade do |t|
    t.string   "imt_ref_no",              limit: 35
    t.string   "status_code",             limit: 25,                 null: false
    t.string   "customer_id",             limit: 50,                 null: false
    t.string   "bene_mobile_no",          limit: 50,                 null: false
    t.string   "rmtr_to_bene_note",                                  null: false
    t.date     "expiry_date"
    t.datetime "initiated_at"
    t.string   "initiation_ref_no",       limit: 64,                 null: false
    t.datetime "completed_at"
    t.string   "acquiring_bank"
    t.datetime "cancelled_at"
    t.string   "cancellation_ref_no",     limit: 64
    t.datetime "expired_at"
    t.string   "cancel_reason"
    t.string   "initiation_bank_ref",                                null: false
    t.string   "cancellation_bank_ref"
    t.decimal  "transfer_amount",                                    null: false
    t.string   "app_id",                  limit: 20,                 null: false
    t.datetime "settlement_at"
    t.string   "settlement_status",       limit: 15
    t.integer  "settlement_attempt_no",               precision: 38
    t.string   "settlement_bank_ref"
    t.integer  "incoming_file_record_id", limit: nil
    t.string   "file_name",               limit: 100
  end

  add_index "imt_transfers", ["cancellation_ref_no"], name: "uk_imt_transfers_3", unique: true
  add_index "imt_transfers", ["imt_ref_no"], name: "uk_imt_transfers_1", unique: true
  add_index "imt_transfers", ["initiation_ref_no"], name: "uk_imt_transfers_2", unique: true

  create_table "imt_unapproved_records", force: :cascade do |t|
    t.integer  "imt_approvable_id",   limit: nil
    t.string   "imt_approvable_type"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
  end

  create_table "imt_withdraw_reversals", force: :cascade do |t|
    t.string   "req_no",                   limit: 32,                  null: false
    t.integer  "attempt_no",                            precision: 38, null: false
    t.string   "req_version",              limit: 10,                  null: false
    t.datetime "req_timestamp",                                        null: false
    t.string   "app_id",                   limit: 50,                  null: false
    t.string   "partner_code",             limit: 20,                  null: false
    t.string   "status_code",              limit: 25,                  null: false
    t.string   "bank_ref_no",              limit: 20,                  null: false
    t.string   "rep_no",                   limit: 32
    t.string   "rep_version",              limit: 10
    t.string   "withdraw_reversal_ref_no", limit: 20
    t.datetime "rep_timestamp"
    t.string   "fault_code",               limit: 50
    t.string   "fault_subcode",            limit: 50
    t.string   "fault_reason",             limit: 1000
  end

  add_index "imt_withdraw_reversals", ["req_no", "app_id", "attempt_no"], name: "imt_withdraw_reversals_01", unique: true

  create_table "imt_withdrawals", force: :cascade do |t|
    t.string   "req_no",                   limit: 32,                               null: false
    t.datetime "req_timestamp",                                                     null: false
    t.string   "app_id",                   limit: 50,                               null: false
    t.string   "status_code",              limit: 25,                               null: false
    t.string   "partner_code",             limit: 20,                               null: false
    t.string   "bc_agent_id",              limit: 20,                               null: false
    t.string   "bene_mobile_no",           limit: 20,                               null: false
    t.decimal  "withdraw_amount",                                                   null: false
    t.string   "is_onus",                  limit: 1
    t.string   "imt_ref_no",               limit: 20
    t.datetime "reversed_at"
    t.datetime "settlement_at"
    t.string   "settlement_status",        limit: 25
    t.integer  "settlement_attempt_no",                precision: 38
    t.string   "settlement_bank_ref"
    t.integer  "imt_withdraw_reverse_id",  limit: nil
    t.string   "pending_approval",         limit: 1,                  default: "f"
    t.string   "issuing_bank"
    t.string   "acquiring_bank"
    t.string   "atm_id",                   limit: 20
    t.string   "channel_id",               limit: 50
    t.integer  "incoming_file_record_id",  limit: nil
    t.string   "file_name",                limit: 100
    t.integer  "imt_initiate_withdraw_id", limit: nil
    t.datetime "withdrawn_at"
    t.string   "initiate_bank_ref_no",                                              null: false
    t.string   "reversal_bank_ref_no",     limit: 20
    t.integer  "reversal_attempt_no",                  precision: 38
  end

  add_index "imt_withdrawals", ["app_id", "partner_code", "req_no"], name: "uk_imt_withdrawals_c", unique: true
  add_index "imt_withdrawals", ["imt_initiate_withdraw_id"], name: "uk_imt_withdrawals_d", unique: true
  add_index "imt_withdrawals", ["imt_withdraw_reverse_id"], name: "uk_imt_withdrawals_e", unique: true
  add_index "imt_withdrawals", ["initiate_bank_ref_no"], name: "uk_imt_withdrawals_a", unique: true
  add_index "imt_withdrawals", ["reversal_bank_ref_no"], name: "uk_imt_withdrawals_b", unique: true

  create_table "incoming_file_records", force: :cascade do |t|
    t.integer  "incoming_file_id",    limit: nil
    t.integer  "record_no",                       precision: 38
    t.text     "record_txt"
    t.string   "status",              limit: 20
    t.string   "fault_code",          limit: 50
    t.string   "fault_reason",        limit: 500
    t.datetime "created_at",                                     null: false
    t.datetime "updated_at",                                     null: false
    t.string   "fault_subcode",       limit: 50
    t.text     "fault_bitstream"
    t.string   "rep_status",          limit: 50
    t.string   "rep_fault_subcode",   limit: 50
    t.string   "rep_fault_reason",    limit: 500
    t.text     "rep_fault_bitstream"
    t.string   "overrides",           limit: 50
    t.integer  "attempt_no",                      precision: 38
    t.string   "rep_fault_code",      limit: 50
  end

  add_index "incoming_file_records", ["incoming_file_id", "record_no"], name: "uk_inc_file_records", unique: true

  create_table "incoming_file_types", force: :cascade do |t|
    t.integer "sc_service_id",                limit: nil,               null: false
    t.string  "code",                         limit: 50,                null: false
    t.string  "name",                         limit: 50,                null: false
    t.string  "msg_domain"
    t.string  "msg_model"
    t.string  "validate_all",                 limit: 1,   default: "f"
    t.string  "auto_upload",                  limit: 1,   default: "f"
    t.string  "skip_first",                   limit: 1,   default: "f"
    t.string  "build_response_file",          limit: 1
    t.string  "correlation_field"
    t.string  "db_unit_name"
    t.string  "records_table"
    t.string  "can_override",                 limit: 1,   default: "f", null: false
    t.string  "can_skip",                     limit: 1,   default: "f", null: false
    t.string  "can_retry",                    limit: 1,   default: "f", null: false
    t.string  "build_nack_file",              limit: 1,   default: "f", null: false
    t.string  "skip_last",                    limit: 1,   default: "f", null: false
    t.string  "complete_with_failed_records", limit: 1,   default: "Y", null: false
    t.string  "apprv_before_process_records", limit: 1,   default: "f"
    t.decimal "max_file_size"
    t.string  "finish_each_file",             limit: 1,   default: "f", null: false
    t.string  "is_file_mapper",               limit: 1,   default: "f", null: false
  end

  add_index "incoming_file_types", ["sc_service_id", "code"], name: "uk_in_file_types_1", unique: true

  create_table "incoming_files", force: :cascade do |t|
    t.string   "service_name"
    t.string   "file_type"
    t.string   "file"
    t.string   "file_name",                  limit: 100
    t.integer  "size_in_bytes",                           precision: 38
    t.integer  "line_count",                              precision: 38
    t.string   "status",                     limit: 1
    t.datetime "started_at"
    t.datetime "ended_at"
    t.string   "created_by",                 limit: 20
    t.string   "updated_by",                 limit: 20
    t.datetime "created_at",                                                           null: false
    t.datetime "updated_at"
    t.string   "fault_code",                 limit: 50
    t.string   "fault_reason",               limit: 1000
    t.string   "approval_status",            limit: 1,                   default: "U", null: false
    t.string   "last_action",                limit: 1,                   default: "C"
    t.integer  "approved_version",                        precision: 38
    t.integer  "approved_id",                limit: nil
    t.integer  "lock_version",                            precision: 38
    t.string   "broker_uuid"
    t.integer  "failed_record_count",                     precision: 38
    t.string   "fault_subcode",              limit: 50
    t.string   "rep_file_name"
    t.string   "rep_file_path"
    t.string   "rep_file_status",            limit: 1
    t.string   "pending_approval",           limit: 1
    t.string   "file_path"
    t.string   "last_process_step",          limit: 1
    t.integer  "record_count",                            precision: 38
    t.integer  "skipped_record_count",                    precision: 38
    t.integer  "completed_record_count",                  precision: 38
    t.integer  "timedout_record_count",                   precision: 38
    t.integer  "alert_count",                             precision: 38
    t.datetime "last_alert_at"
    t.integer  "bad_record_count",                        precision: 38
    t.text     "fault_bitstream"
    t.integer  "pending_retry_record_count",              precision: 38
    t.integer  "overriden_record_count",                  precision: 38
    t.string   "nack_file_name",             limit: 150
    t.string   "nack_file_path"
    t.string   "nack_file_status",           limit: 1
    t.text     "header_record"
    t.string   "rejection_type"
  end

  add_index "incoming_files", ["file_name", "approval_status"], name: "i_inc_fil_fil_nam_app_sta", unique: true
  add_index "incoming_files", ["service_name", "status", "pending_approval"], name: "in_incoming_files_2"

  create_table "incoming_files_bkp", id: false, force: :cascade do |t|
    t.integer  "id",                         limit: nil,                 null: false
    t.string   "service_name"
    t.string   "file_type"
    t.string   "file"
    t.string   "file_name",                  limit: 100
    t.integer  "size_in_bytes",                           precision: 38
    t.integer  "line_count",                              precision: 38
    t.string   "status",                     limit: 1
    t.datetime "started_at"
    t.datetime "ended_at"
    t.string   "created_by",                 limit: 20
    t.string   "updated_by",                 limit: 20
    t.datetime "created_at",                                             null: false
    t.datetime "updated_at"
    t.string   "fault_code",                 limit: 50
    t.string   "fault_reason",               limit: 1000
    t.string   "approval_status",            limit: 1,                   null: false
    t.string   "last_action",                limit: 1
    t.integer  "approved_version",                        precision: 38
    t.integer  "approved_id",                limit: nil
    t.integer  "lock_version",                            precision: 38
    t.string   "broker_uuid"
    t.integer  "failed_record_count",                     precision: 38
    t.string   "fault_subcode",              limit: 50
    t.string   "rep_file_name"
    t.string   "rep_file_path"
    t.string   "rep_file_status",            limit: 1
    t.string   "pending_approval",           limit: 1
    t.string   "file_path"
    t.string   "last_process_step",          limit: 1
    t.integer  "record_count",                            precision: 38
    t.integer  "skipped_record_count",                    precision: 38
    t.integer  "completed_record_count",                  precision: 38
    t.integer  "timedout_record_count",                   precision: 38
    t.integer  "alert_count",                             precision: 38
    t.datetime "last_alert_at"
    t.integer  "bad_record_count",                        precision: 38
    t.text     "fault_bitstream"
    t.integer  "pending_retry_record_count",              precision: 38
    t.integer  "overriden_record_count",                  precision: 38
    t.string   "nack_file_name",             limit: 150
    t.string   "nack_file_path"
    t.string   "nack_file_status",           limit: 1
    t.text     "header_record"
  end

  create_table "incoming_rej_files", force: :cascade do |t|
    t.datetime "started_at"
    t.datetime "ended_at"
    t.datetime "alert_at"
    t.string   "alert_ref",       limit: 50
    t.string   "file_name",       limit: 100
    t.string   "fault_code",      limit: 50
    t.string   "fault_subcode",   limit: 50
    t.string   "fault_reason",    limit: 1000
    t.text     "fault_bitstream"
  end

  add_index "incoming_rej_files", ["alert_ref"], name: "incoming_rej_files_01", unique: true

  create_table "inw_aud_log_bkp_181001to181231", id: false, force: :cascade do |t|
    t.integer "id",                   limit: nil, null: false
    t.integer "inward_remittance_id", limit: nil
    t.text    "request_bitstream"
    t.text    "reply_bitstream"
  end

  create_table "inw_aud_log_bkp_181101to181218", id: false, force: :cascade do |t|
    t.integer "id",                   limit: nil, null: false
    t.integer "inward_remittance_id", limit: nil
    t.text    "request_bitstream"
    t.text    "reply_bitstream"
  end

  create_table "inw_aud_log_bkp_181101to181231", id: false, force: :cascade do |t|
    t.integer "id",                   limit: nil, null: false
    t.integer "inward_remittance_id", limit: nil
    t.text    "request_bitstream"
    t.text    "reply_bitstream"
  end

  create_table "inw_aud_log_bkp_181203to181218", id: false, force: :cascade do |t|
    t.integer "id",                   limit: nil, null: false
    t.integer "inward_remittance_id", limit: nil
    t.text    "request_bitstream"
    t.text    "reply_bitstream"
  end

  create_table "inw_aud_log_bkp_190101to190131", id: false, force: :cascade do |t|
    t.integer "id",                   limit: nil, null: false
    t.integer "inward_remittance_id", limit: nil
    t.text    "request_bitstream"
    t.text    "reply_bitstream"
  end

  create_table "inw_aud_log_bkp_190207to190220", id: false, force: :cascade do |t|
    t.integer "id",                   limit: nil, null: false
    t.integer "inward_remittance_id", limit: nil
    t.text    "request_bitstream"
    t.text    "reply_bitstream"
  end

  create_table "inw_aud_ste_bkp_181102to181230", id: false, force: :cascade do |t|
    t.integer  "id",                 limit: nil,                 null: false
    t.string   "inw_auditable_type",                             null: false
    t.integer  "inw_auditable_id",   limit: nil,                 null: false
    t.integer  "step_no",                         precision: 38, null: false
    t.integer  "attempt_no",                      precision: 38, null: false
    t.string   "step_name",          limit: 100,                 null: false
    t.string   "status_code",        limit: 30,                  null: false
    t.string   "fault_code"
    t.string   "fault_subcode",      limit: 50
    t.string   "fault_reason",       limit: 1000
    t.string   "req_reference"
    t.datetime "req_timestamp"
    t.string   "rep_reference"
    t.datetime "rep_timestamp"
    t.text     "req_bitstream"
    t.text     "rep_bitstream"
    t.text     "fault_bitstream"
    t.string   "remote_host",        limit: 500
    t.string   "req_uri",            limit: 500
  end

  create_table "inw_aud_ste_bkp_190101to190131", id: false, force: :cascade do |t|
    t.integer  "id",                 limit: nil,                 null: false
    t.string   "inw_auditable_type",                             null: false
    t.integer  "inw_auditable_id",   limit: nil,                 null: false
    t.integer  "step_no",                         precision: 38, null: false
    t.integer  "attempt_no",                      precision: 38, null: false
    t.string   "step_name",          limit: 100,                 null: false
    t.string   "status_code",        limit: 30,                  null: false
    t.string   "fault_code"
    t.string   "fault_subcode",      limit: 50
    t.string   "fault_reason",       limit: 1000
    t.string   "req_reference"
    t.datetime "req_timestamp"
    t.string   "rep_reference"
    t.datetime "rep_timestamp"
    t.text     "req_bitstream"
    t.text     "rep_bitstream"
    t.text     "fault_bitstream"
    t.string   "remote_host",        limit: 500
    t.string   "req_uri",            limit: 500
  end

  create_table "inw_audit_logs", force: :cascade do |t|
    t.integer "inward_remittance_id", limit: nil
    t.text    "request_bitstream"
    t.text    "reply_bitstream"
  end

  add_index "inw_audit_logs", ["inward_remittance_id"], name: "inw_audit_logs_01", unique: true

  create_table "inw_audit_steps", force: :cascade do |t|
    t.string   "inw_auditable_type",                             null: false
    t.integer  "inw_auditable_id",   limit: nil,                 null: false
    t.integer  "step_no",                         precision: 38, null: false
    t.integer  "attempt_no",                      precision: 38, null: false
    t.string   "step_name",          limit: 100,                 null: false
    t.string   "status_code",        limit: 30,                  null: false
    t.string   "fault_code"
    t.string   "fault_subcode",      limit: 50
    t.string   "fault_reason",       limit: 1000
    t.string   "req_reference"
    t.datetime "req_timestamp"
    t.string   "rep_reference"
    t.datetime "rep_timestamp"
    t.text     "req_bitstream"
    t.text     "rep_bitstream"
    t.text     "fault_bitstream"
    t.string   "remote_host",        limit: 500
    t.string   "req_uri",            limit: 500
  end

  add_index "inw_audit_steps", ["inw_auditable_type", "inw_auditable_id", "step_no", "attempt_no"], name: "uk_inw_audit_steps", unique: true

  create_table "inw_cbs_response_codes", force: :cascade do |t|
    t.string   "cbs_name"
    t.string   "function_name"
    t.string   "response_code"
    t.string   "consider_as"
    t.string   "created_by"
    t.string   "updated_by"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "inw_guidelines", force: :cascade do |t|
    t.string   "code",                limit: 5,                                null: false
    t.string   "allow_neft",          limit: 1,                  default: "Y", null: false
    t.string   "allow_imps",          limit: 1,                  default: "Y", null: false
    t.string   "allow_rtgs",          limit: 1,                  default: "Y", null: false
    t.integer  "ytd_txn_cnt_bene",                precision: 38
    t.text     "disallowed_products"
    t.string   "needs_lcy_rate",      limit: 1,                  default: "f", null: false
    t.string   "is_enabled",          limit: 1,                  default: "Y", null: false
    t.datetime "created_at",                                                   null: false
    t.datetime "updated_at",                                                   null: false
    t.string   "created_by",          limit: 20
    t.string   "updated_by",          limit: 20
    t.integer  "lock_version",                    precision: 38, default: 0,   null: false
    t.string   "approval_status",     limit: 1,                  default: "U", null: false
    t.string   "last_action",         limit: 1,                  default: "C", null: false
    t.integer  "approved_version",                precision: 38
    t.integer  "approved_id",         limit: nil
  end

  add_index "inw_guidelines", ["code", "approval_status"], name: "inw_guidelines_01", unique: true

  create_table "inw_guidelines_bkp", id: false, force: :cascade do |t|
    t.integer  "id",                  limit: nil,                null: false
    t.string   "code",                limit: 5,                  null: false
    t.string   "allow_neft",          limit: 1,                  null: false
    t.string   "allow_imps",          limit: 1,                  null: false
    t.string   "allow_rtgs",          limit: 1,                  null: false
    t.integer  "ytd_txn_cnt_bene",                precision: 38
    t.text     "disallowed_products"
    t.string   "needs_lcy_rate",      limit: 1,                  null: false
    t.string   "is_enabled",          limit: 1,                  null: false
    t.datetime "created_at",                                     null: false
    t.datetime "updated_at",                                     null: false
    t.string   "created_by",          limit: 20
    t.string   "updated_by",          limit: 20
    t.integer  "lock_version",                    precision: 38, null: false
    t.string   "approval_status",     limit: 1,                  null: false
    t.string   "last_action",         limit: 1,                  null: false
    t.integer  "approved_version",                precision: 38
    t.integer  "approved_id",         limit: nil
  end

  create_table "inw_identities", force: :cascade do |t|
    t.string   "id_for",                  limit: 20,  null: false
    t.string   "id_type",                 limit: 30
    t.string   "id_number",               limit: 50
    t.string   "id_country"
    t.date     "id_issue_date"
    t.date     "id_expiry_date"
    t.datetime "verified_at"
    t.string   "verified_by",             limit: 20
    t.integer  "inw_remittance_id",       limit: nil
    t.integer  "whitelisted_identity_id", limit: nil
    t.string   "was_auto_matched"
    t.datetime "auto_matched_at"
  end

  create_table "inw_pending_confirmations", force: :cascade do |t|
    t.string   "broker_uuid",                    null: false
    t.string   "inw_auditable_type",             null: false
    t.integer  "inw_auditable_id",   limit: nil, null: false
    t.datetime "created_at",                     null: false
  end

  add_index "inw_pending_confirmations", ["broker_uuid", "created_at"], name: "inw_confirmations_02"
  add_index "inw_pending_confirmations", ["inw_auditable_type", "inw_auditable_id"], name: "inw_confirmations_01", unique: true

  create_table "inw_rem_bkp_181001to181231", id: false, force: :cascade do |t|
    t.integer  "id",                     limit: nil,                 null: false
    t.string   "req_no",                                             null: false
    t.string   "req_version",            limit: 10,                  null: false
    t.datetime "req_timestamp",                                      null: false
    t.string   "partner_code",           limit: 20,                  null: false
    t.string   "rmtr_full_name"
    t.string   "rmtr_address1"
    t.string   "rmtr_address2"
    t.string   "rmtr_address3"
    t.string   "rmtr_postal_code"
    t.string   "rmtr_city"
    t.string   "rmtr_state"
    t.string   "rmtr_country"
    t.string   "rmtr_email_id"
    t.string   "rmtr_mobile_no"
    t.integer  "rmtr_identity_count",                 precision: 38, null: false
    t.string   "bene_full_name"
    t.string   "bene_address1"
    t.string   "bene_address2"
    t.string   "bene_address3"
    t.string   "bene_postal_code"
    t.string   "bene_city"
    t.string   "bene_state"
    t.string   "bene_country"
    t.string   "bene_email_id"
    t.string   "bene_mobile_no"
    t.integer  "bene_identity_count",                 precision: 38, null: false
    t.string   "bene_account_no"
    t.string   "bene_account_ifsc"
    t.string   "transfer_type",          limit: 10
    t.string   "transfer_ccy",           limit: 5
    t.decimal  "transfer_amount"
    t.string   "rmtr_to_bene_note"
    t.string   "purpose_code",           limit: 5
    t.string   "status_code",            limit: 30
    t.string   "bank_ref",               limit: 50
    t.string   "rep_no"
    t.string   "rep_version",            limit: 10
    t.datetime "rep_timestamp"
    t.integer  "attempt_no",                          precision: 38, null: false
    t.datetime "updated_at"
    t.string   "beneficiary_type",       limit: 1
    t.string   "remitter_type",          limit: 1
    t.string   "fault_code",             limit: 50
    t.string   "fault_reason",           limit: 1000
    t.string   "is_self_transfer",       limit: 1
    t.string   "is_same_party_transfer", limit: 1
    t.string   "req_transfer_type",      limit: 10
    t.decimal  "bal_available"
    t.string   "service_id"
    t.datetime "reconciled_at"
    t.string   "cbs_req_ref_no"
    t.datetime "processed_at"
    t.string   "notify_status",          limit: 100
    t.integer  "notify_attempt_no",                   precision: 38
    t.datetime "notify_attempt_at"
    t.datetime "notified_at"
    t.string   "notify_result",          limit: 50
    t.string   "rmtr_code",              limit: 50
    t.string   "rmtr_needs_wl",          limit: 1
    t.integer  "rmtr_wl_id",             limit: nil
    t.string   "bene_needs_wl",          limit: 1
    t.integer  "bene_wl_id",             limit: nil
  end

  create_table "inw_rem_bkp_181102to181231", id: false, force: :cascade do |t|
    t.integer  "id",                     limit: nil,                 null: false
    t.string   "req_no",                                             null: false
    t.string   "req_version",            limit: 10,                  null: false
    t.datetime "req_timestamp",                                      null: false
    t.string   "partner_code",           limit: 20,                  null: false
    t.string   "rmtr_full_name"
    t.string   "rmtr_address1"
    t.string   "rmtr_address2"
    t.string   "rmtr_address3"
    t.string   "rmtr_postal_code"
    t.string   "rmtr_city"
    t.string   "rmtr_state"
    t.string   "rmtr_country"
    t.string   "rmtr_email_id"
    t.string   "rmtr_mobile_no"
    t.integer  "rmtr_identity_count",                 precision: 38, null: false
    t.string   "bene_full_name"
    t.string   "bene_address1"
    t.string   "bene_address2"
    t.string   "bene_address3"
    t.string   "bene_postal_code"
    t.string   "bene_city"
    t.string   "bene_state"
    t.string   "bene_country"
    t.string   "bene_email_id"
    t.string   "bene_mobile_no"
    t.integer  "bene_identity_count",                 precision: 38, null: false
    t.string   "bene_account_no"
    t.string   "bene_account_ifsc"
    t.string   "transfer_type",          limit: 10
    t.string   "transfer_ccy",           limit: 5
    t.decimal  "transfer_amount"
    t.string   "rmtr_to_bene_note"
    t.string   "purpose_code",           limit: 5
    t.string   "status_code",            limit: 30
    t.string   "bank_ref",               limit: 50
    t.string   "rep_no"
    t.string   "rep_version",            limit: 10
    t.datetime "rep_timestamp"
    t.integer  "attempt_no",                          precision: 38, null: false
    t.datetime "updated_at"
    t.string   "beneficiary_type",       limit: 1
    t.string   "remitter_type",          limit: 1
    t.string   "fault_code",             limit: 50
    t.string   "fault_reason",           limit: 1000
    t.string   "is_self_transfer",       limit: 1
    t.string   "is_same_party_transfer", limit: 1
    t.string   "req_transfer_type",      limit: 10
    t.decimal  "bal_available"
    t.string   "service_id"
    t.datetime "reconciled_at"
    t.string   "cbs_req_ref_no"
    t.datetime "processed_at"
    t.string   "notify_status",          limit: 100
    t.integer  "notify_attempt_no",                   precision: 38
    t.datetime "notify_attempt_at"
    t.datetime "notified_at"
    t.string   "notify_result",          limit: 50
    t.string   "rmtr_code",              limit: 50
    t.string   "rmtr_needs_wl",          limit: 1
    t.integer  "rmtr_wl_id",             limit: nil
    t.string   "bene_needs_wl",          limit: 1
    t.integer  "bene_wl_id",             limit: nil
  end

  create_table "inw_rem_bkp_181218to181231", id: false, force: :cascade do |t|
    t.integer  "id",                     limit: nil,                 null: false
    t.string   "req_no",                                             null: false
    t.string   "req_version",            limit: 10,                  null: false
    t.datetime "req_timestamp",                                      null: false
    t.string   "partner_code",           limit: 20,                  null: false
    t.string   "rmtr_full_name"
    t.string   "rmtr_address1"
    t.string   "rmtr_address2"
    t.string   "rmtr_address3"
    t.string   "rmtr_postal_code"
    t.string   "rmtr_city"
    t.string   "rmtr_state"
    t.string   "rmtr_country"
    t.string   "rmtr_email_id"
    t.string   "rmtr_mobile_no"
    t.integer  "rmtr_identity_count",                 precision: 38, null: false
    t.string   "bene_full_name"
    t.string   "bene_address1"
    t.string   "bene_address2"
    t.string   "bene_address3"
    t.string   "bene_postal_code"
    t.string   "bene_city"
    t.string   "bene_state"
    t.string   "bene_country"
    t.string   "bene_email_id"
    t.string   "bene_mobile_no"
    t.integer  "bene_identity_count",                 precision: 38, null: false
    t.string   "bene_account_no"
    t.string   "bene_account_ifsc"
    t.string   "transfer_type",          limit: 10
    t.string   "transfer_ccy",           limit: 5
    t.decimal  "transfer_amount"
    t.string   "rmtr_to_bene_note"
    t.string   "purpose_code",           limit: 5
    t.string   "status_code",            limit: 30
    t.string   "bank_ref",               limit: 50
    t.string   "rep_no"
    t.string   "rep_version",            limit: 10
    t.datetime "rep_timestamp"
    t.integer  "attempt_no",                          precision: 38, null: false
    t.datetime "updated_at"
    t.string   "beneficiary_type",       limit: 1
    t.string   "remitter_type",          limit: 1
    t.string   "fault_code",             limit: 50
    t.string   "fault_reason",           limit: 1000
    t.string   "is_self_transfer",       limit: 1
    t.string   "is_same_party_transfer", limit: 1
    t.string   "req_transfer_type",      limit: 10
    t.decimal  "bal_available"
    t.string   "service_id"
    t.datetime "reconciled_at"
    t.string   "cbs_req_ref_no"
    t.datetime "processed_at"
    t.string   "notify_status",          limit: 100
    t.integer  "notify_attempt_no",                   precision: 38
    t.datetime "notify_attempt_at"
    t.datetime "notified_at"
    t.string   "notify_result",          limit: 50
    t.string   "rmtr_code",              limit: 50
    t.string   "rmtr_needs_wl",          limit: 1
    t.integer  "rmtr_wl_id",             limit: nil
    t.string   "bene_needs_wl",          limit: 1
    t.integer  "bene_wl_id",             limit: nil
  end

  create_table "inw_remit_bkp_181001to181231", id: false, force: :cascade do |t|
    t.integer  "id",                     limit: nil,                 null: false
    t.string   "req_no",                                             null: false
    t.string   "req_version",            limit: 10,                  null: false
    t.datetime "req_timestamp",                                      null: false
    t.string   "partner_code",           limit: 20,                  null: false
    t.string   "rmtr_full_name"
    t.string   "rmtr_address1"
    t.string   "rmtr_address2"
    t.string   "rmtr_address3"
    t.string   "rmtr_postal_code"
    t.string   "rmtr_city"
    t.string   "rmtr_state"
    t.string   "rmtr_country"
    t.string   "rmtr_email_id"
    t.string   "rmtr_mobile_no"
    t.integer  "rmtr_identity_count",                 precision: 38, null: false
    t.string   "bene_full_name"
    t.string   "bene_address1"
    t.string   "bene_address2"
    t.string   "bene_address3"
    t.string   "bene_postal_code"
    t.string   "bene_city"
    t.string   "bene_state"
    t.string   "bene_country"
    t.string   "bene_email_id"
    t.string   "bene_mobile_no"
    t.integer  "bene_identity_count",                 precision: 38, null: false
    t.string   "bene_account_no"
    t.string   "bene_account_ifsc"
    t.string   "transfer_type",          limit: 10
    t.string   "transfer_ccy",           limit: 5
    t.decimal  "transfer_amount"
    t.string   "rmtr_to_bene_note"
    t.string   "purpose_code",           limit: 5
    t.string   "status_code",            limit: 30
    t.string   "bank_ref",               limit: 50
    t.string   "rep_no"
    t.string   "rep_version",            limit: 10
    t.datetime "rep_timestamp"
    t.integer  "attempt_no",                          precision: 38, null: false
    t.datetime "updated_at"
    t.string   "beneficiary_type",       limit: 1
    t.string   "remitter_type",          limit: 1
    t.string   "fault_code",             limit: 50
    t.string   "fault_reason",           limit: 1000
    t.string   "is_self_transfer",       limit: 1
    t.string   "is_same_party_transfer", limit: 1
    t.string   "req_transfer_type",      limit: 10
    t.decimal  "bal_available"
    t.string   "service_id"
    t.datetime "reconciled_at"
    t.string   "cbs_req_ref_no"
    t.datetime "processed_at"
    t.string   "notify_status",          limit: 100
    t.integer  "notify_attempt_no",                   precision: 38
    t.datetime "notify_attempt_at"
    t.datetime "notified_at"
    t.string   "notify_result",          limit: 50
    t.string   "rmtr_code",              limit: 50
    t.string   "rmtr_needs_wl",          limit: 1
    t.integer  "rmtr_wl_id",             limit: nil
    t.string   "bene_needs_wl",          limit: 1
    t.integer  "bene_wl_id",             limit: nil
  end

  create_table "inw_remit_bkp_181101to181130", id: false, force: :cascade do |t|
    t.integer  "id",                     limit: nil,                 null: false
    t.string   "req_no",                                             null: false
    t.string   "req_version",            limit: 10,                  null: false
    t.datetime "req_timestamp",                                      null: false
    t.string   "partner_code",           limit: 20,                  null: false
    t.string   "rmtr_full_name"
    t.string   "rmtr_address1"
    t.string   "rmtr_address2"
    t.string   "rmtr_address3"
    t.string   "rmtr_postal_code"
    t.string   "rmtr_city"
    t.string   "rmtr_state"
    t.string   "rmtr_country"
    t.string   "rmtr_email_id"
    t.string   "rmtr_mobile_no"
    t.integer  "rmtr_identity_count",                 precision: 38, null: false
    t.string   "bene_full_name"
    t.string   "bene_address1"
    t.string   "bene_address2"
    t.string   "bene_address3"
    t.string   "bene_postal_code"
    t.string   "bene_city"
    t.string   "bene_state"
    t.string   "bene_country"
    t.string   "bene_email_id"
    t.string   "bene_mobile_no"
    t.integer  "bene_identity_count",                 precision: 38, null: false
    t.string   "bene_account_no"
    t.string   "bene_account_ifsc"
    t.string   "transfer_type",          limit: 10
    t.string   "transfer_ccy",           limit: 5
    t.decimal  "transfer_amount"
    t.string   "rmtr_to_bene_note"
    t.string   "purpose_code",           limit: 5
    t.string   "status_code",            limit: 30
    t.string   "bank_ref",               limit: 50
    t.string   "rep_no"
    t.string   "rep_version",            limit: 10
    t.datetime "rep_timestamp"
    t.integer  "attempt_no",                          precision: 38, null: false
    t.datetime "updated_at"
    t.string   "beneficiary_type",       limit: 1
    t.string   "remitter_type",          limit: 1
    t.string   "fault_code",             limit: 50
    t.string   "fault_reason",           limit: 1000
    t.string   "is_self_transfer",       limit: 1
    t.string   "is_same_party_transfer", limit: 1
    t.string   "req_transfer_type",      limit: 10
    t.decimal  "bal_available"
    t.string   "service_id"
    t.datetime "reconciled_at"
    t.string   "cbs_req_ref_no"
    t.datetime "processed_at"
    t.string   "notify_status",          limit: 100
    t.integer  "notify_attempt_no",                   precision: 38
    t.datetime "notify_attempt_at"
    t.datetime "notified_at"
    t.string   "notify_result",          limit: 50
    t.string   "rmtr_code",              limit: 50
    t.string   "rmtr_needs_wl",          limit: 1
    t.integer  "rmtr_wl_id",             limit: nil
    t.string   "bene_needs_wl",          limit: 1
    t.integer  "bene_wl_id",             limit: nil
  end

  create_table "inw_remit_bkp_181101to181230", id: false, force: :cascade do |t|
    t.integer  "id",                     limit: nil,                 null: false
    t.string   "req_no",                                             null: false
    t.string   "req_version",            limit: 10,                  null: false
    t.datetime "req_timestamp",                                      null: false
    t.string   "partner_code",           limit: 20,                  null: false
    t.string   "rmtr_full_name"
    t.string   "rmtr_address1"
    t.string   "rmtr_address2"
    t.string   "rmtr_address3"
    t.string   "rmtr_postal_code"
    t.string   "rmtr_city"
    t.string   "rmtr_state"
    t.string   "rmtr_country"
    t.string   "rmtr_email_id"
    t.string   "rmtr_mobile_no"
    t.integer  "rmtr_identity_count",                 precision: 38, null: false
    t.string   "bene_full_name"
    t.string   "bene_address1"
    t.string   "bene_address2"
    t.string   "bene_address3"
    t.string   "bene_postal_code"
    t.string   "bene_city"
    t.string   "bene_state"
    t.string   "bene_country"
    t.string   "bene_email_id"
    t.string   "bene_mobile_no"
    t.integer  "bene_identity_count",                 precision: 38, null: false
    t.string   "bene_account_no"
    t.string   "bene_account_ifsc"
    t.string   "transfer_type",          limit: 10
    t.string   "transfer_ccy",           limit: 5
    t.decimal  "transfer_amount"
    t.string   "rmtr_to_bene_note"
    t.string   "purpose_code",           limit: 5
    t.string   "status_code",            limit: 30
    t.string   "bank_ref",               limit: 50
    t.string   "rep_no"
    t.string   "rep_version",            limit: 10
    t.datetime "rep_timestamp"
    t.integer  "attempt_no",                          precision: 38, null: false
    t.datetime "updated_at"
    t.string   "beneficiary_type",       limit: 1
    t.string   "remitter_type",          limit: 1
    t.string   "fault_code",             limit: 50
    t.string   "fault_reason",           limit: 1000
    t.string   "is_self_transfer",       limit: 1
    t.string   "is_same_party_transfer", limit: 1
    t.string   "req_transfer_type",      limit: 10
    t.decimal  "bal_available"
    t.string   "service_id"
    t.datetime "reconciled_at"
    t.string   "cbs_req_ref_no"
    t.datetime "processed_at"
    t.string   "notify_status",          limit: 100
    t.integer  "notify_attempt_no",                   precision: 38
    t.datetime "notify_attempt_at"
    t.datetime "notified_at"
    t.string   "notify_result",          limit: 50
    t.string   "rmtr_code",              limit: 50
    t.string   "rmtr_needs_wl",          limit: 1
    t.integer  "rmtr_wl_id",             limit: nil
    t.string   "bene_needs_wl",          limit: 1
    t.integer  "bene_wl_id",             limit: nil
  end

  create_table "inw_remit_bkp_181107to181231", id: false, force: :cascade do |t|
    t.integer  "id",                     limit: nil,                 null: false
    t.string   "req_no",                                             null: false
    t.string   "req_version",            limit: 10,                  null: false
    t.datetime "req_timestamp",                                      null: false
    t.string   "partner_code",           limit: 20,                  null: false
    t.string   "rmtr_full_name"
    t.string   "rmtr_address1"
    t.string   "rmtr_address2"
    t.string   "rmtr_address3"
    t.string   "rmtr_postal_code"
    t.string   "rmtr_city"
    t.string   "rmtr_state"
    t.string   "rmtr_country"
    t.string   "rmtr_email_id"
    t.string   "rmtr_mobile_no"
    t.integer  "rmtr_identity_count",                 precision: 38, null: false
    t.string   "bene_full_name"
    t.string   "bene_address1"
    t.string   "bene_address2"
    t.string   "bene_address3"
    t.string   "bene_postal_code"
    t.string   "bene_city"
    t.string   "bene_state"
    t.string   "bene_country"
    t.string   "bene_email_id"
    t.string   "bene_mobile_no"
    t.integer  "bene_identity_count",                 precision: 38, null: false
    t.string   "bene_account_no"
    t.string   "bene_account_ifsc"
    t.string   "transfer_type",          limit: 10
    t.string   "transfer_ccy",           limit: 5
    t.decimal  "transfer_amount"
    t.string   "rmtr_to_bene_note"
    t.string   "purpose_code",           limit: 5
    t.string   "status_code",            limit: 30
    t.string   "bank_ref",               limit: 50
    t.string   "rep_no"
    t.string   "rep_version",            limit: 10
    t.datetime "rep_timestamp"
    t.integer  "attempt_no",                          precision: 38, null: false
    t.datetime "updated_at"
    t.string   "beneficiary_type",       limit: 1
    t.string   "remitter_type",          limit: 1
    t.string   "fault_code",             limit: 50
    t.string   "fault_reason",           limit: 1000
    t.string   "is_self_transfer",       limit: 1
    t.string   "is_same_party_transfer", limit: 1
    t.string   "req_transfer_type",      limit: 10
    t.decimal  "bal_available"
    t.string   "service_id"
    t.datetime "reconciled_at"
    t.string   "cbs_req_ref_no"
    t.datetime "processed_at"
    t.string   "notify_status",          limit: 100
    t.integer  "notify_attempt_no",                   precision: 38
    t.datetime "notify_attempt_at"
    t.datetime "notified_at"
    t.string   "notify_result",          limit: 50
    t.string   "rmtr_code",              limit: 50
    t.string   "rmtr_needs_wl",          limit: 1
    t.integer  "rmtr_wl_id",             limit: nil
    t.string   "bene_needs_wl",          limit: 1
    t.integer  "bene_wl_id",             limit: nil
  end

  create_table "inw_remit_bkp_181203to181231", id: false, force: :cascade do |t|
    t.integer  "id",                     limit: nil,                 null: false
    t.string   "req_no",                                             null: false
    t.string   "req_version",            limit: 10,                  null: false
    t.datetime "req_timestamp",                                      null: false
    t.string   "partner_code",           limit: 20,                  null: false
    t.string   "rmtr_full_name"
    t.string   "rmtr_address1"
    t.string   "rmtr_address2"
    t.string   "rmtr_address3"
    t.string   "rmtr_postal_code"
    t.string   "rmtr_city"
    t.string   "rmtr_state"
    t.string   "rmtr_country"
    t.string   "rmtr_email_id"
    t.string   "rmtr_mobile_no"
    t.integer  "rmtr_identity_count",                 precision: 38, null: false
    t.string   "bene_full_name"
    t.string   "bene_address1"
    t.string   "bene_address2"
    t.string   "bene_address3"
    t.string   "bene_postal_code"
    t.string   "bene_city"
    t.string   "bene_state"
    t.string   "bene_country"
    t.string   "bene_email_id"
    t.string   "bene_mobile_no"
    t.integer  "bene_identity_count",                 precision: 38, null: false
    t.string   "bene_account_no"
    t.string   "bene_account_ifsc"
    t.string   "transfer_type",          limit: 10
    t.string   "transfer_ccy",           limit: 5
    t.decimal  "transfer_amount"
    t.string   "rmtr_to_bene_note"
    t.string   "purpose_code",           limit: 5
    t.string   "status_code",            limit: 30
    t.string   "bank_ref",               limit: 50
    t.string   "rep_no"
    t.string   "rep_version",            limit: 10
    t.datetime "rep_timestamp"
    t.integer  "attempt_no",                          precision: 38, null: false
    t.datetime "updated_at"
    t.string   "beneficiary_type",       limit: 1
    t.string   "remitter_type",          limit: 1
    t.string   "fault_code",             limit: 50
    t.string   "fault_reason",           limit: 1000
    t.string   "is_self_transfer",       limit: 1
    t.string   "is_same_party_transfer", limit: 1
    t.string   "req_transfer_type",      limit: 10
    t.decimal  "bal_available"
    t.string   "service_id"
    t.datetime "reconciled_at"
    t.string   "cbs_req_ref_no"
    t.datetime "processed_at"
    t.string   "notify_status",          limit: 100
    t.integer  "notify_attempt_no",                   precision: 38
    t.datetime "notify_attempt_at"
    t.datetime "notified_at"
    t.string   "notify_result",          limit: 50
    t.string   "rmtr_code",              limit: 50
    t.string   "rmtr_needs_wl",          limit: 1
    t.integer  "rmtr_wl_id",             limit: nil
    t.string   "bene_needs_wl",          limit: 1
    t.integer  "bene_wl_id",             limit: nil
  end

  create_table "inw_remit_bkp_181205to181218", id: false, force: :cascade do |t|
    t.integer  "id",                     limit: nil,                 null: false
    t.string   "req_no",                                             null: false
    t.string   "req_version",            limit: 10,                  null: false
    t.datetime "req_timestamp",                                      null: false
    t.string   "partner_code",           limit: 20,                  null: false
    t.string   "rmtr_full_name"
    t.string   "rmtr_address1"
    t.string   "rmtr_address2"
    t.string   "rmtr_address3"
    t.string   "rmtr_postal_code"
    t.string   "rmtr_city"
    t.string   "rmtr_state"
    t.string   "rmtr_country"
    t.string   "rmtr_email_id"
    t.string   "rmtr_mobile_no"
    t.integer  "rmtr_identity_count",                 precision: 38, null: false
    t.string   "bene_full_name"
    t.string   "bene_address1"
    t.string   "bene_address2"
    t.string   "bene_address3"
    t.string   "bene_postal_code"
    t.string   "bene_city"
    t.string   "bene_state"
    t.string   "bene_country"
    t.string   "bene_email_id"
    t.string   "bene_mobile_no"
    t.integer  "bene_identity_count",                 precision: 38, null: false
    t.string   "bene_account_no"
    t.string   "bene_account_ifsc"
    t.string   "transfer_type",          limit: 10
    t.string   "transfer_ccy",           limit: 5
    t.decimal  "transfer_amount"
    t.string   "rmtr_to_bene_note"
    t.string   "purpose_code",           limit: 5
    t.string   "status_code",            limit: 30
    t.string   "bank_ref",               limit: 50
    t.string   "rep_no"
    t.string   "rep_version",            limit: 10
    t.datetime "rep_timestamp"
    t.integer  "attempt_no",                          precision: 38, null: false
    t.datetime "updated_at"
    t.string   "beneficiary_type",       limit: 1
    t.string   "remitter_type",          limit: 1
    t.string   "fault_code",             limit: 50
    t.string   "fault_reason",           limit: 1000
    t.string   "is_self_transfer",       limit: 1
    t.string   "is_same_party_transfer", limit: 1
    t.string   "req_transfer_type",      limit: 10
    t.decimal  "bal_available"
    t.string   "service_id"
    t.datetime "reconciled_at"
    t.string   "cbs_req_ref_no"
    t.datetime "processed_at"
    t.string   "notify_status",          limit: 100
    t.integer  "notify_attempt_no",                   precision: 38
    t.datetime "notify_attempt_at"
    t.datetime "notified_at"
    t.string   "notify_result",          limit: 50
    t.string   "rmtr_code",              limit: 50
    t.string   "rmtr_needs_wl",          limit: 1
    t.integer  "rmtr_wl_id",             limit: nil
    t.string   "bene_needs_wl",          limit: 1
    t.integer  "bene_wl_id",             limit: nil
  end

  create_table "inw_remit_bkp_190101to190131", id: false, force: :cascade do |t|
    t.integer  "id",                     limit: nil,                 null: false
    t.string   "req_no",                                             null: false
    t.string   "req_version",            limit: 10,                  null: false
    t.datetime "req_timestamp",                                      null: false
    t.string   "partner_code",           limit: 20,                  null: false
    t.string   "rmtr_full_name"
    t.string   "rmtr_address1"
    t.string   "rmtr_address2"
    t.string   "rmtr_address3"
    t.string   "rmtr_postal_code"
    t.string   "rmtr_city"
    t.string   "rmtr_state"
    t.string   "rmtr_country"
    t.string   "rmtr_email_id"
    t.string   "rmtr_mobile_no"
    t.integer  "rmtr_identity_count",                 precision: 38, null: false
    t.string   "bene_full_name"
    t.string   "bene_address1"
    t.string   "bene_address2"
    t.string   "bene_address3"
    t.string   "bene_postal_code"
    t.string   "bene_city"
    t.string   "bene_state"
    t.string   "bene_country"
    t.string   "bene_email_id"
    t.string   "bene_mobile_no"
    t.integer  "bene_identity_count",                 precision: 38, null: false
    t.string   "bene_account_no"
    t.string   "bene_account_ifsc"
    t.string   "transfer_type",          limit: 10
    t.string   "transfer_ccy",           limit: 5
    t.decimal  "transfer_amount"
    t.string   "rmtr_to_bene_note"
    t.string   "purpose_code",           limit: 5
    t.string   "status_code",            limit: 30
    t.string   "bank_ref",               limit: 50
    t.string   "rep_no"
    t.string   "rep_version",            limit: 10
    t.datetime "rep_timestamp"
    t.integer  "attempt_no",                          precision: 38, null: false
    t.datetime "updated_at"
    t.string   "beneficiary_type",       limit: 1
    t.string   "remitter_type",          limit: 1
    t.string   "fault_code",             limit: 50
    t.string   "fault_reason",           limit: 1000
    t.string   "is_self_transfer",       limit: 1
    t.string   "is_same_party_transfer", limit: 1
    t.string   "req_transfer_type",      limit: 10
    t.decimal  "bal_available"
    t.string   "service_id"
    t.datetime "reconciled_at"
    t.string   "cbs_req_ref_no"
    t.datetime "processed_at"
    t.string   "notify_status",          limit: 100
    t.integer  "notify_attempt_no",                   precision: 38
    t.datetime "notify_attempt_at"
    t.datetime "notified_at"
    t.string   "notify_result",          limit: 50
    t.string   "rmtr_code",              limit: 50
    t.string   "rmtr_needs_wl",          limit: 1
    t.integer  "rmtr_wl_id",             limit: nil
    t.string   "bene_needs_wl",          limit: 1
    t.integer  "bene_wl_id",             limit: nil
    t.string   "payervpa"
    t.string   "payeevpa"
  end

  create_table "inw_remittance_rules", force: :cascade do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "created_by"
    t.string   "updated_by"
    t.integer  "lock_version",                         precision: 38, default: 0,   null: false
    t.string   "approval_status",         limit: 1,                   default: "U", null: false
    t.string   "last_action",             limit: 1,                   default: "C"
    t.integer  "approved_version",                     precision: 38
    t.integer  "approved_id",             limit: nil
    t.text     "pattern_salutations"
    t.string   "pattern_individuals_1",   limit: 4000
    t.string   "pattern_corporates_1",    limit: 4000
    t.string   "pattern_beneficiaries_1", limit: 4000
    t.string   "pattern_remitters_1",     limit: 4000
    t.text     "pattern_individuals"
    t.text     "pattern_corporates"
    t.text     "pattern_beneficiaries"
    t.text     "pattern_remitters"
  end

  create_table "inward_remittances", force: :cascade do |t|
    t.string   "req_no",                                             null: false
    t.string   "req_version",            limit: 10,                  null: false
    t.datetime "req_timestamp",                                      null: false
    t.string   "partner_code",           limit: 20,                  null: false
    t.string   "rmtr_full_name"
    t.string   "rmtr_address1"
    t.string   "rmtr_address2"
    t.string   "rmtr_address3"
    t.string   "rmtr_postal_code"
    t.string   "rmtr_city"
    t.string   "rmtr_state"
    t.string   "rmtr_country"
    t.string   "rmtr_email_id"
    t.string   "rmtr_mobile_no"
    t.integer  "rmtr_identity_count",                 precision: 38, null: false
    t.string   "bene_full_name"
    t.string   "bene_address1"
    t.string   "bene_address2"
    t.string   "bene_address3"
    t.string   "bene_postal_code"
    t.string   "bene_city"
    t.string   "bene_state"
    t.string   "bene_country"
    t.string   "bene_email_id"
    t.string   "bene_mobile_no"
    t.integer  "bene_identity_count",                 precision: 38, null: false
    t.string   "bene_account_no"
    t.string   "bene_account_ifsc"
    t.string   "transfer_type",          limit: 10
    t.string   "transfer_ccy",           limit: 5
    t.decimal  "transfer_amount"
    t.string   "rmtr_to_bene_note"
    t.string   "purpose_code",           limit: 5
    t.string   "status_code",            limit: 30
    t.string   "bank_ref",               limit: 50
    t.string   "rep_no"
    t.string   "rep_version",            limit: 10
    t.datetime "rep_timestamp"
    t.integer  "attempt_no",                          precision: 38, null: false
    t.datetime "updated_at"
    t.string   "beneficiary_type",       limit: 1
    t.string   "remitter_type",          limit: 1
    t.string   "fault_code",             limit: 50
    t.string   "fault_reason",           limit: 1000
    t.string   "is_self_transfer",       limit: 1
    t.string   "is_same_party_transfer", limit: 1
    t.string   "req_transfer_type",      limit: 10
    t.decimal  "bal_available"
    t.string   "service_id"
    t.datetime "reconciled_at"
    t.string   "cbs_req_ref_no"
    t.datetime "processed_at"
    t.string   "notify_status",          limit: 100
    t.integer  "notify_attempt_no",                   precision: 38
    t.datetime "notify_attempt_at"
    t.datetime "notified_at"
    t.string   "notify_result",          limit: 50
    t.string   "rmtr_code",              limit: 50
    t.string   "rmtr_needs_wl",          limit: 1
    t.integer  "rmtr_wl_id",             limit: nil
    t.string   "bene_needs_wl",          limit: 1
    t.integer  "bene_wl_id",             limit: nil
    t.string   "payervpa"
    t.string   "payeevpa"
    t.string   "payeeVPA"
    t.string   "payerVPA"
  end

  add_index "inward_remittances", ["TO_CHAR(\"REQ_TIMESTAMP\",'YYYY')", "bene_account_no", "bene_account_ifsc", "status_code", "partner_code"], name: "inw_index_02"
  add_index "inward_remittances", ["notify_status"], name: "inward_remittances_01"
  add_index "inward_remittances", ["partner_code", "rmtr_needs_wl", "bene_needs_wl"], name: "in_inw_wl_2"
  add_index "inward_remittances", ["partner_code", "rmtr_wl_id", "bene_wl_id"], name: "in_inw_wl_1"
  add_index "inward_remittances", ["partner_code", "status_code", "notify_status", "req_no", "rmtr_code", "bene_account_no", "bene_account_ifsc", "bank_ref", "rmtr_full_name", "transfer_type", "req_transfer_type", "transfer_amount", "req_timestamp"], name: "inw_index_04"
  add_index "inward_remittances", ["req_no", "partner_code", "attempt_no"], name: "remittance_unique_index", unique: true
  add_index "inward_remittances", ["req_timestamp", "status_code", "partner_code"], name: "inw_index_03"

  create_table "inward_remittances_locks", id: false, force: :cascade do |t|
    t.integer "inward_remittance_id", limit: nil
    t.string  "created_at"
  end

  create_table "log_entries", force: :cascade do |t|
    t.text     "line"
    t.datetime "created_at"
    t.integer  "log_file_id", limit: nil
  end

  create_table "log_files", force: :cascade do |t|
    t.string   "name"
    t.integer  "line_count",             precision: 38
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
    t.integer  "broker_id",  limit: nil
  end

  create_table "mmid_master", force: :cascade do |t|
    t.string   "accountno",    limit: 25, null: false
    t.string   "mobileno",     limit: 10, null: false
    t.string   "mmid",         limit: 20, null: false
    t.string   "customerid",   limit: 20
    t.string   "cbsno",        limit: 20
    t.datetime "creationdate"
    t.string   "isactive",     limit: 2
    t.string   "created_by",   limit: 30
    t.datetime "rodt"
  end

  create_table "nach_members", force: :cascade do |t|
    t.string   "iin",              limit: 50,                               null: false
    t.string   "name",             limit: 50,                               null: false
    t.datetime "created_at",                                                null: false
    t.datetime "updated_at",                                                null: false
    t.string   "created_by",       limit: 20
    t.string   "updated_by",       limit: 20
    t.integer  "lock_version",                 precision: 38, default: 0,   null: false
    t.string   "last_action",      limit: 1,                  default: "C", null: false
    t.string   "approval_status",  limit: 1,                  default: "U", null: false
    t.integer  "approved_version",             precision: 38
    t.integer  "approved_id",      limit: nil
    t.string   "is_enabled",       limit: 1,                  default: "f", null: false
  end

  add_index "nach_members", ["iin", "approval_status"], name: "nach_members_01", unique: true

  create_table "neft_msg_bkp_180101to180131", id: false, force: :cascade do |t|
    t.integer  "id",                limit: nil,                null: false
    t.integer  "tranref_no",                    precision: 38
    t.integer  "txid",                          precision: 38
    t.string   "orgnlmsgid",        limit: 30
    t.string   "msgtype",           limit: 30
    t.float    "amount",            limit: 126
    t.date     "transfer_date"
    t.string   "bene_account_ifsc", limit: 30
    t.datetime "last_mod_time"
    t.text     "payload"
    t.string   "exception_desc",    limit: 30
    t.string   "status",            limit: 20
    t.string   "isecoll",           limit: 20
  end

  create_table "neft_msg_bkp_181107to181231", id: false, force: :cascade do |t|
    t.integer  "id",                limit: nil,                null: false
    t.integer  "tranref_no",                    precision: 38
    t.integer  "txid",                          precision: 38
    t.string   "orgnlmsgid",        limit: 30
    t.string   "msgtype",           limit: 30
    t.float    "amount",            limit: 126
    t.date     "transfer_date"
    t.string   "bene_account_ifsc", limit: 30
    t.datetime "last_mod_time"
    t.text     "payload"
    t.string   "exception_desc",    limit: 30
    t.string   "status",            limit: 20
    t.string   "isecoll",           limit: 20
  end

  create_table "neft_msg_bkp_181218to181224", id: false, force: :cascade do |t|
    t.integer  "id",                limit: nil,                null: false
    t.integer  "tranref_no",                    precision: 38
    t.integer  "txid",                          precision: 38
    t.string   "orgnlmsgid",        limit: 30
    t.string   "msgtype",           limit: 30
    t.float    "amount",            limit: 126
    t.date     "transfer_date"
    t.string   "bene_account_ifsc", limit: 30
    t.datetime "last_mod_time"
    t.text     "payload"
    t.string   "exception_desc",    limit: 30
    t.string   "status",            limit: 20
    t.string   "isecoll",           limit: 20
  end

  create_table "neft_msg_bkp_190101to190131", id: false, force: :cascade do |t|
    t.integer  "id",                limit: nil,                null: false
    t.integer  "tranref_no",                    precision: 38
    t.integer  "txid",                          precision: 38
    t.string   "orgnlmsgid",        limit: 30
    t.string   "msgtype",           limit: 30
    t.float    "amount",            limit: 126
    t.date     "transfer_date"
    t.string   "bene_account_ifsc", limit: 30
    t.datetime "last_mod_time"
    t.text     "payload"
    t.string   "exception_desc",    limit: 30
    t.string   "status",            limit: 20
    t.string   "isecoll",           limit: 20
  end

  create_table "neft_msgdetails", id: false, force: :cascade do |t|
    t.integer  "id",                limit: nil,                null: false
    t.integer  "tranref_no",                    precision: 38
    t.integer  "txid",                          precision: 38
    t.string   "orgnlmsgid",        limit: 30
    t.string   "msgtype",           limit: 30
    t.float    "amount",            limit: 126
    t.date     "transfer_date"
    t.string   "bene_account_ifsc", limit: 30
    t.datetime "last_mod_time"
    t.text     "payload"
    t.string   "exception_desc",    limit: 30
    t.string   "status",            limit: 20
    t.string   "isecoll",           limit: 20
  end

  create_table "ns_callbacks", force: :cascade do |t|
    t.string   "app_code",          limit: 50,                               null: false
    t.string   "notify_url",        limit: 100
    t.string   "http_username",     limit: 50
    t.string   "http_password"
    t.integer  "settings_cnt",      limit: nil
    t.string   "setting1"
    t.string   "setting2"
    t.string   "setting3"
    t.string   "setting4"
    t.string   "setting5"
    t.integer  "udfs_cnt",          limit: nil,                default: 0
    t.integer  "unique_udfs_cnt",   limit: nil,                default: 0
    t.string   "udf1"
    t.string   "string"
    t.string   "udf2"
    t.string   "udf3"
    t.string   "udf4"
    t.string   "udf5"
    t.datetime "created_at",                                                 null: false
    t.datetime "updated_at",                                                 null: false
    t.string   "created_by",        limit: 20
    t.string   "updated_by",        limit: 20
    t.integer  "lock_version",                  precision: 38, default: 0,   null: false
    t.string   "last_action",       limit: 1,                  default: "C", null: false
    t.string   "approval_status",   limit: 1,                  default: "U", null: false
    t.integer  "approved_version",              precision: 38
    t.integer  "approved_id",       limit: nil
    t.integer  "sc_service_id",     limit: nil
    t.string   "include_hash",      limit: 1,                  default: "f"
    t.string   "hash_header_name",  limit: 100
    t.string   "hash_algo",         limit: 100
    t.string   "hash_key"
    t.string   "callbackable_type"
    t.integer  "callbackable_id",   limit: nil
  end

  add_index "ns_callbacks", ["app_code", "approval_status"], name: "ns_callbacks_01", unique: true

  create_table "ns_pending_notifications", force: :cascade do |t|
    t.string   "broker_uuid",                  null: false
    t.string   "auditable_type",               null: false
    t.integer  "auditable_id",     limit: nil, null: false
    t.string   "app_code",         limit: 20,  null: false
    t.string   "service_code",     limit: 20,  null: false
    t.string   "pending_approval", limit: 1,   null: false
    t.datetime "created_at",                   null: false
  end

  add_index "ns_pending_notifications", ["auditable_type", "auditable_id"], name: "ns_notifications_01"
  add_index "ns_pending_notifications", ["broker_uuid", "created_at"], name: "ns_notifications_02"

  create_table "ns_templates", force: :cascade do |t|
    t.integer  "sc_event_id",      limit: nil,                              null: false
    t.text     "sms_text"
    t.string   "email_subject"
    t.text     "email_body"
    t.datetime "created_at",                                                null: false
    t.datetime "updated_at",                                                null: false
    t.string   "created_by",       limit: 20
    t.string   "updated_by",       limit: 20
    t.integer  "lock_version",                 precision: 38, default: 0,   null: false
    t.string   "last_action",      limit: 1,                  default: "C", null: false
    t.string   "approval_status",  limit: 1,                  default: "U", null: false
    t.integer  "approved_version",             precision: 38
    t.integer  "approved_id",      limit: nil
    t.string   "display_text",                                              null: false
    t.string   "template_code",                                             null: false
    t.string   "is_enabled",       limit: 1,                  default: "Y"
  end

  create_table "obdx_bm_bill_payment_steps", force: :cascade do |t|
    t.integer  "bm_bill_payment_id", limit: nil
    t.integer  "step_no",                        precision: 38
    t.integer  "attempt_no",                     precision: 38
    t.string   "step_name"
    t.string   "status_code"
    t.string   "fault_code"
    t.string   "fault_reason"
    t.string   "req_reference"
    t.text     "req_bitstream"
    t.datetime "req_timestamp"
    t.string   "rep_reference"
    t.text     "rep_bitstream"
    t.datetime "rep_timestamp"
    t.text     "fault_bitstream"
    t.datetime "created_at",                                    null: false
    t.datetime "updated_at",                                    null: false
  end

  create_table "obdx_bm_billpay_steps", force: :cascade do |t|
    t.integer  "bm_bill_payment_id", limit: nil
    t.integer  "step_no",                        precision: 38
    t.integer  "attempt_no",                     precision: 38
    t.string   "step_name"
    t.string   "status_code"
    t.string   "fault_code"
    t.string   "fault_reason"
    t.string   "req_reference"
    t.text     "req_bitstream"
    t.datetime "req_timestamp"
    t.string   "rep_reference"
    t.text     "rep_bitstream"
    t.datetime "rep_timestamp"
    t.text     "fault_bitstream"
    t.datetime "created_at",                                    null: false
    t.datetime "updated_at",                                    null: false
  end

  create_table "obdx_bm_unapproved_records", id: false, force: :cascade do |t|
    t.integer   "obdx_bm_approvable_id",   limit: nil
    t.string    "obdx_bm_approvable_type"
    t.timestamp "created_at",              limit: 6
    t.timestamp "updated_at",              limit: 6
    t.integer   "id",                      limit: nil
  end

  create_table "obdx_unapproved_records", id: false, force: :cascade do |t|
    t.integer   "approvable_id",   limit: nil
    t.string    "approvable_type"
    t.timestamp "created_at",      limit: 6
    t.timestamp "updated_at",      limit: 6
  end

  create_table "outgoing_file_types", force: :cascade do |t|
    t.integer  "sc_service_id", limit: nil,                null: false
    t.string   "code",          limit: 50,                 null: false
    t.string   "name",          limit: 50,                 null: false
    t.string   "db_unit_name"
    t.string   "msg_domain"
    t.string   "msg_model"
    t.string   "row_name"
    t.string   "file_name"
    t.integer  "run_at_hour",               precision: 38
    t.string   "run_at_day",    limit: 1
    t.datetime "last_run_at"
    t.datetime "next_run_at"
    t.integer  "batch_size",                precision: 38
    t.string   "write_header",  limit: 1
    t.string   "email_to"
    t.string   "email_cc"
    t.string   "email_subject"
  end

  add_index "outgoing_file_types", ["code", "sc_service_id"], name: "i_out_fil_typ_cod_sc_ser_id", unique: true

  create_table "outgoing_files", force: :cascade do |t|
    t.string   "service_code",                            null: false
    t.string   "file_type",                               null: false
    t.string   "file_name",    limit: 100,                null: false
    t.string   "file_path",                               null: false
    t.integer  "line_count",               precision: 38, null: false
    t.datetime "started_at",                              null: false
    t.datetime "ended_at"
    t.string   "email_ref"
  end

  create_table "partner_lcy_rates", force: :cascade do |t|
    t.string   "partner_code",     limit: 20,                               null: false
    t.decimal  "rate"
    t.datetime "created_at",                                                null: false
    t.datetime "updated_at",                                                null: false
    t.string   "created_by",       limit: 20
    t.string   "updated_by",       limit: 20
    t.integer  "lock_version",                 precision: 38, default: 0,   null: false
    t.string   "approval_status",  limit: 1,                  default: "U", null: false
    t.string   "last_action",      limit: 1,                  default: "C", null: false
    t.integer  "approved_version",             precision: 38
    t.integer  "approved_id",      limit: nil
  end

  add_index "partner_lcy_rates", ["partner_code", "approval_status"], name: "partner_lcy_rates_01", unique: true

  create_table "partners", force: :cascade do |t|
    t.string   "code",                         limit: 10,                                 null: false
    t.string   "name",                         limit: 60,                                 null: false
    t.string   "tech_email_id"
    t.string   "ops_email_id"
    t.string   "account_no",                   limit: 20,                                 null: false
    t.string   "account_ifsc",                 limit: 20
    t.integer  "txn_hold_period_days",                     precision: 38, default: 7,     null: false
    t.string   "identity_user_id",             limit: 20,                                 null: false
    t.decimal  "low_balance_alert_at"
    t.string   "remitter_sms_allowed",         limit: 1
    t.string   "remitter_email_allowed",       limit: 1
    t.string   "beneficiary_sms_allowed",      limit: 1
    t.string   "beneficiary_email_allowed",    limit: 1
    t.string   "allow_neft",                   limit: 1
    t.string   "allow_rtgs",                   limit: 1
    t.string   "allow_imps",                   limit: 1
    t.string   "created_by",                   limit: 20
    t.string   "updated_by",                   limit: 20
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "lock_version",                             precision: 38, default: 0,     null: false
    t.string   "enabled",                      limit: 1
    t.string   "customer_id",                  limit: 15
    t.string   "mmid",                         limit: 7
    t.string   "mobile_no",                    limit: 10
    t.string   "country"
    t.string   "address_line1"
    t.string   "address_line2"
    t.string   "address_line3"
    t.string   "approval_status",              limit: 1,                  default: "U",   null: false
    t.string   "last_action",                  limit: 1,                  default: "C"
    t.integer  "approved_version",                         precision: 38
    t.integer  "approved_id",                  limit: nil
    t.string   "add_req_ref_in_rep",           limit: 1,                  default: "Y",   null: false
    t.string   "add_transfer_amt_in_rep",      limit: 1,                  default: "Y",   null: false
    t.string   "app_code",                     limit: 20
    t.string   "notify_on_status_change",      limit: 1,                  default: "f",   null: false
    t.string   "service_name",                 limit: 5,                  default: "INW", null: false
    t.integer  "guideline_id",                 limit: nil,                default: 1,     null: false
    t.string   "will_whitelist",               limit: 1,                  default: "Y",   null: false
    t.string   "will_send_id",                 limit: 1,                  default: "Y",   null: false
    t.string   "hold_for_whitelisting",        limit: 1,                  default: "f",   null: false
    t.string   "auto_match_rule",              limit: 1,                  default: "A",   null: false
    t.datetime "notification_sent_at"
    t.string   "auto_reschdl_to_next_wrk_day", limit: 1,                  default: "Y"
    t.string   "allow_upi",                    limit: 1,                  default: "f"
    t.string   "validate_vpa",                 limit: 1,                  default: "f"
    t.string   "merchant_id",                  limit: 30
    t.string   "reply_with_bene_name",         limit: 1,                  default: "f"
    t.string   "aml_flag",                     limit: 1,                  default: "f"
    t.string   "sender_rc",                    limit: 100
  end

  add_index "partners", ["code", "approval_status"], name: "partners_01", unique: true

  create_table "partners_bkp", id: false, force: :cascade do |t|
    t.integer  "id",                           limit: nil,                null: false
    t.string   "code",                         limit: 10,                 null: false
    t.string   "name",                         limit: 60,                 null: false
    t.string   "tech_email_id"
    t.string   "ops_email_id"
    t.string   "account_no",                   limit: 20,                 null: false
    t.string   "account_ifsc",                 limit: 20
    t.integer  "txn_hold_period_days",                     precision: 38, null: false
    t.string   "identity_user_id",             limit: 20,                 null: false
    t.decimal  "low_balance_alert_at"
    t.string   "remitter_sms_allowed",         limit: 1
    t.string   "remitter_email_allowed",       limit: 1
    t.string   "beneficiary_sms_allowed",      limit: 1
    t.string   "beneficiary_email_allowed",    limit: 1
    t.string   "allow_neft",                   limit: 1
    t.string   "allow_rtgs",                   limit: 1
    t.string   "allow_imps",                   limit: 1
    t.string   "created_by",                   limit: 20
    t.string   "updated_by",                   limit: 20
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "lock_version",                             precision: 38, null: false
    t.string   "enabled",                      limit: 1
    t.string   "customer_id",                  limit: 15
    t.string   "mmid",                         limit: 7
    t.string   "mobile_no",                    limit: 10
    t.string   "country"
    t.string   "address_line1"
    t.string   "address_line2"
    t.string   "address_line3"
    t.string   "approval_status",              limit: 1,                  null: false
    t.string   "last_action",                  limit: 1
    t.integer  "approved_version",                         precision: 38
    t.integer  "approved_id",                  limit: nil
    t.string   "add_req_ref_in_rep",           limit: 1,                  null: false
    t.string   "add_transfer_amt_in_rep",      limit: 1,                  null: false
    t.string   "app_code",                     limit: 20
    t.string   "notify_on_status_change",      limit: 1,                  null: false
    t.string   "service_name",                 limit: 5,                  null: false
    t.integer  "guideline_id",                 limit: nil,                null: false
    t.string   "will_whitelist",               limit: 1,                  null: false
    t.string   "will_send_id",                 limit: 1,                  null: false
    t.string   "hold_for_whitelisting",        limit: 1,                  null: false
    t.string   "auto_match_rule",              limit: 1,                  null: false
    t.datetime "notification_sent_at"
    t.string   "auto_reschdl_to_next_wrk_day", limit: 1
    t.string   "reply_with_bene_name",         limit: 1
  end

  create_table "pc2_apps", force: :cascade do |t|
    t.string   "app_id",               limit: 50,                               null: false
    t.string   "customer_id",          limit: 50,                               null: false
    t.string   "identity_user_id",     limit: 20,                               null: false
    t.string   "is_enabled",           limit: 1,                                null: false
    t.string   "created_by",           limit: 20
    t.string   "updated_by",           limit: 20
    t.datetime "created_at",                                                    null: false
    t.datetime "updated_at",                                                    null: false
    t.integer  "lock_version",                     precision: 38, default: 0,   null: false
    t.string   "approval_status",      limit: 1,                  default: "U", null: false
    t.string   "last_action",          limit: 1,                  default: "C", null: false
    t.integer  "approved_version",                 precision: 38
    t.integer  "approved_id",          limit: nil
    t.datetime "notification_sent_at"
  end

  add_index "pc2_apps", ["app_id", "customer_id", "approval_status"], name: "pc2_apps_01", unique: true

  create_table "pc2_audit_logs", force: :cascade do |t|
    t.string   "req_no",             limit: 32,                  null: false
    t.string   "app_id",             limit: 32,                  null: false
    t.integer  "attempt_no",                      precision: 38, null: false
    t.string   "status_code",        limit: 25,                  null: false
    t.string   "pc2_auditable_type",                             null: false
    t.integer  "pc2_auditable_id",   limit: nil,                 null: false
    t.string   "fault_code"
    t.string   "fault_subcode",      limit: 50
    t.string   "fault_reason",       limit: 1000
    t.datetime "req_timestamp"
    t.datetime "rep_timestamp"
    t.text     "req_bitstream",                                  null: false
    t.text     "rep_bitstream"
    t.text     "fault_bitstream"
  end

  add_index "pc2_audit_logs", ["app_id", "req_no", "attempt_no"], name: "uk_pc2_audit_logs_1", unique: true
  add_index "pc2_audit_logs", ["pc2_auditable_type", "pc2_auditable_id"], name: "uk_pc2_audit_logs_2", unique: true

  create_table "pc2_audit_steps", force: :cascade do |t|
    t.string   "pc2_auditable_type",                             null: false
    t.integer  "pc2_auditable_id",   limit: nil,                 null: false
    t.integer  "step_no",                         precision: 38, null: false
    t.integer  "attempt_no",                      precision: 38, null: false
    t.string   "step_name",          limit: 100,                 null: false
    t.string   "status_code",        limit: 25,                  null: false
    t.string   "fault_code"
    t.string   "fault_subcode",      limit: 50
    t.string   "fault_reason",       limit: 1000
    t.string   "req_reference"
    t.datetime "req_timestamp"
    t.string   "rep_reference"
    t.datetime "rep_timestamp"
    t.text     "req_bitstream"
    t.text     "rep_bitstream"
    t.text     "fault_bitstream"
    t.datetime "reconciled_at"
  end

  add_index "pc2_audit_steps", ["pc2_auditable_type", "pc2_auditable_id", "step_no", "attempt_no"], name: "uk_pc2_audit_steps", unique: true

  create_table "pc2_block_cards", force: :cascade do |t|
    t.string   "req_no",                                    null: false
    t.integer  "attempt_no",                 precision: 38, null: false
    t.string   "status_code",   limit: 25,                  null: false
    t.string   "req_version",   limit: 10,                  null: false
    t.datetime "req_timestamp",                             null: false
    t.string   "app_id",        limit: 50,                  null: false
    t.string   "customer_id",   limit: 50,                  null: false
    t.string   "proxy_card_no", limit: 50,                  null: false
    t.datetime "rep_timestamp"
    t.string   "rep_version",   limit: 10
    t.string   "rep_no"
    t.string   "fault_code",    limit: 50
    t.string   "fault_subcode", limit: 50
    t.string   "fault_reason",  limit: 1000
  end

  add_index "pc2_block_cards", ["req_no", "app_id", "attempt_no"], name: "uk_pc2_block_cards", unique: true

  create_table "pc2_cust_accounts", force: :cascade do |t|
    t.string   "customer_id",      limit: 15,                               null: false
    t.string   "account_no",       limit: 20,                               null: false
    t.string   "is_enabled",       limit: 1,                                null: false
    t.datetime "created_at",                                                null: false
    t.datetime "updated_at",                                                null: false
    t.string   "created_by",       limit: 20
    t.string   "updated_by",       limit: 20
    t.integer  "lock_version",                 precision: 38, default: 0,   null: false
    t.string   "approval_status",  limit: 1,                  default: "U", null: false
    t.string   "last_action",      limit: 1,                  default: "C", null: false
    t.integer  "approved_version",             precision: 38
    t.integer  "approved_id",      limit: nil
  end

  add_index "pc2_cust_accounts", ["customer_id", "account_no", "approval_status"], name: "pc2_cust_accounts_01", unique: true

  create_table "pc2_load_cards", force: :cascade do |t|
    t.string   "req_no",                                    null: false
    t.integer  "attempt_no",                 precision: 38, null: false
    t.string   "status_code",   limit: 25,                  null: false
    t.string   "req_version",   limit: 10,                  null: false
    t.datetime "req_timestamp",                             null: false
    t.string   "app_id",        limit: 50,                  null: false
    t.string   "customer_id",   limit: 50,                  null: false
    t.string   "debit_acct_no", limit: 50,                  null: false
    t.string   "proxy_card_no", limit: 50,                  null: false
    t.string   "load_ccy",      limit: 50,                  null: false
    t.decimal  "load_amount",                               null: false
    t.string   "product_type",  limit: 50,                  null: false
    t.decimal  "exch_rate",                                 null: false
    t.string   "rep_no"
    t.string   "rep_version",   limit: 10
    t.datetime "rep_timestamp"
    t.decimal  "avail_amount"
    t.decimal  "fee_amount"
    t.string   "fault_code",    limit: 50
    t.string   "fault_subcode", limit: 50
    t.string   "fault_reason",  limit: 1000
  end

  add_index "pc2_load_cards", ["req_no", "app_id", "attempt_no"], name: "uk_pc2_load_cards", unique: true

  create_table "pc2_pending_steps", force: :cascade do |t|
    t.string   "broker_uuid",                               null: false
    t.datetime "created_at",                                null: false
    t.integer  "pc2_audit_step_id", limit: nil, default: 1, null: false
  end

  create_table "pc2_pin_changes", force: :cascade do |t|
    t.string   "req_no",                                    null: false
    t.integer  "attempt_no",                 precision: 38, null: false
    t.string   "status_code",   limit: 25,                  null: false
    t.string   "req_version",   limit: 10,                  null: false
    t.datetime "req_timestamp",                             null: false
    t.string   "app_id",        limit: 50,                  null: false
    t.string   "customer_id",   limit: 50,                  null: false
    t.string   "proxy_card_no", limit: 50,                  null: false
    t.datetime "rep_timestamp"
    t.string   "rep_version",   limit: 10
    t.string   "rep_no"
    t.string   "fault_code",    limit: 50
    t.string   "fault_subcode", limit: 50
    t.string   "fault_reason",  limit: 1000
  end

  add_index "pc2_pin_changes", ["req_no", "app_id", "attempt_no"], name: "uk_pc2_pin_changes", unique: true

  create_table "pc2_unload_cards", force: :cascade do |t|
    t.string   "req_no",                                     null: false
    t.integer  "attempt_no",                  precision: 38, null: false
    t.string   "status_code",    limit: 25,                  null: false
    t.string   "req_version",    limit: 10,                  null: false
    t.datetime "req_timestamp",                              null: false
    t.string   "app_id",         limit: 50,                  null: false
    t.string   "customer_id",    limit: 50,                  null: false
    t.string   "credit_acct_no", limit: 50,                  null: false
    t.string   "proxy_card_no",  limit: 50,                  null: false
    t.string   "unload_ccy",     limit: 50,                  null: false
    t.decimal  "unload_amount",                              null: false
    t.string   "product_type",   limit: 50,                  null: false
    t.decimal  "exch_rate",                                  null: false
    t.string   "rep_no"
    t.string   "rep_version",    limit: 10
    t.datetime "rep_timestamp"
    t.decimal  "avail_amount"
    t.decimal  "fee_amount"
    t.string   "fault_code",     limit: 50
    t.string   "fault_subcode",  limit: 50
    t.string   "fault_reason",   limit: 1000
  end

  add_index "pc2_unload_cards", ["req_no", "app_id", "attempt_no"], name: "uk_pc2_unload_cards", unique: true

  create_table "pc_apps", force: :cascade do |t|
    t.string   "app_id",           limit: 50,                               null: false
    t.string   "is_enabled",       limit: 1,                                null: false
    t.integer  "lock_version",                 precision: 38,               null: false
    t.string   "approval_status",  limit: 1,                  default: "U", null: false
    t.string   "last_action",      limit: 1
    t.integer  "approved_version",             precision: 38
    t.integer  "approved_id",      limit: nil
    t.string   "created_by",       limit: 20
    t.string   "updated_by",       limit: 20
    t.datetime "created_at",                                                null: false
    t.datetime "updated_at",                                                null: false
    t.string   "needs_pin",        limit: 1,                  default: "f", null: false
    t.string   "identity_user_id", limit: 20,                               null: false
    t.string   "program_code",     limit: 15,                               null: false
  end

  add_index "pc_apps", ["app_id", "approval_status"], name: "i_pc_app_app_id_app_sta", unique: true

  create_table "pc_audit_logs", force: :cascade do |t|
    t.string   "req_no",            limit: 32,                  null: false
    t.string   "app_id",            limit: 32,                  null: false
    t.integer  "attempt_no",                     precision: 38, null: false
    t.string   "status_code",       limit: 25,                  null: false
    t.string   "pc_auditable_type",                             null: false
    t.integer  "pc_auditable_id",   limit: nil,                 null: false
    t.string   "fault_code"
    t.string   "fault_reason",      limit: 1000
    t.datetime "req_timestamp"
    t.datetime "rep_timestamp"
    t.text     "req_bitstream",                                 null: false
    t.text     "rep_bitstream"
    t.text     "fault_bitstream"
    t.string   "fault_subcode",     limit: 50
  end

  add_index "pc_audit_logs", ["app_id", "req_no", "attempt_no"], name: "uk_pc_audit_logs_1", unique: true
  add_index "pc_audit_logs", ["pc_auditable_type", "pc_auditable_id"], name: "uk_pc_audit_logs_2", unique: true

  create_table "pc_audit_steps", force: :cascade do |t|
    t.string   "pc_auditable_type",                             null: false
    t.integer  "pc_auditable_id",   limit: nil,                 null: false
    t.integer  "step_no",                        precision: 38, null: false
    t.integer  "attempt_no",                     precision: 38, null: false
    t.string   "step_name",         limit: 100,                 null: false
    t.string   "status_code",       limit: 25,                  null: false
    t.string   "fault_code"
    t.string   "fault_reason",      limit: 1000
    t.string   "req_reference"
    t.datetime "req_timestamp"
    t.string   "rep_reference"
    t.datetime "rep_timestamp"
    t.text     "req_bitstream"
    t.text     "rep_bitstream"
    t.text     "fault_bitstream"
    t.string   "fault_subcode",     limit: 50
  end

  add_index "pc_audit_steps", ["pc_auditable_type", "pc_auditable_id", "step_no", "attempt_no"], name: "uk_pc_audit_steps", unique: true

  create_table "pc_block_cards", force: :cascade do |t|
    t.string   "req_no",        limit: 32,                  null: false
    t.string   "app_id",        limit: 32,                  null: false
    t.integer  "attempt_no",                 precision: 38, null: false
    t.string   "status_code",   limit: 25,                  null: false
    t.string   "req_version",   limit: 5,                   null: false
    t.datetime "req_timestamp"
    t.string   "mobile_no"
    t.string   "email_id"
    t.string   "cust_uid"
    t.string   "password"
    t.string   "rep_no",        limit: 32
    t.string   "rep_version",   limit: 5
    t.datetime "rep_timestamp"
    t.string   "fault_code"
    t.string   "fault_reason",  limit: 1000
    t.string   "fault_subcode", limit: 50
  end

  add_index "pc_block_cards", ["req_no", "app_id", "attempt_no"], name: "uk_pc_block_cards_1", unique: true

  create_table "pc_card_registrations", force: :cascade do |t|
    t.string   "req_no",                limit: 32,                  null: false
    t.string   "app_id",                limit: 32,                  null: false
    t.integer  "attempt_no",                         precision: 38, null: false
    t.string   "status_code",           limit: 25,                  null: false
    t.string   "req_version",           limit: 5,                   null: false
    t.datetime "req_timestamp"
    t.string   "title",                 limit: 15
    t.string   "first_name"
    t.string   "last_name"
    t.string   "pref_name"
    t.string   "email_id"
    t.date     "birth_date"
    t.string   "nationality"
    t.integer  "country_code",                       precision: 38
    t.string   "mobile_no"
    t.string   "gender"
    t.string   "doc_type"
    t.string   "doc_no"
    t.string   "country_of_issue"
    t.string   "address_line1"
    t.string   "address_line2"
    t.string   "city"
    t.string   "state"
    t.string   "country"
    t.string   "postal_code",           limit: 15
    t.string   "proxy_card_no"
    t.integer  "pc_customer_id",        limit: nil
    t.string   "rep_no",                limit: 32
    t.string   "rep_version",           limit: 5
    t.datetime "rep_timestamp"
    t.string   "fault_code"
    t.string   "fault_reason",          limit: 1000
    t.string   "fault_subcode",         limit: 50
    t.string   "cust_uid"
    t.string   "card_uid"
    t.string   "card_no"
    t.date     "card_issue_date"
    t.integer  "card_expiry_year",                   precision: 38
    t.integer  "card_expiry_month",                  precision: 38
    t.string   "card_holder_name"
    t.string   "card_type"
    t.string   "card_name"
    t.string   "card_desc"
    t.string   "card_image_small_uri"
    t.string   "card_image_medium_uri"
    t.string   "card_image_large_uri"
    t.string   "program_code",          limit: 15
    t.string   "product_code",          limit: 15
  end

  add_index "pc_card_registrations", ["req_no", "app_id", "attempt_no"], name: "uk_pc_card_regs", unique: true

  create_table "pc_customer_credentials", force: :cascade do |t|
    t.string "username",                null: false
    t.string "password",                null: false
    t.string "program_code", limit: 15, null: false
  end

  add_index "pc_customer_credentials", ["username", "program_code"], name: "pc_credentials_01", unique: true

  create_table "pc_customers", force: :cascade do |t|
    t.string    "mobile_no",                                     null: false
    t.string    "title",              limit: 15
    t.string    "first_name"
    t.string    "last_name"
    t.string    "pref_name"
    t.string    "email_id"
    t.string    "password"
    t.string    "cust_status"
    t.string    "cust_uid"
    t.date      "birth_date"
    t.string    "nationality"
    t.integer   "country_code",                   precision: 38
    t.date      "reg_date"
    t.string    "gender"
    t.string    "doc_type"
    t.string    "doc_no"
    t.string    "country_of_issue"
    t.string    "address_line1"
    t.string    "address_line2"
    t.string    "city"
    t.string    "state"
    t.string    "country"
    t.string    "postal_code",        limit: 15
    t.string    "proxy_card_no"
    t.string    "card_uid"
    t.string    "card_no"
    t.string    "card_type"
    t.string    "card_name"
    t.string    "card_desc"
    t.string    "card_status"
    t.date      "card_issue_date"
    t.integer   "card_expiry_year",               precision: 38
    t.integer   "card_expiry_month",              precision: 38
    t.string    "card_currency_code"
    t.string    "app_id",             limit: 50
    t.string    "activation_code"
    t.timestamp "activated_at",       limit: 6
    t.string    "program_code",       limit: 15,                 null: false
    t.string    "product_code",       limit: 15,                 null: false
    t.string    "fault_code",         limit: 50
    t.string    "fault_reason",       limit: 500
  end

  add_index "pc_customers", ["email_id", "program_code"], name: "pc_customers_02", unique: true
  add_index "pc_customers", ["mobile_no", "program_code"], name: "pc_customers_01", unique: true

  create_table "pc_fee_rules", force: :cascade do |t|
    t.string   "txn_kind",         limit: 50,                               null: false
    t.integer  "no_of_tiers",                  precision: 38,               null: false
    t.string   "tier1_method",     limit: 3,                                null: false
    t.string   "tier2_method",     limit: 3
    t.string   "tier3_method",     limit: 3
    t.integer  "lock_version",                 precision: 38,               null: false
    t.string   "approval_status",  limit: 1,                  default: "U", null: false
    t.string   "last_action",      limit: 1
    t.integer  "approved_version",             precision: 38
    t.integer  "approved_id",      limit: nil
    t.string   "created_by",       limit: 20
    t.string   "updated_by",       limit: 20
    t.datetime "created_at",                                                null: false
    t.datetime "updated_at",                                                null: false
    t.decimal  "tier3_max_sc_amt"
    t.decimal  "tier3_min_sc_amt"
    t.decimal  "tier3_pct_value"
    t.decimal  "tier3_fixed_amt"
    t.decimal  "tier2_max_sc_amt"
    t.decimal  "tier2_min_sc_amt"
    t.decimal  "tier2_pct_value"
    t.decimal  "tier2_fixed_amt"
    t.decimal  "tier2_to_amt"
    t.decimal  "tier1_max_sc_amt",                                          null: false
    t.decimal  "tier1_min_sc_amt",                                          null: false
    t.decimal  "tier1_pct_value",                                           null: false
    t.decimal  "tier1_fixed_amt",                                           null: false
    t.decimal  "tier1_to_amt",                                              null: false
    t.string   "product_code",     limit: 15,                               null: false
  end

  add_index "pc_fee_rules", ["product_code", "txn_kind", "approval_status"], name: "pc_fee_rules_01", unique: true

  create_table "pc_load_cards", force: :cascade do |t|
    t.string   "req_no",           limit: 32,                  null: false
    t.string   "app_id",           limit: 32,                  null: false
    t.integer  "attempt_no",                    precision: 38, null: false
    t.string   "status_code",      limit: 25,                  null: false
    t.string   "req_version",      limit: 5,                   null: false
    t.datetime "req_timestamp"
    t.string   "customer_id",      limit: 15
    t.string   "mobile_no"
    t.string   "debit_acct_no"
    t.string   "email_id"
    t.string   "password"
    t.string   "rep_no",           limit: 32
    t.string   "rep_version",      limit: 5
    t.datetime "rep_timestamp"
    t.string   "fault_code"
    t.string   "fault_reason",     limit: 1000
    t.string   "cust_uid"
    t.decimal  "load_amount"
    t.string   "fault_subcode",    limit: 50
    t.decimal  "service_charge"
    t.string   "debit_fee_status", limit: 50
    t.string   "debit_fee_result", limit: 1000
  end

  add_index "pc_load_cards", ["req_no", "app_id", "attempt_no"], name: "uk_pc_load_cards", unique: true

  create_table "pc_mm_cd_incoming_files", force: :cascade do |t|
    t.string "file_name", limit: 100
  end

  add_index "pc_mm_cd_incoming_files", ["file_name"], name: "pc_incoming_files_01", unique: true

  create_table "pc_mm_cd_incoming_records", force: :cascade do |t|
    t.integer "incoming_file_record_id", limit: nil
    t.string  "file_name",               limit: 100
    t.string  "app_id",                  limit: 20
    t.string  "mobile_no",               limit: 20
    t.decimal "transfer_amount"
    t.string  "req_reference_no",        limit: 100
    t.string  "rep_reference_no",        limit: 100
    t.string  "rep_text",                limit: 100
    t.string  "crdr",                    limit: 1
  end

  add_index "pc_mm_cd_incoming_records", ["incoming_file_record_id"], name: "pc_incoming_records_01", unique: true

  create_table "pc_products", force: :cascade do |t|
    t.string   "code",                limit: 15,                               null: false
    t.string   "mm_host",                                                      null: false
    t.string   "mm_consumer_key",                                              null: false
    t.string   "mm_consumer_secret",                                           null: false
    t.string   "mm_card_type",                                                 null: false
    t.string   "mm_email_domain",                                              null: false
    t.string   "mm_admin_host",                                                null: false
    t.string   "mm_admin_user",                                                null: false
    t.string   "mm_admin_password",                                            null: false
    t.string   "is_enabled",          limit: 1,                                null: false
    t.datetime "created_at",                                                   null: false
    t.datetime "updated_at",                                                   null: false
    t.string   "created_by",          limit: 20
    t.string   "updated_by",          limit: 20
    t.integer  "lock_version",                    precision: 38, default: 0,   null: false
    t.string   "approval_status",     limit: 1,                  default: "U", null: false
    t.string   "last_action",         limit: 1,                  default: "C", null: false
    t.integer  "approved_version",                precision: 38
    t.integer  "approved_id",         limit: nil
    t.string   "card_acct",           limit: 20,                               null: false
    t.string   "sc_gl_income",        limit: 15,                               null: false
    t.string   "card_cust_id",                                                 null: false
    t.string   "display_name"
    t.string   "cust_care_no",        limit: 16,                               null: false
    t.string   "rkb_user",            limit: 30,                               null: false
    t.string   "rkb_password",                                                 null: false
    t.string   "rkb_bcagent",         limit: 50,                               null: false
    t.string   "rkb_channel_partner", limit: 3,                                null: false
    t.string   "program_code",        limit: 15,                               null: false
  end

  add_index "pc_products", ["code", "approval_status"], name: "pc_programs_01", unique: true

  create_table "pc_programs", force: :cascade do |t|
    t.string   "code",             limit: 15,                               null: false
    t.string   "is_enabled",       limit: 1,                                null: false
    t.datetime "created_at",                                                null: false
    t.datetime "updated_at",                                                null: false
    t.string   "created_by",       limit: 20
    t.string   "updated_by",       limit: 20
    t.integer  "lock_version",                 precision: 38, default: 0,   null: false
    t.string   "approval_status",  limit: 1,                  default: "U", null: false
    t.string   "last_action",      limit: 1,                  default: "C", null: false
    t.integer  "approved_version",             precision: 38
    t.integer  "approved_id",      limit: nil
  end

  add_index "pc_programs", ["code", "approval_status"], name: "pc_programs_02", unique: true

  create_table "pc_unapproved_records", force: :cascade do |t|
    t.integer  "pc_approvable_id",   limit: nil
    t.string   "pc_approvable_type"
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
  end

  create_table "pcs_add_beneficiaries", force: :cascade do |t|
    t.string   "req_no",         limit: 32,                  null: false
    t.string   "app_id",         limit: 32,                  null: false
    t.integer  "attempt_no",                  precision: 38, null: false
    t.string   "status_code",    limit: 25,                  null: false
    t.string   "req_version",    limit: 5,                   null: false
    t.datetime "req_timestamp"
    t.string   "mobile_no"
    t.string   "bene_name"
    t.string   "bene_acct_no"
    t.string   "bene_acct_ifsc"
    t.string   "rep_no",         limit: 32
    t.string   "rep_version",    limit: 5
    t.string   "bene_id"
    t.datetime "rep_timestamp"
    t.string   "fault_code"
    t.string   "fault_reason",   limit: 1000
  end

  add_index "pcs_add_beneficiaries", ["req_no", "app_id", "attempt_no"], name: "uk_pcs_add_beneficiaries", unique: true

  create_table "pcs_audit_logs", force: :cascade do |t|
    t.string   "req_no",             limit: 32,                  null: false
    t.string   "app_id",             limit: 32,                  null: false
    t.integer  "attempt_no",                      precision: 38, null: false
    t.string   "status_code",        limit: 25,                  null: false
    t.string   "pcs_auditable_type",                             null: false
    t.integer  "pcs_auditable_id",   limit: nil,                 null: false
    t.string   "fault_code"
    t.string   "fault_reason",       limit: 1000
    t.datetime "req_timestamp"
    t.datetime "rep_timestamp"
    t.text     "req_bitstream",                                  null: false
    t.text     "rep_bitstream"
    t.text     "fault_bitstream"
    t.string   "fault_subcode",      limit: 50
  end

  add_index "pcs_audit_logs", ["app_id", "req_no", "attempt_no"], name: "uk_pcs_audit_logs_1", unique: true
  add_index "pcs_audit_logs", ["pcs_auditable_type", "pcs_auditable_id"], name: "uk_pcs_audit_logs_2", unique: true

  create_table "pcs_audit_steps", force: :cascade do |t|
    t.string   "pcs_auditable_type",                             null: false
    t.integer  "pcs_auditable_id",   limit: nil,                 null: false
    t.integer  "step_no",                         precision: 38, null: false
    t.integer  "attempt_no",                      precision: 38, null: false
    t.string   "step_name",          limit: 100,                 null: false
    t.string   "status_code",        limit: 25,                  null: false
    t.string   "fault_code"
    t.string   "fault_reason",       limit: 1000
    t.string   "req_reference"
    t.datetime "req_timestamp"
    t.string   "rep_reference"
    t.datetime "rep_timestamp"
    t.text     "req_bitstream"
    t.text     "rep_bitstream"
    t.text     "fault_bitstream"
    t.string   "fault_subcode",      limit: 50
    t.datetime "reconciled_at"
    t.datetime "last_requery_at"
    t.integer  "requery_attempt_no",              precision: 38
    t.integer  "requery_for",                     precision: 38
    t.string   "requery_result"
  end

  add_index "pcs_audit_steps", ["pcs_auditable_type", "pcs_auditable_id", "step_no", "attempt_no"], name: "uk_pcs_audit_steps", unique: true

  create_table "pcs_pay_to_accounts", force: :cascade do |t|
    t.string   "req_no",            limit: 32,                  null: false
    t.string   "app_id",            limit: 32,                  null: false
    t.integer  "attempt_no",                     precision: 38, null: false
    t.string   "status_code",       limit: 50,                  null: false
    t.string   "req_version",       limit: 5,                   null: false
    t.datetime "req_timestamp"
    t.string   "mobile_no"
    t.string   "encrypted_pin"
    t.string   "transfer_type"
    t.string   "bene_acct_no"
    t.string   "bene_acct_ifsc"
    t.string   "transfer_amount"
    t.string   "rmtr_to_bene_note"
    t.string   "rep_no",            limit: 32
    t.string   "rep_version",       limit: 5
    t.string   "req_ref_no",        limit: 50
    t.string   "rep_ref_no",        limit: 50
    t.string   "rep_transfer_type", limit: 50
    t.datetime "rep_timestamp"
    t.string   "fault_code"
    t.string   "fault_reason",      limit: 1000
    t.string   "debit_fee_status",  limit: 50
    t.string   "debit_fee_result",  limit: 1000
    t.string   "bene_name",                                     null: false
    t.decimal  "service_charge"
  end

  add_index "pcs_pay_to_accounts", ["req_no", "app_id", "attempt_no"], name: "uk_pcs_pay_to_accounts", unique: true

  create_table "pcs_pay_to_contacts", force: :cascade do |t|
    t.string   "req_no",            limit: 32,                  null: false
    t.string   "app_id",            limit: 32,                  null: false
    t.integer  "attempt_no",                     precision: 38, null: false
    t.string   "status_code",       limit: 25,                  null: false
    t.string   "req_version",       limit: 5,                   null: false
    t.datetime "req_timestamp"
    t.string   "mobile_no"
    t.string   "contact_name"
    t.string   "contact_mobile_no"
    t.string   "encrypted_pin"
    t.string   "transfer_amount"
    t.string   "rep_no",            limit: 32
    t.string   "rep_version",       limit: 5
    t.string   "req_ref_no",        limit: 50
    t.string   "rep_ref_no",        limit: 50
    t.datetime "rep_timestamp"
    t.string   "fault_code"
    t.string   "fault_reason",      limit: 1000
    t.string   "debit_fee_status",  limit: 50
    t.string   "debit_fee_result",  limit: 1000
    t.decimal  "service_charge"
  end

  add_index "pcs_pay_to_contacts", ["req_no", "app_id", "attempt_no"], name: "uk_pcs_pay_to_contacts", unique: true

  create_table "pcs_pending_steps", force: :cascade do |t|
    t.string   "broker_uuid",                   null: false
    t.datetime "created_at",                    null: false
    t.integer  "pcs_audit_step_id", limit: nil
  end

  create_table "pcs_top_ups", force: :cascade do |t|
    t.string   "req_no",                                       null: false
    t.integer  "attempt_no",                    precision: 38, null: false
    t.string   "status_code",      limit: 25,                  null: false
    t.string   "req_version",      limit: 10,                  null: false
    t.datetime "req_timestamp",                                null: false
    t.string   "app_id",           limit: 50,                  null: false
    t.string   "mobile_no",        limit: 50
    t.string   "encrypted_pin",    limit: 50
    t.string   "biller_id",        limit: 50
    t.string   "subscriber_id",    limit: 50
    t.string   "rep_no"
    t.string   "rep_version",      limit: 10
    t.datetime "rep_timestamp"
    t.string   "debit_ref_no"
    t.string   "biller_ref_no",    limit: 50
    t.string   "debit_fee_status", limit: 50
    t.string   "debit_fee_result", limit: 1000
    t.string   "fault_code",       limit: 50
    t.string   "fault_reason",     limit: 1000
    t.decimal  "service_charge"
    t.decimal  "transfer_amount"
  end

  add_index "pcs_top_ups", ["req_no", "app_id", "attempt_no"], name: "uk_pcs_top_ups", unique: true

  create_table "pending_incoming_files", force: :cascade do |t|
    t.string   "broker_uuid",      limit: 500
    t.integer  "incoming_file_id", limit: nil
    t.datetime "created_at"
  end

  create_table "pending_inward_remittances", force: :cascade do |t|
    t.integer  "inward_remittance_id", limit: nil,                null: false
    t.string   "broker_uuid",                                     null: false
    t.datetime "created_at",                                      null: false
    t.datetime "updated_at",                                      null: false
    t.integer  "attempt_no",                       precision: 38
  end

  add_index "pending_inward_remittances", ["inward_remittance_id"], name: "i_pen_inw_rem_inw_rem_id", unique: true

  create_table "pending_response_files", force: :cascade do |t|
    t.string   "broker_uuid",      limit: 500
    t.integer  "incoming_file_id", limit: nil
    t.datetime "created_at"
  end

  add_index "pending_response_files", ["incoming_file_id"], name: "incoming_file_id_1", unique: true

  create_table "pending_sm_payments", force: :cascade do |t|
    t.string   "broker_uuid",                              null: false
    t.integer  "sm_payment_id", limit: nil,                null: false
    t.datetime "created_at",                               null: false
    t.integer  "attempt_no",                precision: 38
  end

  create_table "purpose_codes", force: :cascade do |t|
    t.string   "code",                  limit: 5
    t.string   "description"
    t.string   "is_enabled",            limit: 1
    t.string   "created_by",            limit: 20
    t.string   "updated_by",            limit: 20
    t.integer  "lock_version",                       precision: 38, default: 0,   null: false
    t.decimal  "txn_limit"
    t.integer  "daily_txn_limit",                    precision: 38
    t.string   "disallowed_rem_types",  limit: 30
    t.string   "disallowed_bene_types", limit: 30
    t.datetime "created_at"
    t.datetime "updated_at"
    t.decimal  "mtd_txn_cnt_self"
    t.decimal  "mtd_txn_limit_self"
    t.decimal  "mtd_txn_cnt_sp"
    t.decimal  "mtd_txn_limit_sp"
    t.string   "rbi_code",              limit: 5
    t.string   "pattern_beneficiaries", limit: 4000
    t.string   "approval_status",       limit: 1,                   default: "U", null: false
    t.string   "last_action",           limit: 1,                   default: "C"
    t.integer  "approved_version",                   precision: 38
    t.integer  "approved_id",           limit: nil
    t.string   "pattern_allowed_benes", limit: 4000
    t.integer  "guideline_id",          limit: nil,                 default: 1,   null: false
    t.string   "ripple_purpose_code"
  end

  add_index "purpose_codes", ["code", "approval_status"], name: "purpose_codes_01", unique: true

  create_table "rc_apps", force: :cascade do |t|
    t.string   "app_id",           limit: 50,                               null: false
    t.integer  "udfs_cnt",         limit: nil
    t.string   "udf1"
    t.string   "udf2"
    t.string   "udf3"
    t.string   "udf4"
    t.string   "udf5"
    t.datetime "created_at",                                                null: false
    t.datetime "updated_at",                                                null: false
    t.string   "created_by",       limit: 20
    t.string   "updated_by",       limit: 20
    t.integer  "lock_version",                 precision: 38, default: 0,   null: false
    t.string   "last_action",      limit: 1,                  default: "C", null: false
    t.string   "url",                                                       null: false
    t.string   "http_username",    limit: 50
    t.string   "http_password",    limit: 50
    t.string   "setting1"
    t.string   "setting2"
    t.integer  "settings_cnt",     limit: nil,                default: 0,   null: false
    t.string   "approval_status",  limit: 1,                  default: "U", null: false
    t.integer  "approved_version",             precision: 38
    t.integer  "approved_id",      limit: nil
    t.string   "setting3"
    t.string   "setting4"
    t.string   "setting5"
  end

  add_index "rc_apps", ["app_id", "approval_status"], name: "rc_apps_02", unique: true

  create_table "rc_aud_ste_bkp_180903to181231", id: false, force: :cascade do |t|
    t.integer  "id",                limit: nil,                 null: false
    t.string   "rc_auditable_type",                             null: false
    t.integer  "rc_auditable_id",   limit: nil,                 null: false
    t.integer  "step_no",                        precision: 38, null: false
    t.integer  "attempt_no",                     precision: 38, null: false
    t.string   "step_name",         limit: 100,                 null: false
    t.string   "status_code",       limit: 25,                  null: false
    t.string   "fault_code"
    t.string   "fault_subcode",     limit: 50
    t.string   "fault_reason",      limit: 1000
    t.string   "req_reference"
    t.datetime "req_timestamp"
    t.string   "rep_reference"
    t.datetime "rep_timestamp"
    t.text     "req_bitstream"
    t.text     "rep_bitstream"
    t.text     "fault_bitstream"
  end

  create_table "rc_aud_ste_bkp_181101to181231", id: false, force: :cascade do |t|
    t.integer  "id",                limit: nil,                 null: false
    t.string   "rc_auditable_type",                             null: false
    t.integer  "rc_auditable_id",   limit: nil,                 null: false
    t.integer  "step_no",                        precision: 38, null: false
    t.integer  "attempt_no",                     precision: 38, null: false
    t.string   "step_name",         limit: 100,                 null: false
    t.string   "status_code",       limit: 25,                  null: false
    t.string   "fault_code"
    t.string   "fault_subcode",     limit: 50
    t.string   "fault_reason",      limit: 1000
    t.string   "req_reference"
    t.datetime "req_timestamp"
    t.string   "rep_reference"
    t.datetime "rep_timestamp"
    t.text     "req_bitstream"
    t.text     "rep_bitstream"
    t.text     "fault_bitstream"
  end

  create_table "rc_aud_step_bkp_180903to181231", id: false, force: :cascade do |t|
    t.integer  "id",                limit: nil,                 null: false
    t.string   "rc_auditable_type",                             null: false
    t.integer  "rc_auditable_id",   limit: nil,                 null: false
    t.integer  "step_no",                        precision: 38, null: false
    t.integer  "attempt_no",                     precision: 38, null: false
    t.string   "step_name",         limit: 100,                 null: false
    t.string   "status_code",       limit: 25,                  null: false
    t.string   "fault_code"
    t.string   "fault_subcode",     limit: 50
    t.string   "fault_reason",      limit: 1000
    t.string   "req_reference"
    t.datetime "req_timestamp"
    t.string   "rep_reference"
    t.datetime "rep_timestamp"
    t.text     "req_bitstream"
    t.text     "rep_bitstream"
    t.text     "fault_bitstream"
  end

  create_table "rc_aud_step_bkp_181101to181224", id: false, force: :cascade do |t|
    t.integer  "id",                limit: nil,                 null: false
    t.string   "rc_auditable_type",                             null: false
    t.integer  "rc_auditable_id",   limit: nil,                 null: false
    t.integer  "step_no",                        precision: 38, null: false
    t.integer  "attempt_no",                     precision: 38, null: false
    t.string   "step_name",         limit: 100,                 null: false
    t.string   "status_code",       limit: 25,                  null: false
    t.string   "fault_code"
    t.string   "fault_subcode",     limit: 50
    t.string   "fault_reason",      limit: 1000
    t.string   "req_reference"
    t.datetime "req_timestamp"
    t.string   "rep_reference"
    t.datetime "rep_timestamp"
    t.text     "req_bitstream"
    t.text     "rep_bitstream"
    t.text     "fault_bitstream"
  end

  create_table "rc_aud_step_bkp_181101to181231", id: false, force: :cascade do |t|
    t.integer  "id",                limit: nil,                 null: false
    t.string   "rc_auditable_type",                             null: false
    t.integer  "rc_auditable_id",   limit: nil,                 null: false
    t.integer  "step_no",                        precision: 38, null: false
    t.integer  "attempt_no",                     precision: 38, null: false
    t.string   "step_name",         limit: 100,                 null: false
    t.string   "status_code",       limit: 25,                  null: false
    t.string   "fault_code"
    t.string   "fault_subcode",     limit: 50
    t.string   "fault_reason",      limit: 1000
    t.string   "req_reference"
    t.datetime "req_timestamp"
    t.string   "rep_reference"
    t.datetime "rep_timestamp"
    t.text     "req_bitstream"
    t.text     "rep_bitstream"
    t.text     "fault_bitstream"
  end

  create_table "rc_aud_step_bkp_190101to190115", id: false, force: :cascade do |t|
    t.integer  "id",                limit: nil,                 null: false
    t.string   "rc_auditable_type",                             null: false
    t.integer  "rc_auditable_id",   limit: nil,                 null: false
    t.integer  "step_no",                        precision: 38, null: false
    t.integer  "attempt_no",                     precision: 38, null: false
    t.string   "step_name",         limit: 100,                 null: false
    t.string   "status_code",       limit: 25,                  null: false
    t.string   "fault_code"
    t.string   "fault_subcode",     limit: 50
    t.string   "fault_reason",      limit: 1000
    t.string   "req_reference"
    t.datetime "req_timestamp"
    t.string   "rep_reference"
    t.datetime "rep_timestamp"
    t.text     "req_bitstream"
    t.text     "rep_bitstream"
    t.text     "fault_bitstream"
  end

  create_table "rc_aud_step_bkp_190102to190130", id: false, force: :cascade do |t|
    t.integer  "id",                limit: nil,                 null: false
    t.string   "rc_auditable_type",                             null: false
    t.integer  "rc_auditable_id",   limit: nil,                 null: false
    t.integer  "step_no",                        precision: 38, null: false
    t.integer  "attempt_no",                     precision: 38, null: false
    t.string   "step_name",         limit: 100,                 null: false
    t.string   "status_code",       limit: 25,                  null: false
    t.string   "fault_code"
    t.string   "fault_subcode",     limit: 50
    t.string   "fault_reason",      limit: 1000
    t.string   "req_reference"
    t.datetime "req_timestamp"
    t.string   "rep_reference"
    t.datetime "rep_timestamp"
    t.text     "req_bitstream"
    t.text     "rep_bitstream"
    t.text     "fault_bitstream"
  end

  create_table "rc_audit_steps", force: :cascade do |t|
    t.string   "rc_auditable_type",                             null: false
    t.integer  "rc_auditable_id",   limit: nil,                 null: false
    t.integer  "step_no",                        precision: 38, null: false
    t.integer  "attempt_no",                     precision: 38, null: false
    t.string   "step_name",         limit: 100,                 null: false
    t.string   "status_code",       limit: 25,                  null: false
    t.string   "fault_code"
    t.string   "fault_subcode",     limit: 50
    t.string   "fault_reason",      limit: 1000
    t.string   "req_reference"
    t.datetime "req_timestamp"
    t.string   "rep_reference"
    t.datetime "rep_timestamp"
    t.text     "req_bitstream"
    t.text     "rep_bitstream"
    t.text     "fault_bitstream"
  end

  add_index "rc_audit_steps", ["rc_auditable_type", "rc_auditable_id", "step_no", "attempt_no"], name: "rc_audit_steps_01", unique: true

  create_table "rc_pending_confirmations", force: :cascade do |t|
    t.string   "broker_uuid"
    t.string   "rc_auditable_type",             null: false
    t.integer  "rc_auditable_id",   limit: nil, null: false
    t.datetime "created_at",                    null: false
  end

  add_index "rc_pending_confirmations", ["broker_uuid", "created_at"], name: "rc_pending_confirmations_02"
  add_index "rc_pending_confirmations", ["rc_auditable_id", "rc_auditable_type"], name: "rc_pending_confirmations_01", unique: true

  create_table "rc_pending_notifications", force: :cascade do |t|
    t.string   "broker_uuid",                   null: false
    t.string   "rc_auditable_type",             null: false
    t.integer  "rc_auditable_id",   limit: nil, null: false
    t.datetime "created_at",                    null: false
  end

  create_table "rc_pending_schedules", force: :cascade do |t|
    t.string   "broker_uuid"
    t.string   "rc_auditable_type",             null: false
    t.integer  "rc_auditable_id",   limit: nil, null: false
    t.datetime "created_at",                    null: false
    t.integer  "rc_schedule_id",    limit: nil, null: false
  end

  add_index "rc_pending_schedules", ["broker_uuid", "created_at"], name: "rc_pending_schedules_02"
  add_index "rc_pending_schedules", ["rc_auditable_id", "rc_auditable_type"], name: "rc_pending_schedules_01", unique: true

  create_table "rc_pending_transfers", force: :cascade do |t|
    t.string   "broker_uuid",                   null: false
    t.string   "rc_auditable_type",             null: false
    t.integer  "rc_auditable_id",   limit: nil, null: false
    t.datetime "created_at",                    null: false
  end

  create_table "rc_trans_bkp_181101to181231", id: false, force: :cascade do |t|
    t.integer  "id",                limit: nil,                 null: false
    t.string   "rc_transfer_code",  limit: 50,                  null: false
    t.string   "app_code",          limit: 50
    t.integer  "batch_no",                       precision: 38, null: false
    t.string   "status_code",       limit: 50,                  null: false
    t.datetime "started_at",                                    null: false
    t.string   "debit_account_no",  limit: 20,                  null: false
    t.string   "bene_account_no",   limit: 20,                  null: false
    t.decimal  "transfer_amount"
    t.string   "transfer_req_ref",  limit: 50
    t.string   "transfer_rep_ref",  limit: 50
    t.datetime "transferred_at"
    t.string   "notify_status",     limit: 50
    t.integer  "notify_attempt_no",              precision: 38
    t.datetime "notify_attempt_at"
    t.datetime "notified_at"
    t.string   "notify_result",     limit: 50
    t.string   "fault_code",        limit: 50
    t.string   "fault_subcode",     limit: 50
    t.string   "fault_reason",      limit: 1000
  end

  create_table "rc_trans_bkp_181105to181218", id: false, force: :cascade do |t|
    t.integer  "id",                limit: nil,                 null: false
    t.string   "rc_transfer_code",  limit: 50,                  null: false
    t.string   "app_code",          limit: 50
    t.integer  "batch_no",                       precision: 38, null: false
    t.string   "status_code",       limit: 50,                  null: false
    t.datetime "started_at",                                    null: false
    t.string   "debit_account_no",  limit: 20,                  null: false
    t.string   "bene_account_no",   limit: 20,                  null: false
    t.decimal  "transfer_amount"
    t.string   "transfer_req_ref",  limit: 50
    t.string   "transfer_rep_ref",  limit: 50
    t.datetime "transferred_at"
    t.string   "notify_status",     limit: 50
    t.integer  "notify_attempt_no",              precision: 38
    t.datetime "notify_attempt_at"
    t.datetime "notified_at"
    t.string   "notify_result",     limit: 50
    t.string   "fault_code",        limit: 50
    t.string   "fault_subcode",     limit: 50
    t.string   "fault_reason",      limit: 1000
  end

  create_table "rc_trans_bkp_181211to181218", id: false, force: :cascade do |t|
    t.integer  "id",                limit: nil,                 null: false
    t.string   "rc_transfer_code",  limit: 50,                  null: false
    t.string   "app_code",          limit: 50
    t.integer  "batch_no",                       precision: 38, null: false
    t.string   "status_code",       limit: 50,                  null: false
    t.datetime "started_at",                                    null: false
    t.string   "debit_account_no",  limit: 20,                  null: false
    t.string   "bene_account_no",   limit: 20,                  null: false
    t.decimal  "transfer_amount"
    t.string   "transfer_req_ref",  limit: 50
    t.string   "transfer_rep_ref",  limit: 50
    t.datetime "transferred_at"
    t.string   "notify_status",     limit: 50
    t.integer  "notify_attempt_no",              precision: 38
    t.datetime "notify_attempt_at"
    t.datetime "notified_at"
    t.string   "notify_result",     limit: 50
    t.string   "fault_code",        limit: 50
    t.string   "fault_subcode",     limit: 50
    t.string   "fault_reason",      limit: 1000
  end

  create_table "rc_trans_bkp_190101to190131", id: false, force: :cascade do |t|
    t.integer  "id",                limit: nil,                 null: false
    t.string   "rc_transfer_code",  limit: 50,                  null: false
    t.string   "app_code",          limit: 50
    t.integer  "batch_no",                       precision: 38, null: false
    t.string   "status_code",       limit: 50,                  null: false
    t.datetime "started_at",                                    null: false
    t.string   "debit_account_no",  limit: 20,                  null: false
    t.string   "bene_account_no",   limit: 20,                  null: false
    t.decimal  "transfer_amount"
    t.string   "transfer_req_ref",  limit: 50
    t.string   "transfer_rep_ref",  limit: 50
    t.datetime "transferred_at"
    t.string   "notify_status",     limit: 50
    t.integer  "notify_attempt_no",              precision: 38
    t.datetime "notify_attempt_at"
    t.datetime "notified_at"
    t.string   "notify_result",     limit: 50
    t.string   "fault_code",        limit: 50
    t.string   "fault_subcode",     limit: 50
    t.string   "fault_reason",      limit: 1000
  end

  create_table "rc_trans_bkp_190102to190130", id: false, force: :cascade do |t|
    t.integer  "id",                limit: nil,                 null: false
    t.string   "rc_transfer_code",  limit: 50,                  null: false
    t.string   "app_code",          limit: 50
    t.integer  "batch_no",                       precision: 38, null: false
    t.string   "status_code",       limit: 50,                  null: false
    t.datetime "started_at",                                    null: false
    t.string   "debit_account_no",  limit: 20,                  null: false
    t.string   "bene_account_no",   limit: 20,                  null: false
    t.decimal  "transfer_amount"
    t.string   "transfer_req_ref",  limit: 50
    t.string   "transfer_rep_ref",  limit: 50
    t.datetime "transferred_at"
    t.string   "notify_status",     limit: 50
    t.integer  "notify_attempt_no",              precision: 38
    t.datetime "notify_attempt_at"
    t.datetime "notified_at"
    t.string   "notify_result",     limit: 50
    t.string   "fault_code",        limit: 50
    t.string   "fault_subcode",     limit: 50
    t.string   "fault_reason",      limit: 1000
  end

  create_table "rc_transfer_schedule", force: :cascade do |t|
    t.string   "code",               limit: 50
    t.string   "debit_account_no",   limit: 20
    t.string   "bene_account_no",    limit: 20
    t.datetime "next_run_at"
    t.datetime "last_run_at"
    t.string   "app_code"
    t.string   "is_enabled",         limit: 1
    t.integer  "last_batch_no",                  precision: 38
    t.datetime "created_at",                                                   null: false
    t.datetime "updated_at",                                                   null: false
    t.string   "created_by",         limit: 20
    t.string   "updated_by",         limit: 20
    t.integer  "lock_version",                   precision: 38, default: 0,    null: false
    t.string   "approval_status",    limit: 1,                  default: "U",  null: false
    t.string   "last_action",        limit: 1,                  default: "C",  null: false
    t.integer  "approved_version",               precision: 38
    t.integer  "approved_id",        limit: nil
    t.string   "notify_mobile_no"
    t.string   "udf1"
    t.string   "udf2"
    t.string   "udf3"
    t.string   "udf4"
    t.string   "udf5"
    t.integer  "rc_app_id",          limit: nil
    t.string   "txn_kind",           limit: 20,                 default: "FT", null: false
    t.integer  "interval_in_mins",               precision: 38, default: 5,    null: false
    t.decimal  "acct_threshold_amt"
    t.string   "bene_account_ifsc"
    t.integer  "max_retries",                    precision: 38, default: 0,    null: false
    t.integer  "retry_in_mins",                  precision: 38, default: 0,    null: false
    t.string   "bene_name",          limit: 25
  end

  add_index "rc_transfer_schedule", ["code", "approval_status"], name: "rc_transfer_schedules_01", unique: true
  add_index "rc_transfer_schedule", ["rc_app_id"], name: "i_rc_tra_sch_rc_app_id"

  create_table "rc_transfer_unapproved_records", force: :cascade do |t|
    t.integer  "rc_transfer_approvable_id",   limit: nil
    t.string   "rc_transfer_approvable_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "rc_transfers", force: :cascade do |t|
    t.string   "rc_transfer_code",  limit: 50,                  null: false
    t.string   "app_code",          limit: 50
    t.integer  "batch_no",                       precision: 38, null: false
    t.string   "status_code",       limit: 50,                  null: false
    t.datetime "started_at",                                    null: false
    t.string   "debit_account_no",  limit: 20,                  null: false
    t.string   "bene_account_no",   limit: 20,                  null: false
    t.decimal  "transfer_amount"
    t.string   "transfer_req_ref",  limit: 50
    t.string   "transfer_rep_ref",  limit: 50
    t.datetime "transferred_at"
    t.string   "notify_status",     limit: 50
    t.integer  "notify_attempt_no",              precision: 38
    t.datetime "notify_attempt_at"
    t.datetime "notified_at"
    t.string   "notify_result",     limit: 50
    t.string   "fault_code",        limit: 50
    t.string   "fault_subcode",     limit: 50
    t.string   "fault_reason",      limit: 1000
  end

  add_index "rc_transfers", ["batch_no"], name: "rc_transfers_01"

  create_table "reconciled_returns", force: :cascade do |t|
    t.string   "txn_type",        limit: 10,   null: false
    t.string   "return_code",     limit: 10,   null: false
    t.date     "settlement_date",              null: false
    t.string   "bank_ref_no",     limit: 32,   null: false
    t.string   "reason",          limit: 1000, null: false
    t.string   "created_by",      limit: 20
    t.string   "updated_by",      limit: 20
    t.string   "last_action",     limit: 1
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
  end

  add_index "reconciled_returns", ["bank_ref_no", "txn_type"], name: "reconciled_returns_01", unique: true
  add_index "reconciled_returns", ["bank_ref_no"], name: "i_rec_ret_ban_ref_no"

  create_table "remit_transactions", force: :cascade do |t|
    t.string   "payment_id"
    t.string   "inw_req_no"
    t.string   "partner_code"
    t.string   "sender_mid_id"
    t.datetime "req_timestamp"
    t.string   "remit_status"
    t.string   "inw_status_code"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "remittance_reviews", force: :cascade do |t|
    t.string   "transaction_id",     limit: 5,                   null: false
    t.string   "justification_code", limit: 5,                   null: false
    t.string   "justification_text", limit: 2000
    t.string   "review_status",      limit: 10,                  null: false
    t.datetime "reviewed_at"
    t.string   "review_remarks",     limit: 2000
    t.string   "reviewed_by",        limit: 50
    t.string   "created_by",         limit: 20
    t.string   "updated_by",         limit: 20
    t.integer  "lock_version",                    precision: 38
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "roles", force: :cascade do |t|
    t.string   "name"
    t.integer  "resource_id",   limit: nil
    t.string   "resource_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "roles", ["name", "resource_type", "resource_id"], name: "i_rol_nam_res_typ_res_id"
  add_index "roles", ["name"], name: "index_roles_on_name"

  create_table "rp_authorized_users", force: :cascade do |t|
    t.integer "available_report_id", limit: nil
    t.integer "user_id",             limit: nil
  end

  add_index "rp_authorized_users", ["available_report_id", "user_id"], name: "i_rp_aut_use_ava_rep_id_use_id", unique: true

  create_table "rp_available_reports", force: :cascade do |t|
    t.string   "name",                                                                   null: false
    t.string   "dsn",                                                                    null: false
    t.string   "db_unit",                                                                null: false
    t.string   "msg_model"
    t.string   "mime_type"
    t.string   "file_ext"
    t.datetime "created_at",                                                             null: false
    t.datetime "updated_at",                                                             null: false
    t.integer  "params_cnt",       limit: nil
    t.string   "param1",           limit: 500
    t.string   "param2",           limit: 500
    t.string   "param3",           limit: 500
    t.string   "param4",           limit: 500
    t.string   "param5",           limit: 500
    t.string   "is_public",                                   default: "Y"
    t.integer  "batch_size",                   precision: 38, default: 50,               null: false
    t.string   "header_kind",      limit: 1,                  default: "C",              null: false
    t.string   "money_format",     limit: 20,                 default: "###,###,##0.00", null: false
    t.string   "normalize_space",  limit: 1,                  default: "Y"
    t.string   "delimiter",        limit: 1,                  default: ","
    t.string   "escape_character", limit: 1,                  default: "\""
    t.string   "service_code",     limit: 100,                default: "RP"
    t.string   "code",                                                                   null: false
  end

  add_index "rp_available_reports", ["code"], name: "rp_available_reports_01", unique: true

  create_table "rp_pending_reports", force: :cascade do |t|
    t.string   "broker_uuid",  limit: 500
    t.datetime "created_at"
    t.integer  "report_id",    limit: nil
    t.datetime "run_at"
    t.string   "service_code", limit: 100
  end

  add_index "rp_pending_reports", ["broker_uuid"], name: "i_rp_pen_rep_bro_uui"
  add_index "rp_pending_reports", ["report_id"], name: "i_rp_pending_reports_report_id", unique: true

  create_table "rp_reports", force: :cascade do |t|
    t.string   "name",               limit: 100,                                            null: false
    t.string   "state",              limit: 50,                                             null: false
    t.datetime "queued_at",                                                                 null: false
    t.string   "mime_type"
    t.string   "created_by",         limit: 20
    t.string   "report_url"
    t.string   "notify_to"
    t.string   "dsn"
    t.string   "db_unit"
    t.string   "batch_size"
    t.string   "msg_model"
    t.string   "file_ext"
    t.datetime "started_at"
    t.datetime "finished_at"
    t.integer  "line_count",                      precision: 38
    t.integer  "size_in_bytes",                   precision: 38
    t.string   "file_name"
    t.string   "file_path"
    t.string   "fault_code",         limit: 50
    t.string   "fault_subcode",      limit: 50
    t.string   "fault_reason",       limit: 1000
    t.text     "fault_bitstream"
    t.string   "param1"
    t.string   "param2"
    t.string   "param3"
    t.string   "param4"
    t.string   "param5"
    t.string   "file_url"
    t.string   "email_alert_ref_no"
    t.string   "broker_uuid",        limit: 100
    t.string   "header_kind",        limit: 1,                   default: "C",              null: false
    t.string   "money_format",       limit: 20,                  default: "###,###,##0.00", null: false
    t.string   "normalize_space",    limit: 1,                   default: "Y"
    t.string   "delimiter",          limit: 1,                   default: ","
    t.string   "escape_character",   limit: 1,                   default: "\""
    t.string   "service_code",       limit: 100
  end

  add_index "rp_reports", ["state", "broker_uuid"], name: "i_rp_reports_state_broker_uuid"

  create_table "rp_settings", force: :cascade do |t|
    t.string  "scheme",                                    null: false
    t.string  "host"
    t.string  "username"
    t.string  "password"
    t.string  "virtual_path"
    t.integer "max_age_days",  precision: 38, default: 7,  null: false
    t.integer "max_per_user",  precision: 38, default: 7,  null: false
    t.integer "query_timeout", precision: 38, default: 60
  end

  create_table "rp_users", force: :cascade do |t|
    t.string   "name",                                  default: "", null: false
    t.string   "email",                                 default: "", null: false
    t.string   "encrypted_password",                    default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          precision: 38, default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                                         null: false
    t.datetime "updated_at",                                         null: false
  end

  add_index "rp_users", ["email"], name: "index_rp_users_on_email", unique: true
  add_index "rp_users", ["reset_password_token"], name: "i_rp_use_res_pas_tok", unique: true

  create_table "rpl_audit_logs", force: :cascade do |t|
    t.string   "req_no",             limit: 100,                 null: false
    t.integer  "attempt_no",                      precision: 38, null: false
    t.string   "status_code",        limit: 25,                  null: false
    t.string   "rpl_auditable_type",                             null: false
    t.integer  "rpl_auditable_id",   limit: nil,                 null: false
    t.string   "fault_code",         limit: 50
    t.string   "fault_subcode",      limit: 50
    t.string   "fault_reason",       limit: 1000
    t.datetime "req_timestamp"
    t.datetime "rep_timestamp"
    t.text     "req_bitstream",                                  null: false
    t.text     "rep_bitstream"
    t.text     "fault_bitstream"
  end

  add_index "rpl_audit_logs", ["req_no", "attempt_no"], name: "rpl_audit_logs_01", unique: true
  add_index "rpl_audit_logs", ["rpl_auditable_type", "rpl_auditable_id"], name: "rpl_audit_logs_02", unique: true

  create_table "rpl_audit_steps", force: :cascade do |t|
    t.string   "rpl_auditable_type",                             null: false
    t.integer  "rpl_auditable_id",   limit: nil,                 null: false
    t.integer  "step_no",                         precision: 38, null: false
    t.integer  "attempt_no",                      precision: 38, null: false
    t.string   "step_name",          limit: 100,                 null: false
    t.string   "status_code",        limit: 25,                  null: false
    t.string   "fault_code",         limit: 50
    t.string   "fault_subcode",      limit: 50
    t.string   "fault_reason",       limit: 1000
    t.string   "req_reference"
    t.datetime "req_timestamp"
    t.string   "rep_reference"
    t.datetime "rep_timestamp"
    t.text     "req_bitstream"
    t.text     "rep_bitstream"
    t.text     "fault_bitstream"
    t.string   "remote_host",        limit: 500
    t.string   "req_uri",            limit: 500
    t.text     "req_header"
    t.text     "rep_header"
  end

  add_index "rpl_audit_steps", ["rpl_auditable_type", "rpl_auditable_id", "step_no", "attempt_no"], name: "rpl_audit_steps_01", unique: true

  create_table "rpl_fault_codes", force: :cascade do |t|
    t.string   "backend_code",          limit: 50,                                null: false
    t.string   "backend_fault_code",    limit: 50,                                null: false
    t.string   "backend_fault_subcode", limit: 50,                                null: false
    t.string   "rpl_fault_type",        limit: 50,                                null: false
    t.string   "rpl_fault_code",        limit: 50,                                null: false
    t.string   "rpl_fault_reason",      limit: 1000,                              null: false
    t.string   "is_enabled",            limit: 1,                   default: "Y", null: false
    t.datetime "created_at",                                                      null: false
    t.datetime "updated_at",                                                      null: false
    t.string   "created_by",            limit: 20
    t.string   "updated_by",            limit: 20
    t.integer  "lock_version",                       precision: 38, default: 0,   null: false
    t.string   "last_action",           limit: 1,                   default: "C", null: false
    t.string   "approval_status",       limit: 1,                   default: "U", null: false
    t.integer  "approved_version",                   precision: 38
    t.integer  "approved_id",           limit: nil
  end

  add_index "rpl_fault_codes", ["backend_code", "backend_fault_code", "backend_fault_subcode", "approval_status"], name: "rpl_fault_codes_01", unique: true

  create_table "rpl_ledger_credits", force: :cascade do |t|
    t.string   "reference_no",     limit: 100,                                null: false
    t.decimal  "amount",                                                      null: false
    t.string   "status",           limit: 50,                 default: "NEW", null: false
    t.datetime "created_at",                                                  null: false
    t.datetime "updated_at",                                                  null: false
    t.string   "created_by",       limit: 20
    t.string   "updated_by",       limit: 20
    t.integer  "lock_version",                 precision: 38, default: 0,     null: false
    t.string   "last_action",      limit: 1,                  default: "C",   null: false
    t.string   "approval_status",  limit: 1,                  default: "U",   null: false
    t.integer  "approved_version",             precision: 38
    t.integer  "approved_id",      limit: nil
  end

  add_index "rpl_ledger_credits", ["reference_no", "approval_status"], name: "rpl_ledger_credits_01", unique: true

  create_table "rpl_pending_ledger_credits", force: :cascade do |t|
    t.string   "app_uuid"
    t.string   "rpl_auditable_type",             null: false
    t.integer  "rpl_auditable_id",   limit: nil, null: false
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
  end

  add_index "rpl_pending_ledger_credits", ["rpl_auditable_id", "rpl_auditable_type"], name: ":rpl_pending_ledger_credits_01", unique: true

  create_table "rpl_pending_notifications", force: :cascade do |t|
    t.string   "app_uuid"
    t.string   "rpl_auditable_type",             null: false
    t.integer  "rpl_auditable_id",   limit: nil, null: false
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
  end

  add_index "rpl_pending_notifications", ["rpl_auditable_id", "rpl_auditable_type"], name: "rpl_pending_notifications_01", unique: true

  create_table "rpl_pending_remittances", force: :cascade do |t|
    t.string   "app_uuid",                      null: false
    t.integer  "rpl_remittance_id", limit: nil, null: false
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
  end

  add_index "rpl_pending_remittances", ["app_uuid", "created_at"], name: "rpl_pending_transfers_02"
  add_index "rpl_pending_remittances", ["rpl_remittance_id"], name: "rpl_pending_transfers_01", unique: true

  create_table "rpl_remittances", force: :cascade do |t|
    t.string   "sender_entity",        limit: 100,                 null: false
    t.string   "payment_id",           limit: 100,                 null: false
    t.string   "partner_code",         limit: 10
    t.datetime "req_timestamp",                                    null: false
    t.string   "inw_req_no",           limit: 64,                  null: false
    t.integer  "inw_attempt_no",                    precision: 38
    t.string   "inw_status_code",      limit: 50,                  null: false
    t.string   "notify_status",        limit: 50
    t.string   "notify_result",        limit: 100
    t.integer  "notify_attempt_no",                 precision: 38
    t.datetime "notify_attempt_at"
    t.datetime "notified_at"
    t.datetime "rep_timestamp"
    t.string   "fault_code",           limit: 50
    t.string   "fault_subcode",        limit: 50
    t.string   "fault_reason",         limit: 1000
    t.string   "ledger_credit_status", limit: 50
  end

  add_index "rpl_remittances", ["inw_req_no"], name: "rpl_remittances_02", unique: true
  add_index "rpl_remittances", ["payment_id"], name: "rpl_remittances_01", unique: true

  create_table "rpl_reports", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "rr_incoming_files", force: :cascade do |t|
    t.string "file_name", limit: 50
  end

  add_index "rr_incoming_files", ["file_name"], name: "rr_incoming_files_01", unique: true

  create_table "rr_incoming_records", force: :cascade do |t|
    t.integer   "incoming_file_record_id", limit: nil
    t.string    "file_name",               limit: 50
    t.string    "txn_type",                limit: 4
    t.string    "return_code",             limit: 20
    t.timestamp "settlement_date",         limit: 6
    t.string    "bank_ref_no",             limit: 32
    t.string    "reason",                  limit: 50
  end

  add_index "rr_incoming_records", ["incoming_file_record_id"], name: "rr_incoming_records_01", unique: true

  create_table "rr_unapproved_records", force: :cascade do |t|
    t.integer  "rr_approvable_id",   limit: nil
    t.string   "rr_approvable_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "rtgs_msg_bkp_180101to190131", id: false, force: :cascade do |t|
    t.integer  "id",                limit: nil,                null: false
    t.integer  "tranref_no",                    precision: 38
    t.integer  "txid",                          precision: 38
    t.string   "orgnlmsgid",        limit: 30
    t.string   "msgtype",           limit: 30
    t.float    "amount",            limit: 126
    t.date     "transfer_date"
    t.string   "bene_account_ifsc", limit: 30
    t.datetime "last_mod_time"
    t.text     "payload"
    t.string   "exception_desc",    limit: 30
    t.string   "status",            limit: 20
    t.string   "isecoll",           limit: 20
  end

  create_table "rtgs_msg_bkp_181101to181231", id: false, force: :cascade do |t|
    t.integer  "id",                limit: nil,                null: false
    t.integer  "tranref_no",                    precision: 38
    t.integer  "txid",                          precision: 38
    t.string   "orgnlmsgid",        limit: 30
    t.string   "msgtype",           limit: 30
    t.float    "amount",            limit: 126
    t.date     "transfer_date"
    t.string   "bene_account_ifsc", limit: 30
    t.datetime "last_mod_time"
    t.text     "payload"
    t.string   "exception_desc",    limit: 30
    t.string   "status",            limit: 20
    t.string   "isecoll",           limit: 20
  end

  create_table "rtgs_msg_bkp_181105to181226", id: false, force: :cascade do |t|
    t.integer  "id",                limit: nil,                null: false
    t.integer  "tranref_no",                    precision: 38
    t.integer  "txid",                          precision: 38
    t.string   "orgnlmsgid",        limit: 30
    t.string   "msgtype",           limit: 30
    t.float    "amount",            limit: 126
    t.date     "transfer_date"
    t.string   "bene_account_ifsc", limit: 30
    t.datetime "last_mod_time"
    t.text     "payload"
    t.string   "exception_desc",    limit: 30
    t.string   "status",            limit: 20
    t.string   "isecoll",           limit: 20
  end

  create_table "rtgs_msg_bkp_181203to181217", id: false, force: :cascade do |t|
    t.integer  "id",                limit: nil,                null: false
    t.integer  "tranref_no",                    precision: 38
    t.integer  "txid",                          precision: 38
    t.string   "orgnlmsgid",        limit: 30
    t.string   "msgtype",           limit: 30
    t.float    "amount",            limit: 126
    t.date     "transfer_date"
    t.string   "bene_account_ifsc", limit: 30
    t.datetime "last_mod_time"
    t.text     "payload"
    t.string   "exception_desc",    limit: 30
    t.string   "status",            limit: 20
    t.string   "isecoll",           limit: 20
  end

  create_table "rtgs_msg_bkp_181224to181226", id: false, force: :cascade do |t|
    t.integer  "id",                limit: nil,                null: false
    t.integer  "tranref_no",                    precision: 38
    t.integer  "txid",                          precision: 38
    t.string   "orgnlmsgid",        limit: 30
    t.string   "msgtype",           limit: 30
    t.float    "amount",            limit: 126
    t.date     "transfer_date"
    t.string   "bene_account_ifsc", limit: 30
    t.datetime "last_mod_time"
    t.text     "payload"
    t.string   "exception_desc",    limit: 30
    t.string   "status",            limit: 20
    t.string   "isecoll",           limit: 20
  end

  create_table "rtgs_msgdetails", id: false, force: :cascade do |t|
    t.integer  "id",                limit: nil,                null: false
    t.integer  "tranref_no",                    precision: 38
    t.integer  "txid",                          precision: 38
    t.string   "orgnlmsgid",        limit: 30
    t.string   "msgtype",           limit: 30
    t.float    "amount",            limit: 126
    t.date     "transfer_date"
    t.string   "bene_account_ifsc", limit: 30
    t.datetime "last_mod_time"
    t.text     "payload"
    t.string   "exception_desc",    limit: 30
    t.string   "status",            limit: 20
    t.string   "isecoll",           limit: 20
  end

  create_table "rx_access_logs", force: :cascade do |t|
    t.string   "app_code",               limit: 100,                             null: false
    t.string   "broker_uuid",            limit: 100,                             null: false
    t.string   "identity_user_id",       limit: 100,                             null: false
    t.string   "org_uuid",               limit: 100
    t.string   "remote_address"
    t.string   "remote_host"
    t.integer  "rx_consumer_id",         limit: nil,                             null: false
    t.string   "http_method",            limit: 10
    t.string   "http_scheme",            limit: 5
    t.string   "content_type",           limit: 100
    t.integer  "content_length",                      precision: 38
    t.string   "uri_path",               limit: 1000
    t.string   "service_name",           limit: 100
    t.integer  "rx_service_id",          limit: nil,                             null: false
    t.string   "any_operation",          limit: 1,                               null: false
    t.string   "any_key_attr",           limit: 1,                               null: false
    t.integer  "rx_destination_id",      limit: nil
    t.string   "destination_uri",        limit: 1024
    t.string   "destination_use_proxy",  limit: 1
    t.datetime "req_timestamp",                                                  null: false
    t.datetime "backend_req_timestamp"
    t.datetime "backend_rep_timestamp"
    t.datetime "rep_timestamp"
    t.string   "fault_code",             limit: 50
    t.string   "fault_subcode",          limit: 50
    t.string   "fault_reason",           limit: 1000
    t.integer  "rx_operation_id",        limit: nil
    t.string   "key_attr_at",            limit: 1
    t.string   "aud_key_attr1",          limit: 1024
    t.string   "aud_key_attr2",          limit: 1024
    t.string   "aud_key_attr3",          limit: 1024
    t.string   "aud_key_attr4",          limit: 1024
    t.string   "aud_key_attr5",          limit: 1024
    t.integer  "aud_key_attrs_cnt",      limit: nil,                 default: 0, null: false
    t.string   "ssl_protocol",           limit: 15
    t.string   "status_code",                                                    null: false
    t.string   "backend_content_type"
    t.string   "backend_http_method",    limit: 10
    t.integer  "backend_content_length",              precision: 38
    t.integer  "http_status",                         precision: 38
    t.integer  "backend_http_status",                 precision: 38
    t.string   "alw_key_attr1",          limit: 1024
    t.string   "alw_key_attr2",          limit: 1024
    t.string   "alw_key_attr3",          limit: 1024
    t.string   "alw_key_attr4",          limit: 1024
    t.string   "alw_key_attr5",          limit: 1024
    t.integer  "alw_key_attrs_cnt",      limit: nil,                 default: 0, null: false
    t.string   "operation_name",         limit: 100
  end

  add_index "rx_access_logs", ["app_code", "service_name", "status_code", "req_timestamp", "rep_timestamp", "http_status", "backend_http_status"], name: "rx_access_logs_01"

  create_table "rx_apps", force: :cascade do |t|
    t.string   "app_code",              limit: 20,                                null: false
    t.datetime "created_at",                                                      null: false
    t.datetime "updated_at",                                                      null: false
    t.integer  "settings_cnt",          limit: nil,                 default: 0,   null: false
    t.string   "setting1",              limit: 2000
    t.string   "setting2",              limit: 2000
    t.string   "setting3",              limit: 2000
    t.string   "setting4",              limit: 2000
    t.string   "setting5",              limit: 2000
    t.string   "modifies_message",      limit: 1,                   default: "f", null: false
    t.string   "modifies_query_params", limit: 1,                   default: "f", null: false
    t.string   "modifies_headers",      limit: 1,                   default: "f", null: false
    t.string   "is_enabled",            limit: 1,                   default: "f", null: false
    t.string   "created_by",            limit: 20
    t.string   "updated_by",            limit: 20
    t.integer  "lock_version",                       precision: 38, default: 0
  end

  add_index "rx_apps", ["app_code"], name: "rx_apps_01", unique: true

  create_table "rx_audit_logs", force: :cascade do |t|
    t.string  "rx_auditable_type",                 null: false
    t.integer "rx_auditable_id",       limit: nil, null: false
    t.text    "query_params"
    t.text    "req_bitstream"
    t.text    "req_headers"
    t.text    "backend_req_headers"
    t.text    "rep_headers"
    t.text    "rep_bitstream"
    t.text    "backend_query_params"
    t.text    "backend_req_bitstream"
    t.text    "backend_rep_headers"
    t.text    "backend_rep_bitstream"
    t.text    "fault_bitstream"
  end

  add_index "rx_audit_logs", ["rx_auditable_type", "rx_auditable_id"], name: "rx_audit_logs_01", unique: true

  create_table "rx_consumers", force: :cascade do |t|
    t.string   "username",                   limit: 100,                              null: false
    t.string   "is_external",                limit: 1,                  default: "f", null: false
    t.string   "org_uuid"
    t.string   "any_source_ip",              limit: 1,                  default: "f", null: false
    t.string   "permitted_source_ips",       limit: 500
    t.string   "is_enabled",                 limit: 1,                  default: "Y", null: false
    t.datetime "created_at",                                                          null: false
    t.datetime "updated_at",                                                          null: false
    t.string   "created_by",                 limit: 20
    t.string   "updated_by",                 limit: 20
    t.integer  "lock_version",                           precision: 38, default: 0,   null: false
    t.string   "last_action",                limit: 1,                  default: "C", null: false
    t.string   "approval_status",            limit: 1,                  default: "U", null: false
    t.integer  "approved_version",                       precision: 38
    t.integer  "approved_id",                limit: nil
    t.integer  "rx_entitled_services_count",             precision: 38
  end

  add_index "rx_consumers", ["org_uuid", "is_enabled"], name: "rx_consumers_03"
  add_index "rx_consumers", ["username", "approval_status"], name: "rx_consumers_01", unique: true

  create_table "rx_destinations", force: :cascade do |t|
    t.integer  "rx_service_id",        limit: nil,                                     null: false
    t.string   "uri",                  limit: 1024,                                    null: false
    t.string   "use_proxy",            limit: 1,                   default: "Y",       null: false
    t.string   "is_enabled",           limit: 1,                   default: "Y",       null: false
    t.integer  "req_timeout_interval",              precision: 38,                     null: false
    t.datetime "created_at",                                                           null: false
    t.datetime "updated_at",                                                           null: false
    t.string   "created_by",           limit: 20
    t.string   "updated_by",           limit: 20
    t.integer  "lock_version",                      precision: 38, default: 0,         null: false
    t.string   "last_action",          limit: 1,                   default: "C",       null: false
    t.string   "approval_status",      limit: 1,                   default: "U",       null: false
    t.integer  "approved_version",                  precision: 38
    t.integer  "approved_id",          limit: nil
    t.string   "ssl_protocol",         limit: 20,                  default: "TLSv1.2", null: false
  end

  add_index "rx_destinations", ["uri", "rx_service_id", "approval_status"], name: "rx_destinations_01", unique: true

  create_table "rx_entitled_operations", force: :cascade do |t|
    t.integer  "rx_operation_id",        limit: nil
    t.integer  "rx_entitled_service_id", limit: nil,                              null: false
    t.string   "is_enabled",             limit: 1,                  default: "Y", null: false
    t.string   "any_key_attr",                                      default: "Y", null: false
    t.string   "key_attr1",              limit: 512
    t.string   "key_attr2",              limit: 512
    t.string   "key_attr3",              limit: 512
    t.string   "key_attr4",              limit: 512
    t.string   "key_attr5",              limit: 512
    t.datetime "created_at",                                                      null: false
    t.datetime "updated_at",                                                      null: false
    t.string   "created_by",             limit: 20
    t.string   "updated_by",             limit: 20
    t.integer  "lock_version",                       precision: 38, default: 0,   null: false
    t.string   "last_action",            limit: 1,                  default: "C", null: false
    t.string   "approval_status",        limit: 1,                  default: "U", null: false
    t.integer  "approved_version",                   precision: 38
    t.integer  "approved_id",            limit: nil
    t.integer  "key_attrs_cnt",          limit: nil,                default: 0,   null: false
  end

  add_index "rx_entitled_operations", ["rx_entitled_service_id", "rx_operation_id", "approval_status"], name: "rx_entitled_operations_01", unique: true

  create_table "rx_entitled_services", force: :cascade do |t|
    t.integer  "rx_consumer_id",               limit: nil,                              null: false
    t.integer  "rx_service_id",                limit: nil,                              null: false
    t.string   "any_operation",                limit: 1,                  default: "Y", null: false
    t.string   "any_key_attr",                 limit: 1,                  default: "Y", null: false
    t.string   "is_enabled",                   limit: 1,                  default: "Y", null: false
    t.string   "key_attr1",                    limit: 512
    t.string   "key_attr2",                    limit: 512
    t.string   "key_attr3",                    limit: 512
    t.string   "key_attr4",                    limit: 512
    t.string   "key_attr5",                    limit: 512
    t.datetime "created_at",                                                            null: false
    t.datetime "updated_at",                                                            null: false
    t.string   "created_by",                   limit: 20
    t.string   "updated_by",                   limit: 20
    t.integer  "lock_version",                             precision: 38, default: 0,   null: false
    t.string   "last_action",                  limit: 1,                  default: "C", null: false
    t.string   "approval_status",              limit: 1,                  default: "U", null: false
    t.integer  "approved_version",                         precision: 38
    t.integer  "approved_id",                  limit: nil
    t.integer  "rx_entitled_operations_count",             precision: 38
    t.integer  "key_attrs_cnt",                limit: nil,                default: 0,   null: false
  end

  add_index "rx_entitled_services", ["rx_consumer_id", "rx_service_id", "approval_status"], name: "rx_entitled_services_01", unique: true

  create_table "rx_operations", force: :cascade do |t|
    t.integer  "rx_service_id",      limit: nil,                              null: false
    t.string   "name",               limit: 100,                              null: false
    t.integer  "key_attrs_cnt",      limit: nil,                default: 0,   null: false
    t.string   "key_attr1",          limit: 512
    t.string   "key_attr2",          limit: 512
    t.string   "key_attr3",          limit: 512
    t.string   "key_attr4",          limit: 512
    t.string   "key_attr5",          limit: 512
    t.datetime "created_at",                                                  null: false
    t.datetime "updated_at",                                                  null: false
    t.string   "created_by",         limit: 20
    t.string   "updated_by",         limit: 20
    t.integer  "lock_version",                   precision: 38, default: 0,   null: false
    t.string   "last_action",        limit: 1,                  default: "C", null: false
    t.string   "approval_status",    limit: 1,                  default: "U", null: false
    t.integer  "approved_version",               precision: 38
    t.integer  "approved_id",        limit: nil
    t.integer  "rx_routes_count",                precision: 38
    t.integer  "rx_consumers_count",             precision: 38
    t.string   "is_enabled",         limit: 1,                  default: "Y"
  end

  add_index "rx_operations", ["rx_service_id", "name", "approval_status"], name: "rx_operations_01", unique: true

  create_table "rx_routes", force: :cascade do |t|
    t.string   "is_enabled",       limit: 1,                   default: "Y", null: false
    t.string   "http_method",      limit: 20,                                null: false
    t.string   "xpath"
    t.string   "match_value"
    t.integer  "rx_operation_id",  limit: nil,                               null: false
    t.datetime "created_at",                                                 null: false
    t.datetime "updated_at",                                                 null: false
    t.string   "created_by",       limit: 20
    t.string   "updated_by",       limit: 20
    t.integer  "lock_version",                  precision: 38, default: 0,   null: false
    t.string   "last_action",      limit: 1,                   default: "C", null: false
    t.string   "approval_status",  limit: 1,                   default: "U", null: false
    t.integer  "approved_version",              precision: 38
    t.integer  "approved_id",      limit: nil
    t.string   "path",             limit: 1000
    t.integer  "rx_service_id",    limit: nil,                               null: false
  end

  add_index "rx_routes", ["rx_operation_id", "approval_status"], name: "rx_routes_02"
  add_index "rx_routes", ["rx_service_id", "http_method", "path", "xpath", "match_value", "approval_status"], name: "rx_routes_01", unique: true

  create_table "rx_services", force: :cascade do |t|
    t.string   "app_code",              limit: 20,                               null: false
    t.string   "name",                  limit: 100,                              null: false
    t.string   "route_type",            limit: 1,                                null: false
    t.string   "content_type",                                                   null: false
    t.string   "is_enabled",            limit: 1,                  default: "Y", null: false
    t.string   "strip_basic_auth",      limit: 1,                  default: "f", null: false
    t.string   "key_attr_at",           limit: 1,                  default: "f", null: false
    t.string   "log_level",             limit: 1,                                null: false
    t.integer  "udfs_cnt",              limit: nil,                default: 0,   null: false
    t.string   "udf1"
    t.string   "udf2"
    t.string   "udf3"
    t.string   "udf4"
    t.string   "udf5"
    t.integer  "key_attrs_cnt",         limit: nil,                default: 0,   null: false
    t.string   "key_attr1",             limit: 512
    t.string   "key_attr2",             limit: 512
    t.string   "key_attr3",             limit: 512
    t.string   "key_attr4",             limit: 512
    t.string   "key_attr5",             limit: 512
    t.string   "permitted_http_mthds",  limit: 100,                              null: false
    t.string   "soap_action_location",  limit: 1
    t.datetime "created_at",                                                     null: false
    t.datetime "updated_at",                                                     null: false
    t.string   "created_by",            limit: 20
    t.string   "updated_by",            limit: 20
    t.integer  "lock_version",                      precision: 38, default: 0,   null: false
    t.string   "last_action",           limit: 1,                  default: "C", null: false
    t.string   "approval_status",       limit: 1,                  default: "U", null: false
    t.integer  "approved_version",                  precision: 38
    t.integer  "approved_id",           limit: nil
    t.integer  "rx_operations_count",               precision: 38
    t.integer  "rx_destinations_count",             precision: 38
    t.integer  "rx_consumers_count",                precision: 38
  end

  add_index "rx_services", ["app_code", "route_type", "is_enabled"], name: "rx_services_02"
  add_index "rx_services", ["name", "approval_status"], name: "rx_services_01", unique: true

  create_table "sb_al_bkp_20141201_20150227", id: false, force: :cascade do |t|
    t.integer "id",                limit: nil,                null: false
    t.string  "req_no",                                       null: false
    t.integer "attempt_no",                    precision: 38, null: false
    t.string  "status_code",       limit: 25,                 null: false
    t.string  "app_id",            limit: 50,                 null: false
    t.string  "sb_auditable_type", limit: 50,                 null: false
    t.integer "sb_auditable_id",   limit: nil,                null: false
    t.text    "req_bitstream",                                null: false
    t.text    "rep_bitstream"
  end

  create_table "sb_al_bkp_20150101_20150228", id: false, force: :cascade do |t|
    t.integer "id",                limit: nil,                null: false
    t.string  "req_no",                                       null: false
    t.integer "attempt_no",                    precision: 38, null: false
    t.string  "status_code",       limit: 25,                 null: false
    t.string  "app_id",            limit: 50,                 null: false
    t.string  "sb_auditable_type", limit: 50,                 null: false
    t.integer "sb_auditable_id",   limit: nil,                null: false
    t.text    "req_bitstream",                                null: false
    t.text    "rep_bitstream"
  end

  create_table "sb_al_bkp_20150101_20150827", id: false, force: :cascade do |t|
    t.integer "id",                limit: nil,                null: false
    t.string  "req_no",                                       null: false
    t.integer "attempt_no",                    precision: 38, null: false
    t.string  "status_code",       limit: 25,                 null: false
    t.string  "app_id",            limit: 50,                 null: false
    t.string  "sb_auditable_type", limit: 50,                 null: false
    t.integer "sb_auditable_id",   limit: nil,                null: false
    t.text    "req_bitstream",                                null: false
    t.text    "rep_bitstream"
  end

  create_table "sb_al_bkp_20150108_20150228", id: false, force: :cascade do |t|
    t.integer "id",                limit: nil,                null: false
    t.string  "req_no",                                       null: false
    t.integer "attempt_no",                    precision: 38, null: false
    t.string  "status_code",       limit: 25,                 null: false
    t.string  "app_id",            limit: 50,                 null: false
    t.string  "sb_auditable_type", limit: 50,                 null: false
    t.integer "sb_auditable_id",   limit: nil,                null: false
    t.text    "req_bitstream",                                null: false
    t.text    "rep_bitstream"
  end

  create_table "sb_al_bkp_20150122_20150301", id: false, force: :cascade do |t|
    t.integer "id",                limit: nil,                null: false
    t.string  "req_no",                                       null: false
    t.integer "attempt_no",                    precision: 38, null: false
    t.string  "status_code",       limit: 25,                 null: false
    t.string  "app_id",            limit: 50,                 null: false
    t.string  "sb_auditable_type", limit: 50,                 null: false
    t.integer "sb_auditable_id",   limit: nil,                null: false
    t.text    "req_bitstream",                                null: false
    t.text    "rep_bitstream"
  end

  create_table "sb_al_bkp_20150201_20150228", id: false, force: :cascade do |t|
    t.integer "id",                limit: nil,                null: false
    t.string  "req_no",                                       null: false
    t.integer "attempt_no",                    precision: 38, null: false
    t.string  "status_code",       limit: 25,                 null: false
    t.string  "app_id",            limit: 50,                 null: false
    t.string  "sb_auditable_type", limit: 50,                 null: false
    t.integer "sb_auditable_id",   limit: nil,                null: false
    t.text    "req_bitstream",                                null: false
    t.text    "rep_bitstream"
  end

  create_table "sb_al_bkp_20150902_20150916", id: false, force: :cascade do |t|
    t.integer "id",                limit: nil,                null: false
    t.string  "req_no",                                       null: false
    t.integer "attempt_no",                    precision: 38, null: false
    t.string  "status_code",       limit: 25,                 null: false
    t.string  "app_id",            limit: 50,                 null: false
    t.string  "sb_auditable_type", limit: 50,                 null: false
    t.integer "sb_auditable_id",   limit: nil,                null: false
    t.text    "req_bitstream",                                null: false
    t.text    "rep_bitstream"
  end

  create_table "sb_al_bkp_20180101_20180131", id: false, force: :cascade do |t|
    t.integer "id",                limit: nil,                null: false
    t.string  "req_no",                                       null: false
    t.integer "attempt_no",                    precision: 38, null: false
    t.string  "status_code",       limit: 25,                 null: false
    t.string  "app_id",            limit: 50,                 null: false
    t.string  "sb_auditable_type", limit: 50,                 null: false
    t.integer "sb_auditable_id",   limit: nil,                null: false
    t.text    "req_bitstream",                                null: false
    t.text    "rep_bitstream"
  end

  create_table "sb_al_bkp_20180101_20180228", id: false, force: :cascade do |t|
    t.integer "id",                limit: nil,                null: false
    t.string  "req_no",                                       null: false
    t.integer "attempt_no",                    precision: 38, null: false
    t.string  "status_code",       limit: 25,                 null: false
    t.string  "app_id",            limit: 50,                 null: false
    t.string  "sb_auditable_type", limit: 50,                 null: false
    t.integer "sb_auditable_id",   limit: nil,                null: false
    t.text    "req_bitstream",                                null: false
    t.text    "rep_bitstream"
  end

  create_table "sb_al_bkp_20180101_20190123", id: false, force: :cascade do |t|
    t.integer "id",                limit: nil,                null: false
    t.string  "req_no",                                       null: false
    t.integer "attempt_no",                    precision: 38, null: false
    t.string  "status_code",       limit: 25,                 null: false
    t.string  "app_id",            limit: 50,                 null: false
    t.string  "sb_auditable_type", limit: 50,                 null: false
    t.integer "sb_auditable_id",   limit: nil,                null: false
    t.text    "req_bitstream",                                null: false
    t.text    "rep_bitstream"
  end

  create_table "sb_al_bkp_20180101_20190131", id: false, force: :cascade do |t|
    t.integer "id",                limit: nil,                null: false
    t.string  "req_no",                                       null: false
    t.integer "attempt_no",                    precision: 38, null: false
    t.string  "status_code",       limit: 25,                 null: false
    t.string  "app_id",            limit: 50,                 null: false
    t.string  "sb_auditable_type", limit: 50,                 null: false
    t.integer "sb_auditable_id",   limit: nil,                null: false
    t.text    "req_bitstream",                                null: false
    t.text    "rep_bitstream"
  end

  create_table "sb_al_bkp_20180111_20180124", id: false, force: :cascade do |t|
    t.integer "id",                limit: nil,                null: false
    t.string  "req_no",                                       null: false
    t.integer "attempt_no",                    precision: 38, null: false
    t.string  "status_code",       limit: 25,                 null: false
    t.string  "app_id",            limit: 50,                 null: false
    t.string  "sb_auditable_type", limit: 50,                 null: false
    t.integer "sb_auditable_id",   limit: nil,                null: false
    t.text    "req_bitstream",                                null: false
    t.text    "rep_bitstream"
  end

  create_table "sb_al_bkp_20180201_20190228", id: false, force: :cascade do |t|
    t.integer "id",                limit: nil,                null: false
    t.string  "req_no",                                       null: false
    t.integer "attempt_no",                    precision: 38, null: false
    t.string  "status_code",       limit: 25,                 null: false
    t.string  "app_id",            limit: 50,                 null: false
    t.string  "sb_auditable_type", limit: 50,                 null: false
    t.integer "sb_auditable_id",   limit: nil,                null: false
    t.text    "req_bitstream",                                null: false
    t.text    "rep_bitstream"
  end

  create_table "sb_al_bkp_20180502_20180602", id: false, force: :cascade do |t|
    t.integer "id",                limit: nil,                null: false
    t.string  "req_no",                                       null: false
    t.integer "attempt_no",                    precision: 38, null: false
    t.string  "status_code",       limit: 25,                 null: false
    t.string  "app_id",            limit: 50,                 null: false
    t.string  "sb_auditable_type", limit: 50,                 null: false
    t.integer "sb_auditable_id",   limit: nil,                null: false
    t.text    "req_bitstream",                                null: false
    t.text    "rep_bitstream"
  end

  create_table "sb_al_bkp_20180807_20190131", id: false, force: :cascade do |t|
    t.integer "id",                limit: nil,                null: false
    t.string  "req_no",                                       null: false
    t.integer "attempt_no",                    precision: 38, null: false
    t.string  "status_code",       limit: 25,                 null: false
    t.string  "app_id",            limit: 50,                 null: false
    t.string  "sb_auditable_type", limit: 50,                 null: false
    t.integer "sb_auditable_id",   limit: nil,                null: false
    t.text    "req_bitstream",                                null: false
    t.text    "rep_bitstream"
  end

  create_table "sb_al_bkp_20181101_20181231", id: false, force: :cascade do |t|
    t.integer "id",                limit: nil,                null: false
    t.string  "req_no",                                       null: false
    t.integer "attempt_no",                    precision: 38, null: false
    t.string  "status_code",       limit: 25,                 null: false
    t.string  "app_id",            limit: 50,                 null: false
    t.string  "sb_auditable_type", limit: 50,                 null: false
    t.integer "sb_auditable_id",   limit: nil,                null: false
    t.text    "req_bitstream",                                null: false
    t.text    "rep_bitstream"
  end

  create_table "sb_al_bkp_20181102_20181231", id: false, force: :cascade do |t|
    t.integer "id",                limit: nil,                null: false
    t.string  "req_no",                                       null: false
    t.integer "attempt_no",                    precision: 38, null: false
    t.string  "status_code",       limit: 25,                 null: false
    t.string  "app_id",            limit: 50,                 null: false
    t.string  "sb_auditable_type", limit: 50,                 null: false
    t.integer "sb_auditable_id",   limit: nil,                null: false
    t.text    "req_bitstream",                                null: false
    t.text    "rep_bitstream"
  end

  create_table "sb_al_bkp_20181204_20190131", id: false, force: :cascade do |t|
    t.integer "id",                limit: nil,                null: false
    t.string  "req_no",                                       null: false
    t.integer "attempt_no",                    precision: 38, null: false
    t.string  "status_code",       limit: 25,                 null: false
    t.string  "app_id",            limit: 50,                 null: false
    t.string  "sb_auditable_type", limit: 50,                 null: false
    t.integer "sb_auditable_id",   limit: nil,                null: false
    t.text    "req_bitstream",                                null: false
    t.text    "rep_bitstream"
  end

  create_table "sb_al_bkp_20190101_20180228", id: false, force: :cascade do |t|
    t.integer "id",                limit: nil,                null: false
    t.string  "req_no",                                       null: false
    t.integer "attempt_no",                    precision: 38, null: false
    t.string  "status_code",       limit: 25,                 null: false
    t.string  "app_id",            limit: 50,                 null: false
    t.string  "sb_auditable_type", limit: 50,                 null: false
    t.integer "sb_auditable_id",   limit: nil,                null: false
    t.text    "req_bitstream",                                null: false
    t.text    "rep_bitstream"
  end

  create_table "sb_al_bkp_20190101_20190131", id: false, force: :cascade do |t|
    t.integer "id",                limit: nil,                null: false
    t.string  "req_no",                                       null: false
    t.integer "attempt_no",                    precision: 38, null: false
    t.string  "status_code",       limit: 25,                 null: false
    t.string  "app_id",            limit: 50,                 null: false
    t.string  "sb_auditable_type", limit: 50,                 null: false
    t.integer "sb_auditable_id",   limit: nil,                null: false
    t.text    "req_bitstream",                                null: false
    t.text    "rep_bitstream"
  end

  create_table "sb_al_bkp_20190102_20190131", id: false, force: :cascade do |t|
    t.integer "id",                limit: nil,                null: false
    t.string  "req_no",                                       null: false
    t.integer "attempt_no",                    precision: 38, null: false
    t.string  "status_code",       limit: 25,                 null: false
    t.string  "app_id",            limit: 50,                 null: false
    t.string  "sb_auditable_type", limit: 50,                 null: false
    t.integer "sb_auditable_id",   limit: nil,                null: false
    t.text    "req_bitstream",                                null: false
    t.text    "rep_bitstream"
  end

  create_table "sb_al_bkp_20190109_20190123", id: false, force: :cascade do |t|
    t.integer "id",                limit: nil,                null: false
    t.string  "req_no",                                       null: false
    t.integer "attempt_no",                    precision: 38, null: false
    t.string  "status_code",       limit: 25,                 null: false
    t.string  "app_id",            limit: 50,                 null: false
    t.string  "sb_auditable_type", limit: 50,                 null: false
    t.integer "sb_auditable_id",   limit: nil,                null: false
    t.text    "req_bitstream",                                null: false
    t.text    "rep_bitstream"
  end

  create_table "sb_al_bkp_20190117_20200116", id: false, force: :cascade do |t|
    t.integer "id",                limit: nil,                null: false
    t.string  "req_no",                                       null: false
    t.integer "attempt_no",                    precision: 38, null: false
    t.string  "status_code",       limit: 25,                 null: false
    t.string  "app_id",            limit: 50,                 null: false
    t.string  "sb_auditable_type", limit: 50,                 null: false
    t.integer "sb_auditable_id",   limit: nil,                null: false
    t.text    "req_bitstream",                                null: false
    t.text    "rep_bitstream"
  end

  create_table "sb_al_bkp_20190201_20190212", id: false, force: :cascade do |t|
    t.integer "id",                limit: nil,                null: false
    t.string  "req_no",                                       null: false
    t.integer "attempt_no",                    precision: 38, null: false
    t.string  "status_code",       limit: 25,                 null: false
    t.string  "app_id",            limit: 50,                 null: false
    t.string  "sb_auditable_type", limit: 50,                 null: false
    t.integer "sb_auditable_id",   limit: nil,                null: false
    t.text    "req_bitstream",                                null: false
    t.text    "rep_bitstream"
  end

  create_table "sb_audit_logs", force: :cascade do |t|
    t.string  "req_no",                                       null: false
    t.integer "attempt_no",                    precision: 38, null: false
    t.string  "status_code",       limit: 25,                 null: false
    t.string  "app_id",            limit: 50,                 null: false
    t.string  "sb_auditable_type", limit: 50,                 null: false
    t.integer "sb_auditable_id",   limit: nil,                null: false
    t.text    "req_bitstream",                                null: false
    t.text    "rep_bitstream"
  end

  create_table "sb_auditable_type_dup", id: false, force: :cascade do |t|
    t.integer "id",                limit: nil,                null: false
    t.string  "req_no",                                       null: false
    t.integer "attempt_no",                    precision: 38, null: false
    t.string  "status_code",       limit: 25,                 null: false
    t.string  "app_id",            limit: 50,                 null: false
    t.string  "sb_auditable_type", limit: 50,                 null: false
    t.integer "sb_auditable_id",   limit: nil,                null: false
    t.text    "req_bitstream",                                null: false
    t.text    "rep_bitstream"
  end

  create_table "sb_checkbook_orders", force: :cascade do |t|
    t.string   "req_no",                                          null: false
    t.integer  "attempt_no",                       precision: 38, null: false
    t.string   "status_code",         limit: 25,                  null: false
    t.string   "req_version",         limit: 10,                  null: false
    t.datetime "req_timestamp",                                   null: false
    t.string   "app_id",              limit: 50,                  null: false
    t.string   "customer_id",         limit: 50
    t.string   "cust_identity_type",  limit: 50
    t.string   "cust_identity_value", limit: 50
    t.string   "device_id",           limit: 50
    t.string   "account_no",          limit: 50
    t.string   "account_last_n",      limit: 50
    t.string   "default_account"
    t.string   "registered_account"
    t.string   "rep_no"
    t.string   "rep_version",         limit: 10
    t.datetime "rep_timestamp"
    t.string   "fault_code",          limit: 50
    t.string   "fault_reason",        limit: 1000
  end

  create_table "sb_deregistrations", force: :cascade do |t|
    t.string   "req_no",                                          null: false
    t.integer  "attempt_no",                       precision: 38, null: false
    t.string   "status_code",         limit: 25,                  null: false
    t.string   "req_version",         limit: 10,                  null: false
    t.datetime "req_timestamp",                                   null: false
    t.string   "app_id",              limit: 50,                  null: false
    t.string   "customer_id",         limit: 50
    t.string   "cust_identity_type",  limit: 50
    t.string   "cust_identity_value", limit: 50
    t.string   "device_id",           limit: 50
    t.string   "deregistration_type", limit: 1
    t.string   "otp_key",             limit: 50
    t.string   "otp_value"
    t.string   "rep_no"
    t.string   "rep_version",         limit: 10
    t.datetime "rep_timestamp"
    t.string   "fault_code",          limit: 50
    t.string   "fault_reason",        limit: 1000
  end

  create_table "sb_ft_bkp_150101to160101", id: false, force: :cascade do |t|
    t.integer  "id",                  limit: nil,                 null: false
    t.string   "req_no",                                          null: false
    t.integer  "attempt_no",                       precision: 38, null: false
    t.string   "status_code",         limit: 25,                  null: false
    t.string   "req_version",         limit: 10,                  null: false
    t.datetime "req_timestamp",                                   null: false
    t.string   "app_id",              limit: 50,                  null: false
    t.string   "customer_id",         limit: 50
    t.string   "cust_identity_type",  limit: 50
    t.string   "cust_identity_value", limit: 50
    t.string   "device_id",           limit: 50
    t.string   "account_no",          limit: 50
    t.string   "account_last_n",      limit: 50
    t.string   "default_account",     limit: 1
    t.string   "registered_account",  limit: 1
    t.string   "bene_id",             limit: 50
    t.string   "req_transfer_type",   limit: 4,                   null: false
    t.string   "transfer_ccy",        limit: 5,                   null: false
    t.integer  "transfer_amount",                  precision: 38, null: false
    t.string   "rmtr_to_bene_note"
    t.string   "rep_no"
    t.string   "rep_version",         limit: 10
    t.datetime "rep_timestamp"
    t.string   "transfer_type",       limit: 4
    t.string   "bene_full_name"
    t.string   "bene_account_no"
    t.string   "bene_account_ifsc"
    t.string   "fault_code",          limit: 50
    t.string   "fault_reason",        limit: 1000
  end

  create_table "sb_ft_bkp_180101to180117", id: false, force: :cascade do |t|
    t.integer  "id",                  limit: nil,                 null: false
    t.string   "req_no",                                          null: false
    t.integer  "attempt_no",                       precision: 38, null: false
    t.string   "status_code",         limit: 25,                  null: false
    t.string   "req_version",         limit: 10,                  null: false
    t.datetime "req_timestamp",                                   null: false
    t.string   "app_id",              limit: 50,                  null: false
    t.string   "customer_id",         limit: 50
    t.string   "cust_identity_type",  limit: 50
    t.string   "cust_identity_value", limit: 50
    t.string   "device_id",           limit: 50
    t.string   "account_no",          limit: 50
    t.string   "account_last_n",      limit: 50
    t.string   "default_account",     limit: 1
    t.string   "registered_account",  limit: 1
    t.string   "bene_id",             limit: 50
    t.string   "req_transfer_type",   limit: 4,                   null: false
    t.string   "transfer_ccy",        limit: 5,                   null: false
    t.integer  "transfer_amount",                  precision: 38, null: false
    t.string   "rmtr_to_bene_note"
    t.string   "rep_no"
    t.string   "rep_version",         limit: 10
    t.datetime "rep_timestamp"
    t.string   "transfer_type",       limit: 4
    t.string   "bene_full_name"
    t.string   "bene_account_no"
    t.string   "bene_account_ifsc"
    t.string   "fault_code",          limit: 50
    t.string   "fault_reason",        limit: 1000
  end

  create_table "sb_ft_bkp_180502to180602", id: false, force: :cascade do |t|
    t.integer  "id",                  limit: nil,                 null: false
    t.string   "req_no",                                          null: false
    t.integer  "attempt_no",                       precision: 38, null: false
    t.string   "status_code",         limit: 25,                  null: false
    t.string   "req_version",         limit: 10,                  null: false
    t.datetime "req_timestamp",                                   null: false
    t.string   "app_id",              limit: 50,                  null: false
    t.string   "customer_id",         limit: 50
    t.string   "cust_identity_type",  limit: 50
    t.string   "cust_identity_value", limit: 50
    t.string   "device_id",           limit: 50
    t.string   "account_no",          limit: 50
    t.string   "account_last_n",      limit: 50
    t.string   "default_account",     limit: 1
    t.string   "registered_account",  limit: 1
    t.string   "bene_id",             limit: 50
    t.string   "req_transfer_type",   limit: 4,                   null: false
    t.string   "transfer_ccy",        limit: 5,                   null: false
    t.integer  "transfer_amount",                  precision: 38, null: false
    t.string   "rmtr_to_bene_note"
    t.string   "rep_no"
    t.string   "rep_version",         limit: 10
    t.datetime "rep_timestamp"
    t.string   "transfer_type",       limit: 4
    t.string   "bene_full_name"
    t.string   "bene_account_no"
    t.string   "bene_account_ifsc"
    t.string   "fault_code",          limit: 50
    t.string   "fault_reason",        limit: 1000
  end

  create_table "sb_ft_bkp_181001to181231", id: false, force: :cascade do |t|
    t.integer  "id",                  limit: nil,                 null: false
    t.string   "req_no",                                          null: false
    t.integer  "attempt_no",                       precision: 38, null: false
    t.string   "status_code",         limit: 25,                  null: false
    t.string   "req_version",         limit: 10,                  null: false
    t.datetime "req_timestamp",                                   null: false
    t.string   "app_id",              limit: 50,                  null: false
    t.string   "customer_id",         limit: 50
    t.string   "cust_identity_type",  limit: 50
    t.string   "cust_identity_value", limit: 50
    t.string   "device_id",           limit: 50
    t.string   "account_no",          limit: 50
    t.string   "account_last_n",      limit: 50
    t.string   "default_account",     limit: 1
    t.string   "registered_account",  limit: 1
    t.string   "bene_id",             limit: 50
    t.string   "req_transfer_type",   limit: 4,                   null: false
    t.string   "transfer_ccy",        limit: 5,                   null: false
    t.integer  "transfer_amount",                  precision: 38, null: false
    t.string   "rmtr_to_bene_note"
    t.string   "rep_no"
    t.string   "rep_version",         limit: 10
    t.datetime "rep_timestamp"
    t.string   "transfer_type",       limit: 4
    t.string   "bene_full_name"
    t.string   "bene_account_no"
    t.string   "bene_account_ifsc"
    t.string   "fault_code",          limit: 50
    t.string   "fault_reason",        limit: 1000
  end

  create_table "sb_ft_bkp_181102to181228", id: false, force: :cascade do |t|
    t.integer  "id",                  limit: nil,                 null: false
    t.string   "req_no",                                          null: false
    t.integer  "attempt_no",                       precision: 38, null: false
    t.string   "status_code",         limit: 25,                  null: false
    t.string   "req_version",         limit: 10,                  null: false
    t.datetime "req_timestamp",                                   null: false
    t.string   "app_id",              limit: 50,                  null: false
    t.string   "customer_id",         limit: 50
    t.string   "cust_identity_type",  limit: 50
    t.string   "cust_identity_value", limit: 50
    t.string   "device_id",           limit: 50
    t.string   "account_no",          limit: 50
    t.string   "account_last_n",      limit: 50
    t.string   "default_account",     limit: 1
    t.string   "registered_account",  limit: 1
    t.string   "bene_id",             limit: 50
    t.string   "req_transfer_type",   limit: 4,                   null: false
    t.string   "transfer_ccy",        limit: 5,                   null: false
    t.integer  "transfer_amount",                  precision: 38, null: false
    t.string   "rmtr_to_bene_note"
    t.string   "rep_no"
    t.string   "rep_version",         limit: 10
    t.datetime "rep_timestamp"
    t.string   "transfer_type",       limit: 4
    t.string   "bene_full_name"
    t.string   "bene_account_no"
    t.string   "bene_account_ifsc"
    t.string   "fault_code",          limit: 50
    t.string   "fault_reason",        limit: 1000
  end

  create_table "sb_ft_bkp_181201to181227", id: false, force: :cascade do |t|
    t.integer  "id",                  limit: nil,                 null: false
    t.string   "req_no",                                          null: false
    t.integer  "attempt_no",                       precision: 38, null: false
    t.string   "status_code",         limit: 25,                  null: false
    t.string   "req_version",         limit: 10,                  null: false
    t.datetime "req_timestamp",                                   null: false
    t.string   "app_id",              limit: 50,                  null: false
    t.string   "customer_id",         limit: 50
    t.string   "cust_identity_type",  limit: 50
    t.string   "cust_identity_value", limit: 50
    t.string   "device_id",           limit: 50
    t.string   "account_no",          limit: 50
    t.string   "account_last_n",      limit: 50
    t.string   "default_account",     limit: 1
    t.string   "registered_account",  limit: 1
    t.string   "bene_id",             limit: 50
    t.string   "req_transfer_type",   limit: 4,                   null: false
    t.string   "transfer_ccy",        limit: 5,                   null: false
    t.integer  "transfer_amount",                  precision: 38, null: false
    t.string   "rmtr_to_bene_note"
    t.string   "rep_no"
    t.string   "rep_version",         limit: 10
    t.datetime "rep_timestamp"
    t.string   "transfer_type",       limit: 4
    t.string   "bene_full_name"
    t.string   "bene_account_no"
    t.string   "bene_account_ifsc"
    t.string   "fault_code",          limit: 50
    t.string   "fault_reason",        limit: 1000
  end

  create_table "sb_ft_bkp_181201to181231", id: false, force: :cascade do |t|
    t.integer  "id",                  limit: nil,                 null: false
    t.string   "req_no",                                          null: false
    t.integer  "attempt_no",                       precision: 38, null: false
    t.string   "status_code",         limit: 25,                  null: false
    t.string   "req_version",         limit: 10,                  null: false
    t.datetime "req_timestamp",                                   null: false
    t.string   "app_id",              limit: 50,                  null: false
    t.string   "customer_id",         limit: 50
    t.string   "cust_identity_type",  limit: 50
    t.string   "cust_identity_value", limit: 50
    t.string   "device_id",           limit: 50
    t.string   "account_no",          limit: 50
    t.string   "account_last_n",      limit: 50
    t.string   "default_account",     limit: 1
    t.string   "registered_account",  limit: 1
    t.string   "bene_id",             limit: 50
    t.string   "req_transfer_type",   limit: 4,                   null: false
    t.string   "transfer_ccy",        limit: 5,                   null: false
    t.integer  "transfer_amount",                  precision: 38, null: false
    t.string   "rmtr_to_bene_note"
    t.string   "rep_no"
    t.string   "rep_version",         limit: 10
    t.datetime "rep_timestamp"
    t.string   "transfer_type",       limit: 4
    t.string   "bene_full_name"
    t.string   "bene_account_no"
    t.string   "bene_account_ifsc"
    t.string   "fault_code",          limit: 50
    t.string   "fault_reason",        limit: 1000
  end

  create_table "sb_ft_bkp_181210to181211", id: false, force: :cascade do |t|
    t.integer  "id",                  limit: nil,                 null: false
    t.string   "req_no",                                          null: false
    t.integer  "attempt_no",                       precision: 38, null: false
    t.string   "status_code",         limit: 25,                  null: false
    t.string   "req_version",         limit: 10,                  null: false
    t.datetime "req_timestamp",                                   null: false
    t.string   "app_id",              limit: 50,                  null: false
    t.string   "customer_id",         limit: 50
    t.string   "cust_identity_type",  limit: 50
    t.string   "cust_identity_value", limit: 50
    t.string   "device_id",           limit: 50
    t.string   "account_no",          limit: 50
    t.string   "account_last_n",      limit: 50
    t.string   "default_account",     limit: 1
    t.string   "registered_account",  limit: 1
    t.string   "bene_id",             limit: 50
    t.string   "req_transfer_type",   limit: 4,                   null: false
    t.string   "transfer_ccy",        limit: 5,                   null: false
    t.integer  "transfer_amount",                  precision: 38, null: false
    t.string   "rmtr_to_bene_note"
    t.string   "rep_no"
    t.string   "rep_version",         limit: 10
    t.datetime "rep_timestamp"
    t.string   "transfer_type",       limit: 4
    t.string   "bene_full_name"
    t.string   "bene_account_no"
    t.string   "bene_account_ifsc"
    t.string   "fault_code",          limit: 50
    t.string   "fault_reason",        limit: 1000
  end

  create_table "sb_ft_bkp_190101to190130", id: false, force: :cascade do |t|
    t.integer  "id",                  limit: nil,                 null: false
    t.string   "req_no",                                          null: false
    t.integer  "attempt_no",                       precision: 38, null: false
    t.string   "status_code",         limit: 25,                  null: false
    t.string   "req_version",         limit: 10,                  null: false
    t.datetime "req_timestamp",                                   null: false
    t.string   "app_id",              limit: 50,                  null: false
    t.string   "customer_id",         limit: 50
    t.string   "cust_identity_type",  limit: 50
    t.string   "cust_identity_value", limit: 50
    t.string   "device_id",           limit: 50
    t.string   "account_no",          limit: 50
    t.string   "account_last_n",      limit: 50
    t.string   "default_account",     limit: 1
    t.string   "registered_account",  limit: 1
    t.string   "bene_id",             limit: 50
    t.string   "req_transfer_type",   limit: 4,                   null: false
    t.string   "transfer_ccy",        limit: 5,                   null: false
    t.integer  "transfer_amount",                  precision: 38, null: false
    t.string   "rmtr_to_bene_note"
    t.string   "rep_no"
    t.string   "rep_version",         limit: 10
    t.datetime "rep_timestamp"
    t.string   "transfer_type",       limit: 4
    t.string   "bene_full_name"
    t.string   "bene_account_no"
    t.string   "bene_account_ifsc"
    t.string   "fault_code",          limit: 50
    t.string   "fault_reason",        limit: 1000
  end

  create_table "sb_ft_bkp_190101to190131", id: false, force: :cascade do |t|
    t.integer  "id",                  limit: nil,                 null: false
    t.string   "req_no",                                          null: false
    t.integer  "attempt_no",                       precision: 38, null: false
    t.string   "status_code",         limit: 25,                  null: false
    t.string   "req_version",         limit: 10,                  null: false
    t.datetime "req_timestamp",                                   null: false
    t.string   "app_id",              limit: 50,                  null: false
    t.string   "customer_id",         limit: 50
    t.string   "cust_identity_type",  limit: 50
    t.string   "cust_identity_value", limit: 50
    t.string   "device_id",           limit: 50
    t.string   "account_no",          limit: 50
    t.string   "account_last_n",      limit: 50
    t.string   "default_account",     limit: 1
    t.string   "registered_account",  limit: 1
    t.string   "bene_id",             limit: 50
    t.string   "req_transfer_type",   limit: 4,                   null: false
    t.string   "transfer_ccy",        limit: 5,                   null: false
    t.integer  "transfer_amount",                  precision: 38, null: false
    t.string   "rmtr_to_bene_note"
    t.string   "rep_no"
    t.string   "rep_version",         limit: 10
    t.datetime "rep_timestamp"
    t.string   "transfer_type",       limit: 4
    t.string   "bene_full_name"
    t.string   "bene_account_no"
    t.string   "bene_account_ifsc"
    t.string   "fault_code",          limit: 50
    t.string   "fault_reason",        limit: 1000
  end

  create_table "sb_ft_bkp_190101to190228", id: false, force: :cascade do |t|
    t.integer  "id",                  limit: nil,                 null: false
    t.string   "req_no",                                          null: false
    t.integer  "attempt_no",                       precision: 38, null: false
    t.string   "status_code",         limit: 25,                  null: false
    t.string   "req_version",         limit: 10,                  null: false
    t.datetime "req_timestamp",                                   null: false
    t.string   "app_id",              limit: 50,                  null: false
    t.string   "customer_id",         limit: 50
    t.string   "cust_identity_type",  limit: 50
    t.string   "cust_identity_value", limit: 50
    t.string   "device_id",           limit: 50
    t.string   "account_no",          limit: 50
    t.string   "account_last_n",      limit: 50
    t.string   "default_account",     limit: 1
    t.string   "registered_account",  limit: 1
    t.string   "bene_id",             limit: 50
    t.string   "req_transfer_type",   limit: 4,                   null: false
    t.string   "transfer_ccy",        limit: 5,                   null: false
    t.integer  "transfer_amount",                  precision: 38, null: false
    t.string   "rmtr_to_bene_note"
    t.string   "rep_no"
    t.string   "rep_version",         limit: 10
    t.datetime "rep_timestamp"
    t.string   "transfer_type",       limit: 4
    t.string   "bene_full_name"
    t.string   "bene_account_no"
    t.string   "bene_account_ifsc"
    t.string   "fault_code",          limit: 50
    t.string   "fault_reason",        limit: 1000
  end

  create_table "sb_fun_tra_bkp_181001to181231", id: false, force: :cascade do |t|
    t.integer  "id",                  limit: nil,                 null: false
    t.string   "req_no",                                          null: false
    t.integer  "attempt_no",                       precision: 38, null: false
    t.string   "status_code",         limit: 25,                  null: false
    t.string   "req_version",         limit: 10,                  null: false
    t.datetime "req_timestamp",                                   null: false
    t.string   "app_id",              limit: 50,                  null: false
    t.string   "customer_id",         limit: 50
    t.string   "cust_identity_type",  limit: 50
    t.string   "cust_identity_value", limit: 50
    t.string   "device_id",           limit: 50
    t.string   "account_no",          limit: 50
    t.string   "account_last_n",      limit: 50
    t.string   "default_account",     limit: 1
    t.string   "registered_account",  limit: 1
    t.string   "bene_id",             limit: 50
    t.string   "req_transfer_type",   limit: 4,                   null: false
    t.string   "transfer_ccy",        limit: 5,                   null: false
    t.integer  "transfer_amount",                  precision: 38, null: false
    t.string   "rmtr_to_bene_note"
    t.string   "rep_no"
    t.string   "rep_version",         limit: 10
    t.datetime "rep_timestamp"
    t.string   "transfer_type",       limit: 4
    t.string   "bene_full_name"
    t.string   "bene_account_no"
    t.string   "bene_account_ifsc"
    t.string   "fault_code",          limit: 50
    t.string   "fault_reason",        limit: 1000
  end

  create_table "sb_fun_tra_bkp_181101to181231", id: false, force: :cascade do |t|
    t.integer  "id",                  limit: nil,                 null: false
    t.string   "req_no",                                          null: false
    t.integer  "attempt_no",                       precision: 38, null: false
    t.string   "status_code",         limit: 25,                  null: false
    t.string   "req_version",         limit: 10,                  null: false
    t.datetime "req_timestamp",                                   null: false
    t.string   "app_id",              limit: 50,                  null: false
    t.string   "customer_id",         limit: 50
    t.string   "cust_identity_type",  limit: 50
    t.string   "cust_identity_value", limit: 50
    t.string   "device_id",           limit: 50
    t.string   "account_no",          limit: 50
    t.string   "account_last_n",      limit: 50
    t.string   "default_account",     limit: 1
    t.string   "registered_account",  limit: 1
    t.string   "bene_id",             limit: 50
    t.string   "req_transfer_type",   limit: 4,                   null: false
    t.string   "transfer_ccy",        limit: 5,                   null: false
    t.integer  "transfer_amount",                  precision: 38, null: false
    t.string   "rmtr_to_bene_note"
    t.string   "rep_no"
    t.string   "rep_version",         limit: 10
    t.datetime "rep_timestamp"
    t.string   "transfer_type",       limit: 4
    t.string   "bene_full_name"
    t.string   "bene_account_no"
    t.string   "bene_account_ifsc"
    t.string   "fault_code",          limit: 50
    t.string   "fault_reason",        limit: 1000
  end

  create_table "sb_fund_transfers", force: :cascade do |t|
    t.string   "req_no",                                          null: false
    t.integer  "attempt_no",                       precision: 38, null: false
    t.string   "status_code",         limit: 25,                  null: false
    t.string   "req_version",         limit: 10,                  null: false
    t.datetime "req_timestamp",                                   null: false
    t.string   "app_id",              limit: 50,                  null: false
    t.string   "customer_id",         limit: 50
    t.string   "cust_identity_type",  limit: 50
    t.string   "cust_identity_value", limit: 50
    t.string   "device_id",           limit: 50
    t.string   "account_no",          limit: 50
    t.string   "account_last_n",      limit: 50
    t.string   "default_account",     limit: 1
    t.string   "registered_account",  limit: 1
    t.string   "bene_id",             limit: 50
    t.string   "req_transfer_type",   limit: 4,                   null: false
    t.string   "transfer_ccy",        limit: 5,                   null: false
    t.integer  "transfer_amount",                  precision: 38, null: false
    t.string   "rmtr_to_bene_note"
    t.string   "rep_no"
    t.string   "rep_version",         limit: 10
    t.datetime "rep_timestamp"
    t.string   "transfer_type",       limit: 4
    t.string   "bene_full_name"
    t.string   "bene_account_no"
    t.string   "bene_account_ifsc"
    t.string   "fault_code",          limit: 50
    t.string   "fault_reason",        limit: 1000
  end

  add_index "sb_fund_transfers", ["app_id", "req_no", "attempt_no"], name: "sb_fund_transfers_index", unique: true

  create_table "sb_registrations", force: :cascade do |t|
    t.string   "req_no",                                          null: false
    t.integer  "attempt_no",                       precision: 38, null: false
    t.string   "status_code",         limit: 25,                  null: false
    t.string   "req_version",         limit: 10,                  null: false
    t.datetime "req_timestamp",                                   null: false
    t.string   "app_id",              limit: 50,                  null: false
    t.string   "customer_id",         limit: 50
    t.string   "cust_identity_type",  limit: 50
    t.string   "cust_identity_value", limit: 50
    t.string   "device_id",           limit: 50
    t.string   "account_no",          limit: 50
    t.string   "otp_key",             limit: 50
    t.string   "otp_value"
    t.string   "rep_no"
    t.string   "rep_version",         limit: 10
    t.datetime "rep_timestamp"
    t.string   "fault_code",          limit: 50
    t.string   "fault_reason",        limit: 1000
  end

  create_table "sb_statement_orders", force: :cascade do |t|
    t.string   "req_no",                                          null: false
    t.integer  "attempt_no",                       precision: 38, null: false
    t.string   "status_code",         limit: 25,                  null: false
    t.string   "req_version",         limit: 10,                  null: false
    t.datetime "req_timestamp",                                   null: false
    t.string   "app_id",              limit: 50,                  null: false
    t.string   "customer_id",         limit: 50
    t.string   "cust_identity_type",  limit: 50
    t.string   "cust_identity_value", limit: 50
    t.string   "device_id",           limit: 50
    t.string   "account_no",          limit: 50
    t.string   "account_last_n",      limit: 50
    t.string   "default_account"
    t.string   "registered_account"
    t.string   "rep_no"
    t.string   "rep_version",         limit: 10
    t.datetime "rep_timestamp"
    t.string   "fault_code",          limit: 50
    t.string   "fault_reason",        limit: 1000
  end

  create_table "sb_stop_checks", force: :cascade do |t|
    t.string   "req_no",                                          null: false
    t.integer  "attempt_no",                       precision: 38, null: false
    t.string   "status_code",         limit: 25,                  null: false
    t.string   "req_version",         limit: 10,                  null: false
    t.datetime "req_timestamp",                                   null: false
    t.string   "app_id",              limit: 50,                  null: false
    t.string   "customer_id",         limit: 50
    t.string   "cust_identity_type",  limit: 50
    t.string   "cust_identity_value", limit: 50
    t.string   "device_id",           limit: 50
    t.string   "account_no",          limit: 50
    t.string   "account_last_n",      limit: 50
    t.string   "default_account"
    t.string   "registered_account"
    t.string   "order_type",          limit: 1
    t.string   "from_check_no",       limit: 100
    t.string   "to_check_no",         limit: 100
    t.string   "rep_no"
    t.string   "rep_version",         limit: 10
    t.datetime "rep_timestamp"
    t.string   "fault_code",          limit: 50
    t.string   "fault_reason",        limit: 1000
  end

  create_table "sc_backend_response_codes", force: :cascade do |t|
    t.string   "is_enabled",       limit: 1,                                null: false
    t.string   "sc_backend_code",  limit: 20,                               null: false
    t.string   "response_code",    limit: 50,                               null: false
    t.string   "fault_code",       limit: 50,                               null: false
    t.datetime "created_at",                                                null: false
    t.datetime "updated_at",                                                null: false
    t.string   "created_by",       limit: 20
    t.string   "updated_by",       limit: 20
    t.integer  "lock_version",                 precision: 38, default: 0,   null: false
    t.string   "approval_status",  limit: 1,                  default: "U", null: false
    t.string   "last_action",      limit: 1,                  default: "C"
    t.integer  "approved_id",      limit: nil
    t.integer  "approved_version",             precision: 38
  end

  add_index "sc_backend_response_codes", ["sc_backend_code", "response_code", "approval_status"], name: "sc_backend_response_codes_01", unique: true

  create_table "sc_backend_settings", force: :cascade do |t|
    t.string   "backend_code",     limit: 50,                               null: false
    t.string   "service_code",     limit: 50,                               null: false
    t.string   "app_id",           limit: 50
    t.integer  "settings_cnt",     limit: nil
    t.string   "setting1"
    t.string   "setting2"
    t.string   "setting3"
    t.string   "setting4"
    t.string   "setting5"
    t.string   "setting6"
    t.string   "setting7"
    t.string   "setting8"
    t.string   "setting9"
    t.string   "setting10"
    t.datetime "created_at",                                                null: false
    t.datetime "updated_at",                                                null: false
    t.string   "created_by",       limit: 20
    t.string   "updated_by",       limit: 20
    t.integer  "lock_version",                 precision: 38, default: 0,   null: false
    t.string   "last_action",      limit: 1,                  default: "C", null: false
    t.string   "approval_status",  limit: 1,                  default: "U", null: false
    t.integer  "approved_version",             precision: 38
    t.integer  "approved_id",      limit: nil
    t.string   "is_std",           limit: 1,                  default: "f", null: false
    t.string   "is_enabled",       limit: 1,                  default: "f", null: false
  end

  add_index "sc_backend_settings", ["backend_code", "service_code", "app_id", "approval_status"], name: "sc_backend_settings_01", unique: true

  create_table "sc_backend_stats", force: :cascade do |t|
    t.string   "code",                    limit: 20,  null: false
    t.integer  "consecutive_failure_cnt", limit: nil, null: false
    t.integer  "consecutive_success_cnt", limit: nil, null: false
    t.datetime "window_started_at",                   null: false
    t.datetime "window_ends_at",                      null: false
    t.integer  "window_failure_cnt",      limit: nil, null: false
    t.integer  "window_success_cnt",      limit: nil, null: false
    t.string   "auditable_type",                      null: false
    t.integer  "auditable_id",            limit: nil, null: false
    t.string   "step_name",               limit: 100
    t.datetime "updated_at",                          null: false
    t.integer  "last_status_change_id",   limit: nil
    t.datetime "last_alert_email_at"
    t.string   "last_alert_email_ref",    limit: 64
  end

  add_index "sc_backend_stats", ["code"], name: "sc_backend_stats_1", unique: true

  create_table "sc_backend_status", force: :cascade do |t|
    t.string  "code",                  limit: 20,  null: false
    t.string  "status",                limit: 1,   null: false
    t.integer "last_status_change_id", limit: nil
  end

  add_index "sc_backend_status", ["code"], name: "sc_backend_status_2", unique: true
  add_index "sc_backend_status", ["last_status_change_id"], name: "sc_backend_status_1"

  create_table "sc_backend_status_changes", force: :cascade do |t|
    t.string   "code",       limit: 20, null: false
    t.string   "new_status", limit: 1,  null: false
    t.string   "remarks",               null: false
    t.string   "created_by", limit: 20
    t.datetime "created_at",            null: false
  end

  create_table "sc_backends", force: :cascade do |t|
    t.string   "code",                     limit: 20,                               null: false
    t.string   "do_auto_shutdown",         limit: 1,                                null: false
    t.integer  "max_consecutive_failures",             precision: 38,               null: false
    t.integer  "window_in_mins",           limit: 2,   precision: 2,                null: false
    t.integer  "max_window_failures",                  precision: 38,               null: false
    t.string   "do_auto_start",            limit: 1,                                null: false
    t.integer  "min_consecutive_success",              precision: 38,               null: false
    t.integer  "min_window_success",                   precision: 38,               null: false
    t.string   "alert_email_to"
    t.string   "created_by",               limit: 20
    t.string   "updated_by",               limit: 20
    t.datetime "created_at",                                                        null: false
    t.datetime "updated_at",                                                        null: false
    t.integer  "lock_version",                         precision: 38, default: 0,   null: false
    t.string   "approval_status",          limit: 1,                  default: "U", null: false
    t.string   "last_action",              limit: 1,                  default: "C", null: false
    t.integer  "approved_version",                     precision: 38
    t.integer  "approved_id",              limit: nil
    t.string   "url",                      limit: 100
    t.string   "use_proxy",                limit: 1,                  default: "Y", null: false
    t.integer  "first_requery_after",                  precision: 38, default: 15,  null: false
    t.integer  "requery_interval",                     precision: 38, default: 15,  null: false
    t.string   "http_username",            limit: 100
    t.string   "http_password"
  end

  add_index "sc_backends", ["code", "approval_status"], name: "sc_backends_01", unique: true

  create_table "sc_events", force: :cascade do |t|
    t.string   "event",                   null: false
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.string   "event_type",   limit: 50
    t.string   "service_code", limit: 50
    t.string   "db_unit_name", limit: 50
  end

  add_index "sc_events", ["event", "service_code"], name: "sc_events_01", unique: true

  create_table "sc_fault_codes", force: :cascade do |t|
    t.string   "fault_code",      limit: 50,   null: false
    t.string   "fault_reason",    limit: 1000, null: false
    t.string   "fault_kind",      limit: 1,    null: false
    t.string   "occurs_when",     limit: 1000, null: false
    t.string   "remedial_action", limit: 1000, null: false
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
  end

  create_table "sc_jobs", force: :cascade do |t|
    t.string   "code",            limit: 100,                                  null: false
    t.integer  "sc_service_id",   limit: nil,                                  null: false
    t.integer  "run_at_hour",                  precision: 38
    t.datetime "last_run_at"
    t.string   "last_run_by",     limit: 100
    t.string   "run_now",         limit: 1
    t.string   "paused",          limit: 1
    t.integer  "run_every_hour",               precision: 38
    t.string   "cldr",                                        default: "GREG", null: false
    t.string   "status_code",     limit: 50
    t.string   "fault_code",      limit: 50
    t.string   "fault_subcode",   limit: 50
    t.string   "fault_reason",    limit: 1000
    t.text     "fault_bitstream"
    t.integer  "run_every_min",                precision: 38
  end

  add_index "sc_jobs", ["code", "sc_service_id"], name: "sc_jobs_01", unique: true

  create_table "sc_proxies", force: :cascade do |t|
    t.string   "url",              limit: 100,                              null: false
    t.string   "is_enabled",       limit: 1,                  default: "Y", null: false
    t.string   "username",         limit: 100
    t.string   "password"
    t.datetime "created_at",                                                null: false
    t.datetime "updated_at",                                                null: false
    t.string   "created_by",       limit: 20
    t.string   "updated_by",       limit: 20
    t.integer  "lock_version",                 precision: 38, default: 0,   null: false
    t.string   "last_action",      limit: 1,                  default: "C", null: false
    t.string   "approval_status",  limit: 1,                  default: "U", null: false
    t.integer  "approved_version",             precision: 38
    t.integer  "approved_id",      limit: nil
  end

  add_index "sc_proxies", ["url", "approval_status"], name: "sc_proxies_01", unique: true

  create_table "sc_services", force: :cascade do |t|
    t.string   "code",             limit: 50,                               null: false
    t.string   "name",             limit: 50,                               null: false
    t.datetime "created_at",                                                null: false
    t.datetime "updated_at",                                                null: false
    t.string   "created_by",       limit: 20
    t.string   "updated_by",       limit: 20
    t.integer  "lock_version",                 precision: 38, default: 0,   null: false
    t.string   "last_action",      limit: 1,                  default: "C", null: false
    t.string   "approval_status",  limit: 1,                  default: "U", null: false
    t.integer  "approved_version",             precision: 38
    t.integer  "approved_id",      limit: nil
    t.string   "url",              limit: 100
    t.string   "use_proxy",        limit: 1,                  default: "Y", null: false
    t.string   "http_username",    limit: 100
    t.string   "http_password"
  end

  add_index "sc_services", ["code", "approval_status"], name: "sc_services_01"
  add_index "sc_services", ["name", "approval_status"], name: "sc_services_02"

  create_table "services", force: :cascade do |t|
    t.string "name",           limit: 50
    t.string "kind"
    t.string "class_name",     limit: 1000
    t.string "dashboard_name"
  end

  create_table "sm_audit_logs", force: :cascade do |t|
    t.string   "req_no",            limit: 32,                  null: false
    t.string   "partner_code",      limit: 32,                  null: false
    t.integer  "attempt_no",                     precision: 38, null: false
    t.string   "status_code",       limit: 25,                  null: false
    t.string   "sm_auditable_type",                             null: false
    t.integer  "sm_auditable_id",   limit: nil,                 null: false
    t.string   "fault_code"
    t.string   "fault_subcode",     limit: 50
    t.string   "fault_reason",      limit: 1000
    t.datetime "req_timestamp"
    t.datetime "rep_timestamp"
    t.text     "req_bitstream",                                 null: false
    t.text     "rep_bitstream"
    t.text     "fault_bitstream"
  end

  add_index "sm_audit_logs", ["partner_code", "req_no", "attempt_no"], name: "uk_sm_audit_logs_1", unique: true
  add_index "sm_audit_logs", ["sm_auditable_type", "sm_auditable_id"], name: "uk_sm_audit_logs_2", unique: true

  create_table "sm_audit_steps", force: :cascade do |t|
    t.string   "sm_auditable_type",                             null: false
    t.integer  "sm_auditable_id",   limit: nil,                 null: false
    t.integer  "step_no",                        precision: 38, null: false
    t.integer  "attempt_no",                     precision: 38, null: false
    t.string   "step_name",         limit: 100,                 null: false
    t.string   "status_code",       limit: 25,                  null: false
    t.string   "fault_code"
    t.string   "fault_subcode",     limit: 50
    t.string   "fault_reason",      limit: 1000
    t.string   "req_reference"
    t.datetime "req_timestamp"
    t.string   "rep_reference"
    t.datetime "rep_timestamp"
    t.text     "req_bitstream"
    t.text     "rep_bitstream"
    t.text     "fault_bitstream"
    t.string   "remote_host",       limit: 500
    t.string   "req_uri",           limit: 500
    t.text     "req_header"
    t.text     "rep_header"
  end

  add_index "sm_audit_steps", ["sm_auditable_type", "sm_auditable_id", "step_no", "attempt_no"], name: "uk_sm_audit_steps", unique: true

  create_table "sm_bank_accounts", force: :cascade do |t|
    t.string   "sm_code",                 limit: 20,                               null: false
    t.string   "customer_id",             limit: 15,                               null: false
    t.string   "account_no",              limit: 20,                               null: false
    t.string   "mmid",                    limit: 7
    t.string   "mobile_no",               limit: 10
    t.string   "created_by",              limit: 20
    t.string   "updated_by",              limit: 20
    t.datetime "created_at",                                                       null: false
    t.datetime "updated_at",                                                       null: false
    t.integer  "lock_version",                        precision: 38, default: 0,   null: false
    t.string   "approval_status",         limit: 1,                  default: "U", null: false
    t.string   "last_action",             limit: 1,                  default: "C", null: false
    t.integer  "approved_version",                    precision: 38
    t.integer  "approved_id",             limit: nil
    t.string   "is_enabled",              limit: 1,                  default: "Y", null: false
    t.string   "notify_app_code",         limit: 20
    t.string   "notify_on_status_change", limit: 1,                  default: "f", null: false
  end

  add_index "sm_bank_accounts", ["account_no", "approval_status"], name: "sm_bank_accounts_02", unique: true
  add_index "sm_bank_accounts", ["sm_code", "customer_id", "account_no", "approval_status"], name: "sm_bank_accounts_01", unique: true

  create_table "sm_banks", force: :cascade do |t|
    t.string   "code",                 limit: 20,                               null: false
    t.string   "name",                 limit: 100,                              null: false
    t.string   "bank_code",            limit: 20,                               null: false
    t.decimal  "low_balance_alert_at",                            default: 0.0, null: false
    t.string   "identity_user_id",     limit: 20,                               null: false
    t.string   "neft_allowed",         limit: 1,                                null: false
    t.string   "imps_allowed",         limit: 1,                                null: false
    t.string   "created_by",           limit: 20
    t.string   "updated_by",           limit: 20
    t.datetime "created_at",                                                    null: false
    t.datetime "updated_at",                                                    null: false
    t.integer  "lock_version",                     precision: 38, default: 0,   null: false
    t.string   "approval_status",      limit: 1,                  default: "U", null: false
    t.string   "last_action",          limit: 1,                  default: "C", null: false
    t.integer  "approved_version",                 precision: 38
    t.integer  "approved_id",          limit: nil
    t.string   "is_enabled",           limit: 1,                  default: "Y", null: false
    t.datetime "notification_sent_at"
    t.string   "rtgs_allowed",         limit: 1,                  default: "f", null: false
  end

  add_index "sm_banks", ["code", "approval_status"], name: "sm_banks_01", unique: true
  add_index "sm_banks", ["name", "bank_code"], name: "sm_banks_02"

  create_table "sm_payments", force: :cascade do |t|
    t.string   "req_no",            limit: 20
    t.string   "req_version",       limit: 10
    t.datetime "req_timestamp"
    t.string   "partner_code",      limit: 20
    t.string   "customer_id",       limit: 15
    t.string   "debit_account_no",  limit: 20
    t.string   "rmtr_account_no",   limit: 20
    t.string   "rmtr_account_ifsc", limit: 50
    t.string   "rmtr_full_name",    limit: 100
    t.string   "rmtr_address1"
    t.string   "rmtr_address2"
    t.string   "rmtr_address3"
    t.string   "rmtr_postal_code",  limit: 10
    t.string   "rmtr_city",         limit: 100
    t.string   "rmtr_state",        limit: 100
    t.string   "rmtr_country",      limit: 100
    t.string   "rmtr_mobile_no",    limit: 10
    t.string   "rmtr_email_id",     limit: 100
    t.string   "bene_full_name",    limit: 100
    t.string   "bene_address1"
    t.string   "bene_address2"
    t.string   "bene_address3"
    t.string   "bene_postal_code",  limit: 100
    t.string   "bene_city",         limit: 100
    t.string   "bene_state",        limit: 100
    t.string   "bene_country",      limit: 100
    t.string   "bene_mobile_no",    limit: 10
    t.string   "bene_email_id",     limit: 100
    t.string   "bene_account_no",   limit: 20
    t.string   "bene_account_ifsc", limit: 50
    t.string   "req_transfer_type", limit: 4
    t.string   "transfer_ccy",      limit: 5
    t.decimal  "transfer_amount"
    t.string   "rmtr_to_bene_note"
    t.string   "rep_version",       limit: 20
    t.string   "rep_no",            limit: 50
    t.integer  "attempt_no",                     precision: 38
    t.string   "transfer_type",     limit: 4
    t.string   "status_code",       limit: 50
    t.string   "bank_ref_no",       limit: 50
    t.string   "fault_code",        limit: 50
    t.string   "fault_subcode",     limit: 50
    t.string   "fault_reason",      limit: 1000
    t.datetime "rep_timestamp"
    t.string   "cbs_req_ref_no",    limit: 100
    t.datetime "reconciled_at"
    t.string   "notify_status",     limit: 100
    t.integer  "notify_attempt_no",              precision: 38
    t.datetime "notify_attempt_at"
    t.datetime "notified_at"
    t.string   "notify_result",     limit: 50
  end

  add_index "sm_payments", ["customer_id", "req_no", "attempt_no", "status_code", "transfer_type", "partner_code", "debit_account_no", "rmtr_account_no", "rmtr_account_ifsc", "bene_account_no", "bank_ref_no", "req_timestamp", "rep_timestamp"], name: "sm_payments_03"
  add_index "sm_payments", ["notify_status"], name: "sm_payments_02"
  add_index "sm_payments", ["partner_code", "req_no", "attempt_no"], name: "sm_payments_01", unique: true

  create_table "sm_pending_confirmations", force: :cascade do |t|
    t.string   "broker_uuid",                   null: false
    t.string   "sm_auditable_type",             null: false
    t.integer  "sm_auditable_id",   limit: nil, null: false
    t.datetime "created_at",                    null: false
  end

  add_index "sm_pending_confirmations", ["broker_uuid"], name: "sm_confirmations_02"
  add_index "sm_pending_confirmations", ["sm_auditable_type", "sm_auditable_id"], name: "sm_confirmations_01", unique: true

  create_table "sm_unapproved_records", force: :cascade do |t|
    t.integer  "sm_approvable_id",   limit: nil
    t.string   "sm_approvable_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "ssp_apps", force: :cascade do |t|
    t.string  "app_code",         limit: 20,                               null: false
    t.string  "created_by",       limit: 20
    t.string  "updated_by",       limit: 20
    t.integer "lock_version",                 precision: 38, default: 0,   null: false
    t.string  "last_action",      limit: 1,                  default: "C", null: false
    t.string  "approval_status",  limit: 1,                  default: "U", null: false
    t.integer "approved_version",             precision: 38
    t.integer "approved_id",      limit: nil
  end

  add_index "ssp_apps", ["app_code"], name: "ssp_apps_01", unique: true

  create_table "ssp_audit_steps", force: :cascade do |t|
    t.string   "step_name",        limit: 100,  null: false
    t.string   "status_code",      limit: 100,  null: false
    t.string   "app_code",         limit: 50
    t.string   "customer_code",    limit: 15
    t.datetime "req_timestamp",                 null: false
    t.datetime "rep_timestamp"
    t.datetime "up_req_timestamp"
    t.string   "up_host",          limit: 500
    t.string   "up_req_uri",       limit: 500
    t.datetime "up_rep_timestamp"
    t.string   "fault_code",       limit: 50
    t.string   "fault_subcode",    limit: 50
    t.string   "fault_reason",     limit: 1000
    t.text     "up_req_header"
    t.text     "up_rep_header"
    t.text     "up_req_bitstream"
    t.text     "up_rep_bitstream"
    t.text     "req_bitstream",                 null: false
    t.text     "rep_bitstream"
    t.text     "fault_bitstream"
  end

  create_table "ssp_banks", force: :cascade do |t|
    t.string   "customer_code",             limit: 15,                               null: false
    t.string   "debit_account_url",         limit: 500
    t.string   "reverse_debit_account_url", limit: 500
    t.string   "get_status_url",            limit: 500
    t.string   "get_account_status_url",    limit: 500
    t.string   "http_username",             limit: 100
    t.string   "http_password"
    t.integer  "settings_cnt",              limit: nil
    t.string   "setting1"
    t.string   "setting2"
    t.string   "setting3"
    t.string   "setting4"
    t.string   "setting5"
    t.datetime "created_at",                                                         null: false
    t.datetime "updated_at",                                                         null: false
    t.string   "created_by",                limit: 20
    t.string   "updated_by",                limit: 20
    t.integer  "lock_version",                          precision: 38, default: 0,   null: false
    t.string   "last_action",               limit: 1,                  default: "C", null: false
    t.string   "approval_status",           limit: 1,                  default: "U", null: false
    t.integer  "approved_version",                      precision: 38
    t.integer  "approved_id",               limit: nil
    t.string   "app_code",                  limit: 50,                               null: false
    t.string   "is_enabled",                limit: 1,                  default: "Y", null: false
    t.string   "use_proxy",                 limit: 1,                  default: "Y", null: false
  end

  add_index "ssp_banks", ["customer_code", "app_code", "approval_status"], name: "ssp_banks_01", unique: true

  create_table "su_customers", force: :cascade do |t|
    t.string   "account_no",            limit: 20
    t.string   "customer_id",           limit: 15
    t.string   "pool_account_no",       limit: 20
    t.string   "pool_customer_id",      limit: 20
    t.string   "is_enabled",            limit: 1
    t.string   "created_by",            limit: 20
    t.string   "updated_by",            limit: 20
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "lock_version",                      precision: 38, default: 0
    t.string   "approval_status",       limit: 1,                  default: "U"
    t.string   "last_action",           limit: 1,                  default: "C"
    t.integer  "approved_version",                  precision: 38
    t.integer  "approved_id",           limit: nil
    t.decimal  "max_distance_for_name"
    t.string   "customer_name",         limit: 100
    t.string   "ops_email"
    t.string   "rm_email"
  end

  add_index "su_customers", ["customer_id", "account_no", "approval_status"], name: "uk_su_customers_1", unique: true

  create_table "su_incoming_files", force: :cascade do |t|
    t.string   "file_name",             limit: 100
    t.decimal  "debit_amount"
    t.string   "debit_reference_no",    limit: 64
    t.string   "debit_status",          limit: 20
    t.datetime "debited_at"
    t.decimal  "reversal_amount"
    t.string   "reversal_reference_no", limit: 64
    t.string   "reversal_status",       limit: 20
    t.datetime "reversed_at"
  end

  create_table "su_incoming_records", force: :cascade do |t|
    t.integer "incoming_file_record_id", limit: nil
    t.string  "file_name",               limit: 100
    t.string  "corp_account_no",         limit: 20
    t.string  "corp_ref_no",             limit: 64
    t.string  "corp_stmt_txt"
    t.string  "emp_account_no",          limit: 20
    t.string  "emp_name",                limit: 100
    t.string  "emp_ref_no",              limit: 64
    t.decimal "salary_amount"
    t.string  "emp_stmt_txt"
    t.string  "account_name",            limit: 100
    t.decimal "distance_in_name"
    t.string  "debit_ref_no",            limit: 20
  end

  add_index "su_incoming_records", ["incoming_file_record_id", "file_name"], name: "su_incoming_records_1", unique: true

  create_table "su_unapproved_records", force: :cascade do |t|
    t.integer  "su_approvable_id",   limit: nil
    t.string   "su_approvable_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "test234", force: :cascade do |t|
    t.integer "r_id", limit: nil
  end

  create_table "udf_attributes", force: :cascade do |t|
    t.string   "class_name",       limit: 100,                              null: false
    t.string   "attribute_name",   limit: 100,                              null: false
    t.string   "label_text"
    t.string   "is_enabled",       limit: 1,                  default: "Y", null: false
    t.string   "is_mandatory",                                default: "f"
    t.string   "control_type"
    t.string   "data_type"
    t.datetime "created_at",                                                null: false
    t.datetime "updated_at",                                                null: false
    t.integer  "lock_version",                 precision: 38, default: 0,   null: false
    t.string   "approval_status",  limit: 1,                  default: "U", null: false
    t.string   "last_action",      limit: 1,                  default: "C"
    t.integer  "approved_version",             precision: 38
    t.integer  "approved_id",      limit: nil
    t.text     "constraints"
    t.text     "select_options"
    t.string   "created_by",       limit: 20
    t.string   "updated_by",       limit: 20
  end

  add_index "udf_attributes", ["class_name", "attribute_name", "approval_status"], name: "udf_attribute_index_on_status", unique: true

  create_table "una_rec_bkp_181001to181130", id: false, force: :cascade do |t|
    t.integer  "id",              limit: nil, null: false
    t.integer  "approvable_id",   limit: nil
    t.string   "approvable_type"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  create_table "unapproved_records", force: :cascade do |t|
    t.integer  "approvable_id",   limit: nil
    t.string   "approvable_type"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  add_index "unapproved_records", ["approvable_id", "approvable_type"], name: "uk_unapproved_records", unique: true

  create_table "user_groups", force: :cascade do |t|
    t.integer  "user_id",          limit: nil
    t.integer  "group_id",         limit: nil
    t.integer  "lock_version",                 precision: 38, default: 0,   null: false
    t.string   "approval_status",  limit: 1,                  default: "U", null: false
    t.string   "last_action",      limit: 1,                  default: "C"
    t.integer  "approved_version",             precision: 38
    t.integer  "approved_id",      limit: nil
    t.string   "created_by",       limit: 20
    t.string   "updated_by",       limit: 20
    t.boolean  "disabled",         limit: nil
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_roles", force: :cascade do |t|
    t.integer  "user_id",          limit: nil
    t.integer  "role_id",          limit: nil
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "lock_version",                 precision: 38, default: 0,   null: false
    t.string   "approval_status",  limit: 1,                  default: "U", null: false
    t.string   "last_action",      limit: 1,                  default: "C"
    t.integer  "approved_version",             precision: 38
    t.integer  "approved_id",      limit: nil
    t.string   "created_by",       limit: 20
    t.string   "updated_by",       limit: 20
  end

  create_table "users", force: :cascade do |t|
    t.string    "email",                                             default: "",    null: false
    t.string    "encrypted_password",                                default: ""
    t.string    "reset_password_token"
    t.datetime  "reset_password_sent_at"
    t.datetime  "remember_created_at"
    t.integer   "sign_in_count",                      precision: 38, default: 0
    t.datetime  "current_sign_in_at"
    t.datetime  "last_sign_in_at"
    t.string    "current_sign_in_ip"
    t.string    "last_sign_in_ip"
    t.datetime  "created_at"
    t.datetime  "updated_at"
    t.string    "username"
    t.boolean   "inactive",               limit: nil,                default: false
    t.string    "first_name"
    t.string    "last_name"
    t.string    "unique_session_id",      limit: 20
    t.string    "mobile_no",              limit: 20
    t.integer   "role_id",                limit: nil
    t.integer   "tenant_id",              limit: nil,                default: 0,     null: false
    t.timestamp "notification_sent_at",   limit: 6
    t.string    "approval_status",        limit: 1,                  default: "U",   null: false
    t.string    "last_action",            limit: 1,                  default: "C"
    t.integer   "approved_id",            limit: nil
    t.integer   "approved_version",                   precision: 38
    t.boolean   "active",                 limit: nil,                default: true
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["username", "approval_status"], name: "users_01", unique: true

  create_table "users_groups", id: false, force: :cascade do |t|
    t.integer "user_id",  limit: nil
    t.integer "group_id", limit: nil
  end

  create_table "users_roles", id: false, force: :cascade do |t|
    t.integer "user_id", limit: nil
    t.integer "role_id", limit: nil
  end

  add_index "users_roles", ["user_id", "role_id"], name: "i_users_roles_user_id_role_id"

  create_table "whitelisted_identities", force: :cascade do |t|
    t.integer  "partner_id",             limit: nil,                              null: false
    t.string   "full_name",              limit: 50
    t.string   "first_name",             limit: 50
    t.string   "last_name",              limit: 50
    t.string   "id_type",                limit: 30
    t.string   "id_number",              limit: 50
    t.string   "id_country"
    t.date     "id_issue_date"
    t.date     "id_expiry_date"
    t.string   "is_verified",            limit: 1
    t.datetime "verified_at"
    t.string   "verified_by",            limit: 20
    t.integer  "first_used_with_txn_id", limit: nil
    t.integer  "last_used_with_txn_id",  limit: nil
    t.integer  "times_used",                         precision: 38
    t.string   "created_by",             limit: 20
    t.string   "updated_by",             limit: 20
    t.integer  "lock_version",                       precision: 38
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "approval_status",        limit: 1,                  default: "U", null: false
    t.string   "last_action",            limit: 1,                  default: "C"
    t.integer  "approved_version",                   precision: 38
    t.integer  "approved_id",            limit: nil
    t.string   "bene_account_no",        limit: 30
    t.string   "bene_account_ifsc",      limit: 15
    t.string   "rmtr_code",              limit: 50
    t.integer  "created_for_txn_id",     limit: nil
    t.string   "created_for_req_no",                                default: "0", null: false
    t.string   "is_revoked",             limit: 1,                  default: "f", null: false
    t.string   "id_for",                 limit: 1,                  default: "f", null: false
  end

  add_index "whitelisted_identities", ["last_used_with_txn_id"], name: "i_whi_ide_las_use_wit_txn_id"
  add_index "whitelisted_identities", ["partner_id", "bene_account_no", "bene_account_ifsc", "id_expiry_date", "is_revoked", "created_for_req_no", "approval_status"], name: "in_wl_2"
  add_index "whitelisted_identities", ["partner_id", "full_name", "rmtr_code", "bene_account_no", "bene_account_ifsc"], name: "in_wl_4"
  add_index "whitelisted_identities", ["partner_id", "id_type", "id_number", "id_country", "id_issue_date", "id_expiry_date", "is_revoked", "created_for_req_no", "approval_status"], name: "in_wl_1"
  add_index "whitelisted_identities", ["partner_id", "rmtr_code", "id_expiry_date", "is_revoked", "created_for_req_no", "approval_status"], name: "in_wl_3"

end
