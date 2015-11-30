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

ActiveRecord::Schema.define(version: 20151127073058) do

  create_table "active_admin_comments", force: :cascade do |t|
    t.string   "resource_id",   null: false
    t.string   "resource_type", null: false
    t.integer  "author_id"
    t.string   "author_type"
    t.text     "body"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "namespace"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id"
  add_index "active_admin_comments", ["namespace"], name: "index_active_admin_comments_on_namespace"
  add_index "active_admin_comments", ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id"

  create_table "admin_roles", force: :cascade do |t|
    t.string   "name"
    t.integer  "resource_id"
    t.string   "resource_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "admin_roles", ["name", "resource_type", "resource_id"], name: "index_admin_roles_on_name_and_resource_type_and_resource_id"
  add_index "admin_roles", ["name"], name: "index_admin_roles_on_name"

  create_table "admin_users", force: :cascade do |t|
    t.string   "email",                             default: "",    null: false
    t.string   "encrypted_password",                default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                     default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "username"
    t.string   "unique_session_id",      limit: 20
    t.boolean  "inactive",                          default: false
    t.integer  "failed_attempts",                   default: 0
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.datetime "password_changed_at"
  end

  add_index "admin_users", ["email"], name: "index_admin_users_on_email", unique: true
  add_index "admin_users", ["password_changed_at"], name: "index_admin_users_on_password_changed_at"
  add_index "admin_users", ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true

  create_table "admin_users_admin_roles", id: false, force: :cascade do |t|
    t.integer "admin_user_id"
    t.integer "admin_role_id"
  end

  add_index "admin_users_admin_roles", ["admin_user_id", "admin_role_id"], name: "index_on_user_roles"

  create_table "api_keys", force: :cascade do |t|
    t.string   "access_token"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "attachments", force: :cascade do |t|
    t.string   "note"
    t.string   "file"
    t.integer  "attachable_id"
    t.string   "attachable_type"
    t.string   "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "attachments", ["attachable_id"], name: "index_attachments_on_attachable_id"

  create_table "audits", force: :cascade do |t|
    t.integer  "auditable_id"
    t.string   "auditable_type"
    t.integer  "associated_id"
    t.string   "associated_type"
    t.integer  "user_id"
    t.string   "user_type"
    t.string   "username"
    t.string   "action"
    t.text     "audited_changes"
    t.integer  "version",         default: 0
    t.string   "comment"
    t.string   "remote_address"
    t.datetime "created_at"
    t.string   "request_uuid"
  end

  add_index "audits", ["associated_id", "associated_type"], name: "associated_index"
  add_index "audits", ["auditable_id", "auditable_type"], name: "auditable_index"
  add_index "audits", ["created_at"], name: "index_audits_on_created_at"
  add_index "audits", ["request_uuid"], name: "index_audits_on_request_uuid"
  add_index "audits", ["user_id", "user_type"], name: "user_index"

  create_table "banks", force: :cascade do |t|
    t.string   "ifsc"
    t.string   "name"
    t.boolean  "imps_enabled"
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
    t.string   "created_by"
    t.string   "updated_by"
    t.integer  "lock_version",               default: 0,   null: false
    t.string   "approval_status",  limit: 1, default: "U", null: false
    t.string   "last_action",      limit: 1, default: "C"
    t.integer  "approved_version"
    t.integer  "approved_id"
  end

  add_index "banks", ["ifsc", "approval_status"], name: "index_banks_on_ifsc_and_approval_status", unique: true

  create_table "bm_add_biller_accts", force: :cascade do |t|
    t.string   "app_id",             limit: 50,   null: false
    t.string   "req_no",             limit: 32,   null: false
    t.integer  "attempt_no",                      null: false
    t.string   "req_version",        limit: 5,    null: false
    t.datetime "req_timestamp",                   null: false
    t.string   "customer_id",        limit: 15,   null: false
    t.string   "biller_code",        limit: 50,   null: false
    t.integer  "num_params",                      null: false
    t.string   "param1",             limit: 100
    t.string   "param2",             limit: 100
    t.string   "param3",             limit: 100
    t.string   "param4",             limit: 100
    t.string   "param5",             limit: 100
    t.string   "status_code",        limit: 50,   null: false
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

  create_table "bm_aggregator_payments", force: :cascade do |t|
    t.string   "cod_acct_no",       limit: 50,                   null: false
    t.string   "neft_sender_ifsc",                               null: false
    t.string   "bene_acct_no",      limit: 50,                   null: false
    t.float    "payment_amount"
    t.string   "bank_ref",          limit: 64
    t.integer  "lock_version",                                   null: false
    t.datetime "created_at",                                     null: false
    t.datetime "updated_at",                                     null: false
    t.string   "approval_status",   limit: 1,    default: "U",   null: false
    t.string   "last_action",       limit: 1
    t.integer  "approved_version"
    t.integer  "approved_id"
    t.string   "status",            limit: 50,   default: "NEW", null: false
    t.string   "fault_code",        limit: 50
    t.string   "fault_reason",      limit: 1000
    t.string   "neft_req_ref",      limit: 64
    t.integer  "neft_attempt_no"
    t.string   "neft_rep_ref",      limit: 64
    t.date     "neft_completed_at"
    t.string   "pending_approval",  limit: 1,    default: "Y",   null: false
    t.string   "bene_acct_ifsc",    limit: 255,  default: "1",   null: false
    t.string   "rmtr_to_bene_note", limit: 255
    t.string   "is_reconciled",     limit: 1,    default: "Y",   null: false
    t.date     "reconciled_at"
    t.date     "neft_attempt_at"
    t.string   "customer_id",       limit: 50,   default: "1",   null: false
    t.string   "rmtr_name",         limit: 50,   default: "a",   null: false
    t.string   "service_id",        limit: 255
    t.string   "bene_name",         limit: 255
  end

  create_table "bm_apps", force: :cascade do |t|
    t.string   "app_id",           limit: 20,               null: false
    t.string   "channel_id",       limit: 20,               null: false
    t.integer  "lock_version",                              null: false
    t.string   "approval_status",  limit: 1,  default: "U", null: false
    t.string   "last_action",      limit: 1
    t.integer  "approved_version"
    t.integer  "approved_id"
    t.datetime "created_at",                                null: false
    t.datetime "updated_at",                                null: false
    t.string   "created_by",       limit: 20
    t.string   "updated_by",       limit: 20
  end

  add_index "bm_apps", ["app_id", "approval_status"], name: "index_bm_apps_on_app_id_and_approval_status", unique: true

  create_table "bm_audit_logs", force: :cascade do |t|
    t.string   "app_id",            limit: 50,   null: false
    t.string   "req_no",            limit: 32,   null: false
    t.integer  "attempt_no",                     null: false
    t.string   "status_code",       limit: 25,   null: false
    t.string   "bm_auditable_type", limit: 50,   null: false
    t.integer  "bm_auditable_id",                null: false
    t.string   "fault_code",        limit: 50
    t.string   "fault_reason",      limit: 1000
    t.text     "req_bitstream"
    t.datetime "req_timestamp"
    t.text     "rep_bitstream"
    t.datetime "rep_timestamp"
    t.text     "fault_bitstream"
  end

  add_index "bm_audit_logs", ["app_id", "req_no", "attempt_no"], name: "attempt_no_index_audit_logs", unique: true
  add_index "bm_audit_logs", ["bm_auditable_type", "bm_auditable_id"], name: "auditable_index_audit_logs", unique: true

  create_table "bm_bill_payments", force: :cascade do |t|
    t.string   "app_id",              limit: 50,                 null: false
    t.string   "req_no",              limit: 32,                 null: false
    t.integer  "attempt_no",                                     null: false
    t.string   "req_version",         limit: 5,                  null: false
    t.datetime "req_timestamp",                                  null: false
    t.string   "customer_id",         limit: 15,                 null: false
    t.string   "debit_account_no",    limit: 50,                 null: false
    t.string   "txn_kind",            limit: 50,                 null: false
    t.float    "txn_amount",                                     null: false
    t.string   "biller_code",         limit: 50
    t.string   "biller_acct_no",      limit: 50
    t.string   "bill_id",             limit: 50
    t.string   "status",              limit: 50,                 null: false
    t.string   "fault_code",          limit: 50
    t.string   "fault_reason",        limit: 1000
    t.string   "debit_req_ref",       limit: 64
    t.integer  "debit_attempt_no"
    t.datetime "debit_attempt_at"
    t.string   "debit_rep_ref",       limit: 64
    t.datetime "debited_at"
    t.string   "billpay_req_ref",     limit: 64
    t.integer  "billpay_attempt_no"
    t.datetime "billpay_attempt_at"
    t.string   "billpay_rep_ref",     limit: 64
    t.datetime "billpaid_at"
    t.string   "reversal_req_ref",    limit: 64
    t.integer  "reversal_attempt_no"
    t.datetime "reversal_attempt_at"
    t.string   "reversal_rep_ref",    limit: 64
    t.datetime "reversal_at"
    t.string   "refund_ref",          limit: 64
    t.datetime "refund_at"
    t.string   "is_reconciled",       limit: 1
    t.datetime "reconciled_at"
    t.string   "pending_approval",    limit: 1,    default: "Y"
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
  end

  add_index "bm_bill_payments", ["app_id", "req_no", "attempt_no"], name: "attepmt_index_bill_payments", unique: true

  create_table "bm_billers", force: :cascade do |t|
    t.string   "biller_code",       limit: 100,               null: false
    t.string   "biller_name",       limit: 100,               null: false
    t.string   "biller_category",   limit: 100,               null: false
    t.string   "biller_location",   limit: 100,               null: false
    t.string   "processing_method", limit: 1,                 null: false
    t.string   "is_enabled",        limit: 1,                 null: false
    t.integer  "num_params",                    default: 0,   null: false
    t.string   "param1_name",       limit: 100
    t.string   "param1_pattern",    limit: 100
    t.string   "param1_tooltip",    limit: 255
    t.string   "param2_name",       limit: 100
    t.string   "param2_pattern",    limit: 100
    t.string   "param2_tooltip",    limit: 255
    t.string   "param3_name",       limit: 100
    t.string   "param3_pattern",    limit: 100
    t.string   "param3_tooltip",    limit: 255
    t.string   "param4_name",       limit: 100
    t.string   "param4_pattern",    limit: 100
    t.string   "param4_tooltip",    limit: 255
    t.string   "param5_name",       limit: 100
    t.string   "param5_pattern",    limit: 100
    t.string   "param5_tooltip",    limit: 255
    t.integer  "lock_version",                                null: false
    t.datetime "created_at",                                  null: false
    t.datetime "updated_at",                                  null: false
    t.string   "approval_status",   limit: 1,   default: "U", null: false
    t.string   "last_action",       limit: 1
    t.integer  "approved_version"
    t.integer  "approved_id"
    t.string   "created_by",        limit: 20
    t.string   "updated_by",        limit: 20
    t.string   "partial_pay",       limit: 1
    t.string   "biller_nickname",   limit: 10
  end

  add_index "bm_billers", ["biller_code", "approval_status"], name: "index_bm_billers_on_biller_code_and_approval_status", unique: true

  create_table "bm_billpay_steps", force: :cascade do |t|
    t.integer  "bm_bill_payment_id",              null: false
    t.integer  "step_no",                         null: false
    t.integer  "attempt_no",                      null: false
    t.string   "step_name",          limit: 100,  null: false
    t.string   "status_code",        limit: 25,   null: false
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
    t.string   "app_id",         limit: 50,   null: false
    t.string   "req_no",         limit: 32,   null: false
    t.integer  "attempt_no",                  null: false
    t.string   "req_version",    limit: 5,    null: false
    t.datetime "req_timestamp",               null: false
    t.string   "customer_id",    limit: 15,   null: false
    t.string   "biller_acct_no", limit: 50
    t.string   "status_code",    limit: 50,   null: false
    t.string   "rep_version",    limit: 5
    t.string   "rep_no",         limit: 32
    t.datetime "rep_timestamp"
    t.string   "fault_code",     limit: 50
    t.string   "fault_reason",   limit: 1000
  end

  add_index "bm_del_biller_accts", ["app_id", "req_no", "attempt_no"], name: "attempt_no_index_del_accts", unique: true

  create_table "bm_pay_bills", force: :cascade do |t|
    t.string   "app_id",              limit: 50,   null: false
    t.string   "req_no",              limit: 32,   null: false
    t.integer  "attempt_no",                       null: false
    t.string   "req_version",         limit: 5,    null: false
    t.datetime "req_timestamp",                    null: false
    t.string   "customer_id",         limit: 15,   null: false
    t.string   "debit_account_no",    limit: 50,   null: false
    t.string   "bill_id",             limit: 50,   null: false
    t.string   "status_code",         limit: 50,   null: false
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
    t.string   "app_id",              limit: 50,   null: false
    t.string   "req_no",              limit: 32,   null: false
    t.integer  "attempt_no",                       null: false
    t.string   "req_version",         limit: 5,    null: false
    t.datetime "req_timestamp",                    null: false
    t.string   "customer_id",         limit: 15,   null: false
    t.string   "debit_account_no",    limit: 50,   null: false
    t.string   "biller_account_no",   limit: 50,   null: false
    t.string   "payment_kind",        limit: 100,  null: false
    t.date     "bill_date"
    t.string   "bill_number",         limit: 50
    t.date     "due_date"
    t.float    "bill_amount"
    t.float    "payment_amount"
    t.string   "status_code",         limit: 50,   null: false
    t.string   "rep_version",         limit: 5
    t.string   "rep_no",              limit: 32
    t.datetime "rep_timestamp"
    t.string   "debit_reference_no",  limit: 32
    t.string   "biller_reference_no", limit: 32
    t.string   "fault_code",          limit: 50
    t.string   "fault_reason",        limit: 1000
  end

  add_index "bm_pay_to_biller_accts", ["app_id", "req_no", "attempt_no"], name: "attempt_no_index_biller_acct", unique: true

  create_table "bm_pay_to_billers", force: :cascade do |t|
    t.string   "app_id",              limit: 50,   null: false
    t.string   "req_no",              limit: 32,   null: false
    t.integer  "attempt_no",                       null: false
    t.string   "req_version",         limit: 5,    null: false
    t.datetime "req_timestamp",                    null: false
    t.string   "customer_id",         limit: 15,   null: false
    t.string   "debit_account_no",    limit: 50,   null: false
    t.string   "biller_code",         limit: 50,   null: false
    t.integer  "num_params",                       null: false
    t.string   "param1",              limit: 100
    t.string   "param2",              limit: 100
    t.string   "param3",              limit: 100
    t.string   "param4",              limit: 100
    t.string   "param5",              limit: 100
    t.string   "payment_kind",        limit: 100,  null: false
    t.date     "bill_date"
    t.string   "bill_number",         limit: 50
    t.date     "due_date"
    t.float    "bill_amount"
    t.float    "payment_amount"
    t.string   "status_code",         limit: 50,   null: false
    t.string   "rep_version",         limit: 5
    t.string   "rep_no",              limit: 32
    t.datetime "rep_timestamp"
    t.string   "debit_reference_no",  limit: 32
    t.string   "biller_reference_no", limit: 32
    t.string   "fault_code",          limit: 50
    t.string   "fault_reason",        limit: 1000
  end

  add_index "bm_pay_to_billers", ["app_id", "req_no", "attempt_no"], name: "attempt_no_index_pay_billers", unique: true

  create_table "bm_pending_aggr_payments", force: :cascade do |t|
    t.string   "broker_uuid",              limit: 500
    t.integer  "bm_aggregator_payment_id"
    t.datetime "created_at"
  end

  create_table "bm_pending_billpays", force: :cascade do |t|
    t.string   "broker_uuid",        null: false
    t.integer  "bm_bill_payment_id", null: false
    t.datetime "created_at",         null: false
  end

  create_table "bm_pending_debit_reversals", force: :cascade do |t|
    t.string   "broker_uuid",        null: false
    t.integer  "bm_bill_payment_id", null: false
    t.datetime "created_at",         null: false
  end

  create_table "bm_pending_debits", force: :cascade do |t|
    t.string   "broker_uuid",        null: false
    t.integer  "bm_bill_payment_id", null: false
    t.datetime "created_at",         null: false
  end

  create_table "bm_rules", force: :cascade do |t|
    t.string   "cod_acct_no",       limit: 16,                null: false
    t.string   "customer_id",       limit: 15,                null: false
    t.string   "bene_acct_no",                                null: false
    t.string   "bene_account_ifsc",                           null: false
    t.string   "neft_sender_ifsc",                            null: false
    t.integer  "lock_version",                                null: false
    t.datetime "created_at",                                  null: false
    t.datetime "updated_at",                                  null: false
    t.string   "approval_status",   limit: 1,  default: "U",  null: false
    t.string   "last_action",       limit: 1,  default: "C"
    t.integer  "approved_version"
    t.integer  "approved_id"
    t.string   "created_by",        limit: 20
    t.string   "updated_by",        limit: 20
    t.string   "source_id",         limit: 50, default: "qg", null: false
    t.integer  "traceid_prefix",               default: 1,    null: false
  end

  create_table "bm_unapproved_records", force: :cascade do |t|
    t.integer  "bm_approvable_id"
    t.string   "bm_approvable_type"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

  create_table "delayed_jobs", force: :cascade do |t|
    t.integer  "priority",   default: 0, null: false
    t.integer  "attempts",   default: 0, null: false
    t.text     "handler",                null: false
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

  create_table "ecol_audit_logs", force: :cascade do |t|
    t.integer  "ecol_transaction_id",              null: false
    t.string   "step_name",                        null: false
    t.integer  "attempt_no",                       null: false
    t.string   "fault_code",          limit: 50
    t.string   "fault_reason",        limit: 1000
    t.date     "req_timestamp"
    t.date     "rep_timestamp"
    t.text     "req_bitstream"
    t.text     "rep_bitstream"
    t.text     "fault_bitstream"
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
    t.string   "req_ref",             limit: 64
  end

  add_index "ecol_audit_logs", ["ecol_transaction_id", "step_name", "attempt_no"], name: "uk_ecol_audit_logs", unique: true

  create_table "ecol_customers", force: :cascade do |t|
    t.string   "code",                  limit: 15,                null: false
    t.string   "name",                  limit: 100,               null: false
    t.string   "is_enabled",            limit: 1,   default: "Y", null: false
    t.string   "val_method",            limit: 1,                 null: false
    t.string   "token_1_type",          limit: 3,   default: "N", null: false
    t.integer  "token_1_length",                    default: 0,   null: false
    t.string   "val_token_1",           limit: 1,   default: "N", null: false
    t.string   "token_2_type",          limit: 3,   default: "N", null: false
    t.integer  "token_2_length",                    default: 0,   null: false
    t.string   "val_token_2",           limit: 1,   default: "N", null: false
    t.string   "token_3_type",          limit: 3,   default: "N", null: false
    t.integer  "token_3_length",                    default: 0,   null: false
    t.string   "val_token_3",           limit: 1,   default: "N", null: false
    t.string   "val_txn_date",          limit: 1,   default: "N", null: false
    t.string   "val_txn_amt",           limit: 1,   default: "N", null: false
    t.string   "val_ben_name",          limit: 1,   default: "N", null: false
    t.string   "val_rem_acct",          limit: 1,   default: "N", null: false
    t.string   "return_if_val_reject",  limit: 1,   default: "N", null: false
    t.string   "file_upld_mthd",        limit: 1
    t.string   "credit_acct_val_pass",  limit: 25,                null: false
    t.string   "nrtv_sufx_1",           limit: 5,   default: "N", null: false
    t.string   "nrtv_sufx_2",           limit: 5,   default: "N", null: false
    t.string   "nrtv_sufx_3",           limit: 5,   default: "N", null: false
    t.string   "rmtr_alert_on",         limit: 1,   default: "N", null: false
    t.string   "rmtr_pass_txt",         limit: 500
    t.string   "rmtr_return_txt",       limit: 500
    t.string   "created_by",            limit: 20
    t.string   "updated_by",            limit: 20
    t.integer  "lock_version",                      default: 0,   null: false
    t.datetime "created_at",                                      null: false
    t.datetime "updated_at",                                      null: false
    t.string   "approval_status",       limit: 1,   default: "U", null: false
    t.string   "last_action",           limit: 1,   default: "C"
    t.integer  "approved_version"
    t.string   "auto_credit",           limit: 1,   default: "Y"
    t.string   "auto_return",           limit: 1,   default: "Y"
    t.integer  "approved_id"
    t.string   "val_last_token_length", limit: 1,   default: "N"
    t.string   "token_1_starts_with",   limit: 29
    t.string   "token_1_contains",      limit: 29
    t.string   "token_1_ends_with",     limit: 29
    t.string   "token_2_starts_with",   limit: 29
    t.string   "token_2_contains",      limit: 29
    t.string   "token_2_ends_with",     limit: 29
    t.string   "token_3_starts_with",   limit: 29
    t.string   "token_3_contains",      limit: 29
    t.string   "token_3_ends_with",     limit: 29
    t.string   "credit_acct_val_fail",  limit: 25
    t.string   "val_rmtr_name",         limit: 1,   default: "N"
    t.string   "cust_alert_on",         limit: 1,   default: "N", null: false
    t.string   "customer_id",           limit: 50,  default: "0", null: false
  end

  add_index "ecol_customers", ["code", "approval_status"], name: "customer_index_on_status", unique: true
  add_index "ecol_customers", ["code", "approval_status"], name: "index_ecol_customers_on_code_and_approval_status", unique: true

  create_table "ecol_fetch_statistics", force: :cascade do |t|
    t.datetime "last_neft_at",  null: false
    t.integer  "last_neft_id",  null: false
    t.integer  "last_neft_cnt", null: false
    t.integer  "tot_neft_cnt",  null: false
    t.datetime "last_rtgs_at",  null: false
    t.integer  "last_rtgs_id",  null: false
    t.integer  "last_rtgs_cnt", null: false
    t.integer  "tot_rtgs_cnt",  null: false
  end

  create_table "ecol_notifications", force: :cascade do |t|
    t.integer  "ecol_transaction_id"
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
    t.string   "broker_uuid",         limit: 500, null: false
    t.integer  "ecol_transaction_id",             null: false
    t.datetime "created_at",                      null: false
  end

  create_table "ecol_pending_notifications", force: :cascade do |t|
    t.string   "broker_uuid",         limit: 500
    t.integer  "ecol_transaction_id"
    t.datetime "created_at"
  end

  create_table "ecol_pending_returns", force: :cascade do |t|
    t.string   "broker_uuid",         limit: 500, null: false
    t.integer  "ecol_transaction_id",             null: false
    t.datetime "created_at",                      null: false
  end

  create_table "ecol_pending_settlements", force: :cascade do |t|
    t.string   "broker_uuid",         limit: 500, null: false
    t.integer  "ecol_transaction_id",             null: false
    t.datetime "created_at",                      null: false
  end

  create_table "ecol_pending_validations", force: :cascade do |t|
    t.string   "broker_uuid",         limit: 500, null: false
    t.integer  "ecol_transaction_id",             null: false
    t.datetime "created_at",                      null: false
  end

  create_table "ecol_remitters", force: :cascade do |t|
    t.integer  "incoming_file_id"
    t.string   "customer_code",           limit: 15,                         null: false
    t.string   "customer_subcode",        limit: 15
    t.string   "remitter_code",           limit: 28
    t.string   "credit_acct_no",          limit: 25
    t.string   "customer_subcode_email",  limit: 100
    t.string   "customer_subcode_mobile", limit: 10
    t.string   "rmtr_name",               limit: 100,                        null: false
    t.string   "rmtr_address",            limit: 105
    t.string   "rmtr_acct_no",            limit: 25
    t.string   "rmtr_email",              limit: 100
    t.string   "rmtr_mobile",             limit: 10
    t.string   "invoice_no",              limit: 28
    t.float    "invoice_amt",                                                null: false
    t.float    "invoice_amt_tol_pct"
    t.float    "min_credit_amt"
    t.float    "max_credit_amt"
    t.date     "due_date",                            default: '2015-01-01', null: false
    t.integer  "due_date_tol_days",                   default: 0
    t.string   "udf1",                    limit: 255
    t.string   "udf2",                    limit: 255
    t.string   "udf3",                    limit: 255
    t.string   "udf4",                    limit: 255
    t.string   "udf5",                    limit: 255
    t.string   "udf6",                    limit: 255
    t.string   "udf7",                    limit: 255
    t.string   "udf8",                    limit: 255
    t.string   "udf9",                    limit: 255
    t.string   "udf10",                   limit: 255
    t.string   "udf11",                   limit: 255
    t.string   "udf12",                   limit: 255
    t.string   "udf13",                   limit: 255
    t.string   "udf14",                   limit: 255
    t.string   "udf15",                   limit: 255
    t.string   "udf16",                   limit: 255
    t.string   "udf17",                   limit: 255
    t.string   "udf18",                   limit: 255
    t.string   "udf19",                   limit: 255
    t.string   "udf20",                   limit: 255
    t.string   "created_by",              limit: 20
    t.string   "updated_by",              limit: 20
    t.integer  "lock_version",                        default: 0,            null: false
    t.datetime "created_at",                                                 null: false
    t.datetime "updated_at",                                                 null: false
    t.string   "approval_status",         limit: 1,   default: "U",          null: false
    t.string   "last_action",             limit: 1,   default: "C"
    t.integer  "approved_version"
    t.integer  "approved_id"
  end

  add_index "ecol_remitters", ["customer_code", "customer_subcode", "remitter_code", "invoice_no", "approval_status"], name: "remitter_index_on_status", unique: true

  create_table "ecol_rules", force: :cascade do |t|
    t.string   "ifsc",             limit: 11,               null: false
    t.string   "cod_acct_no",      limit: 15,               null: false
    t.string   "stl_gl_inward",    limit: 15,               null: false
    t.string   "created_by",       limit: 20
    t.string   "updated_by",       limit: 20
    t.integer  "lock_version",                default: 0,   null: false
    t.datetime "created_at",                                null: false
    t.datetime "updated_at",                                null: false
    t.string   "approval_status",  limit: 1,  default: "U", null: false
    t.string   "last_action",      limit: 1,  default: "C"
    t.integer  "approved_version"
    t.integer  "approved_id"
    t.string   "neft_sender_ifsc", limit: 11,               null: false
    t.string   "customer_id",      limit: 50,               null: false
  end

  create_table "ecol_transactions", force: :cascade do |t|
    t.string   "status",                limit: 20,   default: "N", null: false
    t.string   "transfer_type",         limit: 4,                  null: false
    t.string   "transfer_unique_no",    limit: 64,                 null: false
    t.string   "transfer_status",       limit: 25,                 null: false
    t.date     "transfer_date",                                    null: false
    t.string   "transfer_ccy",          limit: 5,                  null: false
    t.float    "transfer_amt",                                     null: false
    t.string   "rmtr_ref",              limit: 64
    t.string   "rmtr_full_name",        limit: 255,                null: false
    t.string   "rmtr_address",          limit: 255
    t.string   "rmtr_account_type",     limit: 10
    t.string   "rmtr_account_no",       limit: 64,                 null: false
    t.string   "rmtr_account_ifsc",     limit: 20,                 null: false
    t.string   "bene_full_name",        limit: 255
    t.string   "bene_account_type",     limit: 10
    t.string   "bene_account_no",       limit: 64,                 null: false
    t.string   "bene_account_ifsc",     limit: 20,                 null: false
    t.string   "rmtr_to_bene_note",     limit: 255
    t.datetime "received_at",                                      null: false
    t.string   "customer_code",         limit: 15
    t.string   "customer_subcode",      limit: 15
    t.string   "remitter_code",         limit: 28
    t.datetime "validated_at"
    t.string   "validation_status",     limit: 50
    t.datetime "credited_at"
    t.string   "credit_ref",            limit: 64
    t.integer  "credit_attempt_no"
    t.string   "rmtr_email_notify_ref", limit: 64
    t.string   "rmtr_sms_notify_ref",   limit: 64
    t.datetime "settled_at"
    t.string   "settle_status",         limit: 50
    t.string   "settle_ref",            limit: 64
    t.integer  "settle_attempt_no"
    t.datetime "fault_at"
    t.string   "fault_code",            limit: 50
    t.string   "fault_reason",          limit: 1000
    t.datetime "created_at",                                       null: false
    t.datetime "updated_at",                                       null: false
    t.string   "invoice_no",            limit: 28
    t.datetime "validate_attempt_at"
    t.datetime "credit_attempt_at"
    t.datetime "returned_at"
    t.string   "return_ref",            limit: 64
    t.datetime "return_attempt_at"
    t.integer  "return_attempt_no",     limit: 8
    t.datetime "settle_attempt_at"
    t.string   "bene_full_address",     limit: 255
    t.string   "validation_result",     limit: 1000
    t.string   "credit_acct_no",        limit: 25
    t.string   "settle_result",         limit: 1000
    t.integer  "ecol_remitter_id"
    t.string   "pending_approval",      limit: 1,    default: "Y"
    t.integer  "notify_attempt_no",     limit: 8
    t.datetime "notify_attempt_at"
    t.datetime "notified_at"
    t.string   "notify_status",         limit: 50
    t.string   "notify_result",         limit: 1000
    t.integer  "validate_attempt_no"
    t.string   "return_req_ref",        limit: 64
    t.string   "settle_req_ref",        limit: 64
    t.string   "credit_req_ref",        limit: 64
  end

  add_index "ecol_transactions", ["transfer_type", "transfer_unique_no"], name: "ecol_transaction_unique_index", unique: true

  create_table "ecol_unapproved_records", force: :cascade do |t|
    t.integer  "ecol_approvable_id"
    t.string   "ecol_approvable_type"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  create_table "ecol_validations", force: :cascade do |t|
    t.integer  "ecol_transaction_id"
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

  create_table "groups", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "incoming_file_records", force: :cascade do |t|
    t.integer  "incoming_file_id"
    t.integer  "record_no"
    t.text     "record_txt"
    t.string   "status",           limit: 20
    t.string   "fault_code",       limit: 50
    t.string   "fault_reason",     limit: 500
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
  end

  create_table "incoming_file_types", force: :cascade do |t|
    t.integer "sc_service_id",            null: false
    t.string  "code",          limit: 50, null: false
    t.string  "name",          limit: 50, null: false
  end

  add_index "incoming_file_types", ["code"], name: "index_incoming_file_types_on_code", unique: true
  add_index "incoming_file_types", ["name"], name: "index_incoming_file_types_on_name", unique: true
  add_index "incoming_file_types", ["sc_service_id"], name: "index_incoming_file_types_on_sc_service_id", unique: true

  create_table "incoming_files", force: :cascade do |t|
    t.string   "service_name",     limit: 10
    t.string   "file_type",        limit: 10
    t.string   "file"
    t.string   "file_name",        limit: 50
    t.integer  "size_in_bytes"
    t.integer  "line_count"
    t.string   "status",           limit: 1
    t.date     "started_at"
    t.date     "ended_at"
    t.string   "created_by",       limit: 20
    t.string   "updated_by",       limit: 20
    t.datetime "created_at",                                 null: false
    t.datetime "updated_at",                                 null: false
    t.string   "fault_code",       limit: 50
    t.string   "fault_reason",     limit: 500
    t.string   "approval_status",  limit: 1,   default: "U", null: false
    t.string   "last_action",      limit: 1,   default: "C"
    t.integer  "approved_version"
    t.integer  "approved_id"
    t.integer  "lock_version"
  end

  create_table "inw_audit_logs", force: :cascade do |t|
    t.integer "inward_remittance_id"
    t.text    "request_bitstream"
    t.text    "reply_bitstream"
  end

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

  create_table "inw_identities", force: :cascade do |t|
    t.string  "id_for",                  limit: 20, null: false
    t.string  "id_type",                 limit: 20
    t.string  "id_number",               limit: 50
    t.string  "id_country"
    t.date    "id_issue_date"
    t.date    "id_expiry_date"
    t.date    "verified_at"
    t.string  "verified_by",             limit: 20
    t.integer "inw_remittance_id"
    t.integer "whitelisted_identity_id"
    t.string  "was_auto_matched"
  end

  create_table "inw_remittance_rules", force: :cascade do |t|
    t.string   "pattern_individuals",   limit: 4000
    t.string   "pattern_corporates",    limit: 4000
    t.string   "pattern_beneficiaries", limit: 4000
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "created_by"
    t.string   "updated_by"
    t.integer  "lock_version",                       default: 0,   null: false
    t.string   "pattern_salutations",   limit: 2000
    t.string   "pattern_remitters",     limit: 4000
    t.string   "approval_status",       limit: 1,    default: "U", null: false
    t.string   "last_action",           limit: 1,    default: "C"
    t.integer  "approved_version"
    t.integer  "approved_id"
  end

  create_table "inw_unapproved_records", force: :cascade do |t|
    t.integer  "inw_approvable_id"
    t.string   "inw_approvable_type"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
  end

  create_table "inward_remittances", force: :cascade do |t|
    t.string   "req_no",                              null: false
    t.string   "req_version",            limit: 10,   null: false
    t.datetime "req_timestamp",                       null: false
    t.string   "partner_code",           limit: 20,   null: false
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
    t.integer  "rmtr_identity_count",                 null: false
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
    t.integer  "bene_identity_count",                 null: false
    t.string   "bene_account_no"
    t.string   "bene_account_ifsc"
    t.string   "transfer_type",          limit: 4
    t.string   "transfer_ccy",           limit: 5
    t.float    "transfer_amount"
    t.string   "rmtr_to_bene_note"
    t.string   "purpose_code",           limit: 5
    t.string   "status_code",            limit: 25
    t.string   "bank_ref",               limit: 30
    t.string   "rep_no"
    t.string   "rep_version",            limit: 10
    t.datetime "rep_timestamp"
    t.integer  "attempt_no",                          null: false
    t.datetime "updated_at"
    t.string   "beneficiary_type",       limit: 1
    t.string   "remitter_type",          limit: 1
    t.string   "fault_code",             limit: 50
    t.string   "fault_reason",           limit: 1000
    t.string   "is_self_transfer",       limit: 1
    t.string   "is_same_party_transfer", limit: 1
    t.string   "req_transfer_type",      limit: 4
    t.float    "bal_available"
    t.string   "service_id"
    t.date     "reconciled_at"
    t.string   "cbs_req_ref_no"
  end

  add_index "inward_remittances", ["req_no", "partner_code", "attempt_no"], name: "remittance_unique_index", unique: true

  create_table "inward_remittances_locks", id: false, force: :cascade do |t|
    t.integer "inward_remittance_id"
    t.string  "created_at"
  end

  create_table "partners", force: :cascade do |t|
    t.string   "code",                      limit: 10,               null: false
    t.string   "name",                      limit: 60,               null: false
    t.string   "tech_email_id"
    t.string   "ops_email_id"
    t.string   "account_no",                limit: 20,               null: false
    t.string   "account_ifsc",              limit: 20
    t.integer  "txn_hold_period_days",                 default: 7,   null: false
    t.string   "identity_user_id",          limit: 20,               null: false
    t.float    "low_balance_alert_at"
    t.string   "remitter_sms_allowed",      limit: 1
    t.string   "remitter_email_allowed",    limit: 1
    t.string   "beneficiary_sms_allowed",   limit: 1
    t.string   "beneficiary_email_allowed", limit: 1
    t.string   "allow_neft",                limit: 1
    t.string   "allow_rtgs",                limit: 1
    t.string   "allow_imps",                limit: 1
    t.string   "created_by",                limit: 20
    t.string   "updated_by",                limit: 20
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "lock_version",                         default: 0,   null: false
    t.string   "enabled",                   limit: 1
    t.string   "customer_id",               limit: 15
    t.string   "mmid",                      limit: 7
    t.string   "mobile_no",                 limit: 10
    t.string   "country"
    t.string   "address_line1"
    t.string   "address_line2"
    t.string   "address_line3"
    t.string   "approval_status",           limit: 1,  default: "U", null: false
    t.string   "last_action",               limit: 1,  default: "C"
    t.integer  "approved_version"
    t.integer  "approved_id"
  end

  create_table "pending_inward_remittances", force: :cascade do |t|
    t.integer  "inward_remittance_id", limit: 30,  null: false
    t.string   "broker_uuid",          limit: 255, null: false
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
  end

  add_index "pending_inward_remittances", ["inward_remittance_id"], name: "index_pending_inward_remittances_on_inward_remittance_id", unique: true

  create_table "purpose_codes", force: :cascade do |t|
    t.string   "code",                  limit: 4
    t.string   "description",           limit: 255
    t.string   "is_enabled",            limit: 1
    t.string   "created_by",            limit: 20
    t.string   "updated_by",            limit: 20
    t.integer  "lock_version",                       default: 0,   null: false
    t.float    "txn_limit"
    t.integer  "daily_txn_limit"
    t.string   "disallowed_rem_types",  limit: 30
    t.string   "disallowed_bene_types", limit: 30
    t.datetime "created_at"
    t.datetime "updated_at"
    t.float    "mtd_txn_cnt_self"
    t.float    "mtd_txn_limit_self"
    t.float    "mtd_txn_cnt_sp"
    t.float    "mtd_txn_limit_sp"
    t.string   "rbi_code",              limit: 5
    t.string   "pattern_beneficiaries", limit: 4000
    t.string   "approval_status",       limit: 1,    default: "U", null: false
    t.string   "last_action",           limit: 1,    default: "C"
    t.integer  "approved_version"
    t.integer  "approved_id"
  end

  create_table "remittance_reviews", force: :cascade do |t|
    t.string   "transaction_id",     limit: 5,    null: false
    t.string   "justification_code", limit: 5,    null: false
    t.string   "justification_text", limit: 2000
    t.string   "review_status",      limit: 10,   null: false
    t.date     "reviewed_at"
    t.string   "review_remarks",     limit: 2000
    t.string   "reviewed_by",        limit: 50
    t.string   "created_by",         limit: 20
    t.string   "updated_by",         limit: 20
    t.integer  "lock_version"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "roles", force: :cascade do |t|
    t.string   "name"
    t.integer  "resource_id"
    t.string   "resource_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "roles", ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id"
  add_index "roles", ["name"], name: "index_roles_on_name"

  create_table "sc_services", force: :cascade do |t|
    t.string "code", limit: 50, null: false
    t.string "name", limit: 50, null: false
  end

  add_index "sc_services", ["code"], name: "index_sc_services_on_code", unique: true
  add_index "sc_services", ["name"], name: "index_sc_services_on_name", unique: true

  create_table "udf_attributes", force: :cascade do |t|
    t.string   "class_name",       limit: 100,               null: false
    t.string   "attribute_name",   limit: 100,               null: false
    t.string   "label_text",       limit: 100
    t.string   "is_enabled",       limit: 1,   default: "Y", null: false
    t.string   "is_mandatory",     limit: 1,   default: "N"
    t.string   "control_type",     limit: 255
    t.string   "data_type",        limit: 255
    t.datetime "created_at",                                 null: false
    t.datetime "updated_at",                                 null: false
    t.integer  "lock_version",                 default: 0,   null: false
    t.string   "approval_status",  limit: 1,   default: "U", null: false
    t.string   "last_action",      limit: 1,   default: "C"
    t.integer  "approved_version"
    t.integer  "approved_id"
    t.text     "constraints"
    t.text     "select_options"
    t.string   "created_by",       limit: 20
    t.string   "updated_by",       limit: 20
  end

  add_index "udf_attributes", ["class_name", "attribute_name", "approval_status"], name: "udf_attribute_index_on_status", unique: true

  create_table "user_groups", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "group_id"
    t.integer  "lock_version",                default: 0,   null: false
    t.string   "approval_status",  limit: 1,  default: "U", null: false
    t.string   "last_action",      limit: 1,  default: "C"
    t.integer  "approved_version"
    t.integer  "approved_id"
    t.string   "created_by",       limit: 20
    t.string   "updated_by",       limit: 20
    t.boolean  "disabled"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_roles", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "role_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "lock_version",                default: 0,   null: false
    t.string   "approval_status",  limit: 1,  default: "U", null: false
    t.string   "last_action",      limit: 1,  default: "C"
    t.integer  "approved_version"
    t.integer  "approved_id"
    t.string   "created_by",       limit: 20
    t.string   "updated_by",       limit: 20
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                             default: "",    null: false
    t.string   "encrypted_password",                default: ""
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                     default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "username"
    t.boolean  "inactive",                          default: false
    t.string   "first_name"
    t.string   "last_name"
    t.string   "unique_session_id",      limit: 20
    t.string   "mobile_no"
    t.integer  "role_id"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true

  create_table "users_groups", id: false, force: :cascade do |t|
    t.integer "user_id"
    t.integer "group_id"
  end

  create_table "users_roles", id: false, force: :cascade do |t|
    t.integer "user_id"
    t.integer "role_id"
  end

  add_index "users_roles", ["user_id", "role_id"], name: "index_users_roles_on_user_id_and_role_id"

  create_table "whitelisted_identities", force: :cascade do |t|
    t.integer  "partner_id",                                      null: false
    t.string   "full_name",              limit: 50
    t.string   "first_name",             limit: 50
    t.string   "last_name",              limit: 50
    t.string   "id_type",                limit: 20
    t.string   "id_number",              limit: 50
    t.string   "id_country"
    t.date     "id_issue_date"
    t.date     "id_expiry_date"
    t.string   "is_verified",            limit: 1
    t.date     "verified_at"
    t.string   "verified_by",            limit: 20
    t.integer  "first_used_with_txn_id"
    t.integer  "last_used_with_txn_id"
    t.integer  "times_used"
    t.string   "created_by",             limit: 20
    t.string   "updated_by",             limit: 20
    t.integer  "lock_version"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "approval_status",        limit: 1,  default: "U", null: false
    t.string   "last_action",            limit: 1,  default: "C"
    t.integer  "approved_version"
    t.integer  "approved_id"
  end

  add_index "whitelisted_identities", ["last_used_with_txn_id"], name: "index_whitelisted_identities_on_last_used_with_txn_id"

end
