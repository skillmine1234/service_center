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

ActiveRecord::Schema.define(version: 20161012074608) do

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
  add_index "bm_add_biller_accts", ["biller_acct_no", "customer_id", "status_code"], name: "idx_by_ban_cid_sc"

  create_table "bm_aggregator_payments", force: :cascade do |t|
    t.string   "cod_acct_no",       limit: 50,                   null: false
    t.string   "neft_sender_ifsc",                               null: false
    t.string   "bene_acct_no",      limit: 50,                   null: false
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
    t.string   "pending_approval",  limit: 1,    default: "N",   null: false
    t.string   "bene_acct_ifsc",    limit: 255,  default: "1",   null: false
    t.string   "rmtr_to_bene_note", limit: 255
    t.string   "is_reconciled",     limit: 1,    default: "Y",   null: false
    t.date     "reconciled_at"
    t.date     "neft_attempt_at"
    t.string   "customer_id",       limit: 50,   default: " ",   null: false
    t.string   "rmtr_name",         limit: 50,   default: "",    null: false
    t.string   "service_id",        limit: 255
    t.string   "bene_name",         limit: 255
    t.string   "created_by",        limit: 20
    t.string   "updated_by",        limit: 20
    t.decimal  "payment_amount"
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
    t.string   "needs_otp",        limit: 1,  default: "N", null: false
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
    t.decimal  "txn_amount",                                     null: false
  end

  add_index "bm_bill_payments", ["app_id", "req_no", "attempt_no"], name: "attepmt_index_bill_payments", unique: true
  add_index "bm_bill_payments", ["billpay_rep_ref"], name: "uk_billpay_rep_ref", unique: true

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
    t.string   "status_code",         limit: 50,   null: false
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
    t.string   "status_code",         limit: 50,   null: false
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
    t.string   "cod_acct_no",       limit: 16,                 null: false
    t.string   "customer_id",       limit: 15,                 null: false
    t.string   "bene_acct_no",                                 null: false
    t.string   "bene_account_ifsc",                            null: false
    t.string   "neft_sender_ifsc",                             null: false
    t.integer  "lock_version",                                 null: false
    t.datetime "created_at",                                   null: false
    t.datetime "updated_at",                                   null: false
    t.string   "approval_status",   limit: 1,   default: "U",  null: false
    t.string   "last_action",       limit: 1,   default: "C"
    t.integer  "approved_version"
    t.integer  "approved_id"
    t.string   "created_by",        limit: 20
    t.string   "updated_by",        limit: 20
    t.string   "source_id",         limit: 50,  default: "qg", null: false
    t.integer  "traceid_prefix",                default: 1,    null: false
    t.string   "service_id",        limit: 255
  end

  create_table "bm_unapproved_records", force: :cascade do |t|
    t.integer  "bm_approvable_id"
    t.string   "bm_approvable_type"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

  create_table "bms_add_beneficiaries", force: :cascade do |t|
    t.string   "req_version",                   null: false
    t.string   "req_no",                        null: false
    t.integer  "attempt_no",                    null: false
    t.string   "status_code",      limit: 25,   null: false
    t.datetime "req_timestamp"
    t.string   "app_id",                        null: false
    t.string   "customer_id",                   null: false
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
    t.string   "fault_code",       limit: 255
    t.string   "fault_reason",     limit: 1000
  end

  add_index "bms_add_beneficiaries", ["req_no", "app_id", "attempt_no"], name: "uk_bms_add_beneficiaries_1", unique: true

  create_table "bms_audit_logs", force: :cascade do |t|
    t.string   "req_no",             limit: 32,   null: false
    t.string   "app_id",             limit: 32,   null: false
    t.integer  "attempt_no",                      null: false
    t.string   "status_code",        limit: 25,   null: false
    t.string   "bms_auditable_type", limit: 255,  null: false
    t.integer  "bms_auditable_id",                null: false
    t.string   "fault_code",         limit: 255
    t.string   "fault_reason",       limit: 1000
    t.datetime "req_timestamp"
    t.datetime "rep_timestamp"
    t.text     "req_bitstream",                   null: false
    t.text     "rep_bitstream"
    t.text     "fault_bitstream"
  end

  add_index "bms_audit_logs", ["app_id", "req_no", "attempt_no"], name: "uk_bms_audit_logs_1", unique: true
  add_index "bms_audit_logs", ["bms_auditable_type", "bms_auditable_id"], name: "uk_bms_audit_logs_2", unique: true

  create_table "bms_del_beneficiaries", force: :cascade do |t|
    t.string   "req_version",                null: false
    t.string   "req_no",                     null: false
    t.integer  "attempt_no",                 null: false
    t.string   "status_code",   limit: 25,   null: false
    t.datetime "req_timestamp"
    t.string   "app_id",                     null: false
    t.string   "customer_id",                null: false
    t.string   "bene_id"
    t.string   "otp_key"
    t.string   "otp_value"
    t.string   "rep_version"
    t.string   "rep_no"
    t.datetime "rep_timestamp"
    t.string   "fault_code",    limit: 255
    t.string   "fault_reason",  limit: 1000
  end

  add_index "bms_del_beneficiaries", ["req_no", "app_id", "attempt_no"], name: "uk_bms_del_beneficiaries_1", unique: true

  create_table "bms_mod_beneficiaries", force: :cascade do |t|
    t.string   "req_version",                   null: false
    t.string   "req_no",                        null: false
    t.integer  "attempt_no",                    null: false
    t.string   "status_code",      limit: 25,   null: false
    t.datetime "req_timestamp"
    t.string   "app_id",                        null: false
    t.string   "customer_id",                   null: false
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
    t.string   "fault_code",       limit: 255
    t.string   "fault_reason",     limit: 1000
  end

  add_index "bms_mod_beneficiaries", ["req_no", "app_id", "attempt_no"], name: "uk_bms_mod_beneficiaries_1", unique: true

  create_table "cn_incoming_files", force: :cascade do |t|
    t.string "file_name",       limit: 50
    t.string "batch_no",        limit: 20
    t.string "rej_file_name",   limit: 50
    t.string "rej_file_path",   limit: 255
    t.string "rej_file_status", limit: 255
    t.string "cnb_file_name",   limit: 50
    t.string "cnb_file_path",   limit: 255
    t.string "cnb_file_status", limit: 50
  end

  add_index "cn_incoming_files", ["file_name"], name: "cn_incoming_files_01", unique: true

  create_table "cn_incoming_records", force: :cascade do |t|
    t.integer  "incoming_file_record_id"
    t.string   "file_name",               limit: 50
    t.string   "message_type",            limit: 3
    t.string   "debit_account_no",        limit: 20
    t.string   "rmtr_name",               limit: 50
    t.string   "rmtr_address1"
    t.string   "rmtr_address2"
    t.string   "rmtr_address3"
    t.string   "rmtr_address4"
    t.string   "bene_ifsc_code",          limit: 50
    t.string   "bene_account_no",         limit: 34
    t.string   "bene_name"
    t.string   "bene_add_line1"
    t.string   "bene_add_line2"
    t.string   "bene_add_line3"
    t.string   "bene_add_line4"
    t.string   "transaction_ref_no",      limit: 50
    t.datetime "upload_date"
    t.decimal  "amount"
    t.string   "rmtr_to_bene_note"
    t.string   "add_info1",               limit: 50
    t.string   "add_info2",               limit: 50
    t.string   "add_info3",               limit: 50
    t.string   "add_info4",               limit: 50
  end

  add_index "cn_incoming_records", ["incoming_file_record_id", "file_name"], name: "cn_incoming_records_01", unique: true

  create_table "cn_unapproved_records", force: :cascade do |t|
    t.integer  "cn_approvable_id"
    t.string   "cn_approvable_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "csv_exports", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "state"
    t.string   "request_type"
    t.string   "path"
    t.string   "group"
    t.datetime "executed_at"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
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
    t.text     "req_header"
    t.text     "rep_header"
    t.string   "req_uri",             limit: 500
    t.string   "remote_host",         limit: 500
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
<<<<<<< HEAD
    t.string   "val_rmtr_name",         limit: 1
    t.string   "val_last_token_length", limit: 1
    t.string   "cust_alert_on",         limit: 1,                  default: "f", null: false
    t.string   "customer_id",           limit: 50,                 default: "0", null: false
    t.string   "app_code",              limit: 15
    t.string   "identity_user_id"
    t.string   "pool_acct_no",          limit: 20
=======
    t.string   "credit_acct_val_fail",  limit: 25
    t.string   "val_rmtr_name",         limit: 1,   default: "N"
    t.string   "cust_alert_on",         limit: 1,   default: "N", null: false
    t.string   "customer_id",           limit: 50,  default: "0", null: false
    t.string   "pool_acct_no",          limit: 25
    t.string   "app_code",              limit: 15
    t.string   "identity_user_id",      limit: 20
>>>>>>> 9556896aea59111e5755a8b5c758c8a6c7d5d9bb
  end

  add_index "ecol_customers", ["code", "approval_status"], name: "customer_index_on_status", unique: true

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
    t.decimal  "invoice_amt",                                                null: false
    t.decimal  "invoice_amt_tol_pct"
    t.decimal  "min_credit_amt"
    t.decimal  "max_credit_amt"
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
    t.string   "ifsc",              limit: 11,               null: false
    t.string   "cod_acct_no",       limit: 15,               null: false
    t.string   "stl_gl_inward",     limit: 15,               null: false
    t.string   "created_by",        limit: 20
    t.string   "updated_by",        limit: 20
    t.integer  "lock_version",                 default: 0,   null: false
    t.datetime "created_at",                                 null: false
    t.datetime "updated_at",                                 null: false
    t.string   "approval_status",   limit: 1,  default: "U", null: false
    t.string   "last_action",       limit: 1,  default: "C"
    t.integer  "approved_version"
    t.integer  "approved_id"
    t.string   "neft_sender_ifsc",  limit: 11,               null: false
    t.string   "customer_id",       limit: 50,               null: false
    t.string   "return_account_no", limit: 20
  end

  create_table "ecol_transactions", force: :cascade do |t|
    t.string   "status",                limit: 20,   default: "N", null: false
    t.string   "transfer_type",         limit: 4,                  null: false
    t.string   "transfer_unique_no",    limit: 64,                 null: false
    t.string   "transfer_status",       limit: 25,                 null: false
    t.datetime "transfer_timestamp",                               null: false
    t.string   "transfer_ccy",          limit: 5,                  null: false
    t.decimal  "transfer_amt",                                     null: false
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
    t.string   "validation_ref",        limit: 50
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

  create_table "fm_audit_steps", force: :cascade do |t|
    t.string   "auditable_type",               null: false
    t.integer  "auditable_id",                 null: false
    t.integer  "step_no",                      null: false
    t.integer  "attempt_no",                   null: false
    t.string   "step_name",       limit: 100,  null: false
    t.string   "status_code",     limit: 25
    t.string   "fault_code",      limit: 50
    t.string   "fault_subcode",   limit: 50
    t.string   "fault_reason",    limit: 1000
    t.string   "req_reference",   limit: 255
    t.datetime "req_timestamp"
    t.string   "rep_reference"
    t.datetime "rep_timestamp"
    t.datetime "reconciled_at"
    t.text     "req_bitstream"
    t.text     "rep_bitstream"
    t.text     "fault_bitstream"
  end

  add_index "fm_audit_steps", ["auditable_type", "auditable_id", "step_no", "attempt_no"], name: "uk_fm_audit_steps", unique: true

  create_table "fp_auth_rules", force: :cascade do |t|
    t.string   "username",         limit: 255,                null: false
    t.string   "operation_name",   limit: 4000,               null: false
    t.string   "is_enabled",       limit: 1,    default: "N", null: false
    t.integer  "lock_version",                                null: false
    t.string   "approval_status",  limit: 1,    default: "U", null: false
    t.string   "last_action",      limit: 1
    t.integer  "approved_version"
    t.integer  "approved_id"
    t.string   "created_by",       limit: 20
    t.string   "updated_by",       limit: 20
    t.datetime "created_at",                                  null: false
    t.datetime "updated_at",                                  null: false
    t.string   "source_ips",       limit: 4000
    t.string   "any_source_ip",    limit: 1,    default: "N", null: false
  end

  add_index "fp_auth_rules", ["username", "approval_status"], name: "uk_fp_auth_rules", unique: true

  create_table "fp_operations", force: :cascade do |t|
    t.string   "operation_name",   limit: 255,               null: false
    t.integer  "lock_version",                               null: false
    t.string   "approval_status",  limit: 1,   default: "U", null: false
    t.string   "last_action",      limit: 1
    t.integer  "approved_version"
    t.integer  "approved_id"
    t.string   "created_by",       limit: 20
    t.string   "updated_by",       limit: 20
    t.datetime "created_at",                                 null: false
    t.datetime "updated_at",                                 null: false
  end

  add_index "fp_operations", ["operation_name", "approval_status"], name: "index_fp_operations_on_operation_name_and_approval_status", unique: true

  create_table "fp_unapproved_records", force: :cascade do |t|
    t.integer  "fp_approvable_id"
    t.string   "fp_approvable_type"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

  create_table "ft_audit_steps", force: :cascade do |t|
    t.string   "ft_auditable_type",              null: false
    t.integer  "ft_auditable_id",                null: false
    t.integer  "step_no",                        null: false
    t.integer  "attempt_no",                     null: false
    t.string   "step_name",         limit: 100,  null: false
    t.string   "status_code",       limit: 25,   null: false
    t.string   "fault_code",        limit: 255
    t.string   "fault_subcode",     limit: 50
    t.string   "fault_reason",      limit: 1000
    t.string   "req_reference",     limit: 255
    t.datetime "req_timestamp"
    t.string   "rep_reference"
    t.datetime "rep_timestamp"
    t.text     "req_bitstream"
    t.text     "rep_bitstream"
    t.text     "fault_bitstream"
  end

  add_index "ft_audit_steps", ["ft_auditable_type", "ft_auditable_id", "step_no", "attempt_no"], name: "uk_ft_audit_steps", unique: true

  create_table "ft_cust_accounts", force: :cascade do |t|
    t.string   "customer_id",      limit: 15,               null: false
    t.string   "account_no",       limit: 20,               null: false
    t.string   "is_enabled",       limit: 1,                null: false
    t.datetime "created_at",                                null: false
    t.datetime "updated_at",                                null: false
    t.string   "created_by",       limit: 20
    t.string   "updated_by",       limit: 20
    t.integer  "lock_version",                default: 0,   null: false
    t.string   "approval_status",  limit: 1,  default: "U", null: false
    t.string   "last_action",      limit: 1,  default: "C", null: false
    t.integer  "approved_version"
    t.integer  "approved_id"
  end

  add_index "ft_cust_accounts", ["customer_id", "account_no", "approval_status"], name: "ft_cust_accounts_01", unique: true

  create_table "ft_customers", force: :cascade do |t|
    t.string   "app_id",               limit: 20,                null: false
    t.string   "name",                 limit: 100,               null: false
    t.integer  "low_balance_alert_at",                           null: false
    t.string   "identity_user_id",                               null: false
    t.string   "allow_neft",           limit: 1,                 null: false
    t.string   "allow_imps",           limit: 1,                 null: false
    t.string   "allow_rtgs",           limit: 1
    t.string   "string",               limit: 15
    t.string   "enabled",              limit: 1,   default: "N", null: false
    t.string   "is_retail",            limit: 1
    t.string   "customer_id",          limit: 15
    t.string   "created_by",           limit: 20
    t.string   "updated_by",           limit: 20
    t.datetime "created_at",                                     null: false
    t.datetime "updated_at",                                     null: false
    t.integer  "lock_version",                     default: 0,   null: false
    t.string   "approval_status",      limit: 1,   default: "U", null: false
    t.string   "last_action",          limit: 1,   default: "C", null: false
    t.integer  "approved_version"
    t.integer  "approved_id"
    t.string   "needs_purpose_code",   limit: 1
    t.string   "reply_with_bene_name", limit: 1,   default: "N"
    t.string   "allow_all_accounts",   limit: 1,   default: "Y", null: false
  end

  add_index "ft_customers", ["app_id", "customer_id", "approval_status"], name: "in_ft_customers_2", unique: true
  add_index "ft_customers", ["name"], name: "in_ft_customers_1"

  create_table "ft_incoming_files", force: :cascade do |t|
    t.string "file_name",     limit: 50
    t.string "customer_code", limit: 15
  end

  add_index "ft_incoming_files", ["file_name"], name: "ft_incoming_files_01", unique: true

  create_table "ft_incoming_records", force: :cascade do |t|
    t.integer "incoming_file_record_id"
    t.string  "file_name",               limit: 50
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
    t.string  "rmtr_to_bene_note",       limit: 255
    t.string  "rep_version",             limit: 10
    t.string  "rep_no",                  limit: 50
    t.integer "rep_attempt_no"
    t.string  "transfer_type",           limit: 4
    t.string  "low_balance_alert"
    t.string  "txn_status_code",         limit: 50
    t.string  "txn_status_subcode",      limit: 50
    t.string  "bank_ref_no",             limit: 50
    t.string  "bene_ref_no",             limit: 50
    t.string  "name_with_bene_bank",     limit: 255
  end

  add_index "ft_incoming_records", ["incoming_file_record_id"], name: "ft_incoming_records_01", unique: true

  create_table "ft_purpose_codes", force: :cascade do |t|
    t.string   "code",                       limit: 20,                null: false
    t.string   "description",                limit: 100
    t.string   "is_enabled",                 limit: 1
    t.string   "allow_only_registered_bene", limit: 1
    t.string   "created_by",                 limit: 20
    t.string   "updated_by",                 limit: 20
    t.datetime "created_at",                                           null: false
    t.datetime "updated_at",                                           null: false
    t.integer  "lock_version",                           default: 0,   null: false
    t.string   "approval_status",            limit: 1,   default: "U", null: false
    t.string   "last_action",                limit: 1,   default: "C", null: false
    t.integer  "approved_version"
    t.integer  "approved_id"
  end

  add_index "ft_purpose_codes", ["code", "approval_status"], name: "uk_ft_purpose_codes", unique: true

  create_table "ft_unapproved_records", force: :cascade do |t|
    t.integer  "ft_approvable_id"
    t.string   "ft_approvable_type"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

  create_table "groups", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "ic_audit_logs", force: :cascade do |t|
    t.string   "req_no",            limit: 32,   null: false
    t.string   "app_id",            limit: 32,   null: false
    t.integer  "attempt_no",                     null: false
    t.string   "status_code",       limit: 25,   null: false
    t.string   "ic_auditable_type", limit: 255,  null: false
    t.integer  "ic_auditable_id",                null: false
    t.string   "fault_code",        limit: 255
    t.string   "fault_subcode",     limit: 50
    t.string   "fault_reason",      limit: 1000
    t.datetime "req_timestamp"
    t.datetime "rep_timestamp"
    t.text     "req_bitstream",                  null: false
    t.text     "rep_bitstream"
    t.text     "fault_bitstream"
  end

  add_index "ic_audit_logs", ["app_id", "req_no", "attempt_no"], name: "uk_ic_audit_logs_1", unique: true
  add_index "ic_audit_logs", ["ic_auditable_type", "ic_auditable_id"], name: "uk_ic_audit_logs_2", unique: true

  create_table "ic_audit_steps", force: :cascade do |t|
    t.string   "ic_auditable_type",              null: false
    t.integer  "ic_auditable_id",                null: false
    t.integer  "step_no",                        null: false
    t.integer  "attempt_no",                     null: false
    t.string   "step_name",         limit: 100,  null: false
    t.string   "status_code",       limit: 25,   null: false
    t.string   "fault_code",        limit: 255
    t.string   "fault_subcode",     limit: 50
    t.string   "fault_reason",      limit: 1000
    t.string   "req_reference",     limit: 255
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
    t.string   "customer_id",         limit: 15,                                        null: false
    t.string   "app_id",              limit: 20,                                        null: false
    t.string   "identity_user_id",    limit: 20
    t.string   "repay_account_no",    limit: 20,                                        null: false
    t.decimal  "fee_pct",                         precision: 5, scale: 2,               null: false
    t.string   "fee_income_gl",       limit: 20,                                        null: false
    t.decimal  "max_overdue_pct",                 precision: 5, scale: 2,               null: false
    t.string   "cust_contact_email",  limit: 100
    t.string   "cust_contact_mobile", limit: 10
    t.string   "ops_email",           limit: 100
    t.string   "rm_email",            limit: 100
    t.string   "is_enabled",          limit: 1,                                         null: false
    t.string   "created_by",          limit: 20
    t.string   "updated_by",          limit: 20
    t.datetime "created_at",                                                            null: false
    t.datetime "updated_at",                                                            null: false
    t.integer  "lock_version",                                            default: 0,   null: false
    t.string   "approval_status",     limit: 1,                           default: "U", null: false
    t.string   "last_action",         limit: 1,                           default: "C", null: false
    t.integer  "approved_version"
    t.integer  "approved_id"
    t.string   "customer_name",       limit: 100
  end

  add_index "ic_customers", ["app_id", "approval_status"], name: "i_ic_cust_app_id", unique: true
  add_index "ic_customers", ["customer_id", "approval_status"], name: "i_ic_cust_cust_id", unique: true
  add_index "ic_customers", ["identity_user_id", "approval_status"], name: "i_ic_cust_identity_id", unique: true
  add_index "ic_customers", ["repay_account_no", "approval_status"], name: "i_ic_cust_repay_no", unique: true

  create_table "ic_incoming_files", force: :cascade do |t|
    t.string "file_name",        limit: 50
    t.string "corp_customer_id", limit: 15
    t.string "pm_utr",           limit: 64
  end

  add_index "ic_incoming_files", ["file_name"], name: "ic_file_index", unique: true

  create_table "ic_incoming_records", force: :cascade do |t|
    t.integer "incoming_file_record_id",            null: false
    t.string  "supplier_code",           limit: 15
    t.string  "invoice_no",              limit: 28
    t.date    "invoice_date"
    t.date    "invoice_due_date"
    t.decimal "invoice_amount"
    t.string  "debit_ref_no",            limit: 64
    t.string  "corp_customer_id",        limit: 15
    t.string  "pm_utr",                  limit: 64
    t.string  "file_name",               limit: 50, null: false
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
    t.string   "req_no",                limit: 255,  null: false
    t.integer  "attempt_no",                         null: false
    t.string   "status_code",           limit: 50,   null: false
    t.string   "req_version",           limit: 20,   null: false
    t.datetime "req_timestamp",                      null: false
    t.string   "app_id",                limit: 20,   null: false
    t.string   "customer_id",           limit: 50,   null: false
    t.string   "supplier_code",         limit: 50,   null: false
    t.string   "invoice_no",            limit: 50,   null: false
    t.datetime "invoice_date",                       null: false
    t.datetime "invoice_due_date",                   null: false
    t.decimal  "invoice_amount",                     null: false
    t.decimal  "discounted_amount",                  null: false
    t.decimal  "fee_amount",                         null: false
    t.string   "rep_no",                limit: 255
    t.string   "rep_version",           limit: 20
    t.datetime "rep_timestamp"
    t.string   "credit_reference_no",   limit: 255
    t.string   "fault_code",            limit: 50
    t.string   "fault_reason",          limit: 1000
    t.string   "cust_email_notify_ref", limit: 50
    t.string   "fault_subcode",         limit: 50
  end

  add_index "ic_paynows", ["req_no", "app_id", "attempt_no", "customer_id"], name: "uk_ic_paynows_1", unique: true

  create_table "ic_pending_steps", force: :cascade do |t|
    t.string   "broker_uuid",      limit: 255, null: false
    t.integer  "ic_audit_step_id",             null: false
    t.datetime "created_at",                   null: false
  end

  create_table "ic_suppliers", force: :cascade do |t|
    t.string   "supplier_code",    limit: 15,                null: false
    t.string   "supplier_name",    limit: 100,               null: false
    t.string   "customer_id",      limit: 15,                null: false
    t.string   "od_account_no",    limit: 20,                null: false
    t.string   "ca_account_no",    limit: 20,                null: false
    t.string   "is_enabled",       limit: 1,                 null: false
    t.string   "created_by",       limit: 20
    t.string   "updated_by",       limit: 20
    t.datetime "created_at",                                 null: false
    t.datetime "updated_at",                                 null: false
    t.integer  "lock_version",                 default: 0,   null: false
    t.string   "approval_status",  limit: 1,   default: "U", null: false
    t.string   "last_action",      limit: 1,   default: "C", null: false
    t.integer  "approved_version"
    t.integer  "approved_id"
    t.string   "corp_customer_id", limit: 15,                null: false
  end

  add_index "ic_suppliers", ["supplier_code", "customer_id", "corp_customer_id", "approval_status"], name: "ic_suppliers_01", unique: true

  create_table "ic_unapproved_records", force: :cascade do |t|
    t.integer  "ic_approvable_id"
    t.string   "ic_approvable_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "imt_add_beneficiaries", force: :cascade do |t|
    t.string   "req_no",            limit: 255,  null: false
    t.integer  "attempt_no",                     null: false
    t.string   "status_code",       limit: 25,   null: false
    t.string   "req_version",       limit: 10,   null: false
    t.datetime "req_timestamp",                  null: false
    t.string   "app_id",            limit: 50,   null: false
    t.string   "customer_id",       limit: 50,   null: false
    t.string   "bene_mobile_no",    limit: 50,   null: false
    t.string   "bene_name",         limit: 50,   null: false
    t.string   "bene_address_line", limit: 255,  null: false
    t.string   "bene_city",         limit: 255,  null: false
    t.string   "bene_postal_code",  limit: 255,  null: false
    t.string   "rep_no",            limit: 255
    t.string   "rep_version",       limit: 10
    t.datetime "rep_timestamp"
    t.string   "fault_code",        limit: 50
    t.string   "fault_reason",      limit: 1000
    t.string   "fault_subcode",     limit: 50
  end

  add_index "imt_add_beneficiaries", ["req_no", "app_id", "attempt_no"], name: "uk_imt_add_bene", unique: true

  create_table "imt_audit_logs", force: :cascade do |t|
    t.string   "req_no",             limit: 32,   null: false
    t.string   "app_id",             limit: 32,   null: false
    t.integer  "attempt_no",                      null: false
    t.string   "status_code",        limit: 25,   null: false
    t.string   "imt_auditable_type", limit: 255,  null: false
    t.integer  "imt_auditable_id",                null: false
    t.string   "fault_code",         limit: 255
    t.string   "fault_reason",       limit: 1000
    t.datetime "req_timestamp"
    t.datetime "rep_timestamp"
    t.text     "req_bitstream",                   null: false
    t.text     "rep_bitstream"
    t.text     "fault_bitstream"
    t.string   "fault_subcode",      limit: 50
  end

  add_index "imt_audit_logs", ["app_id", "req_no", "attempt_no"], name: "uk_imt_audit_logs_1", unique: true
  add_index "imt_audit_logs", ["imt_auditable_type", "imt_auditable_id"], name: "uk_imt_audit_logs_2", unique: true

  create_table "imt_audit_steps", force: :cascade do |t|
    t.string   "imt_auditable_type",              null: false
    t.integer  "imt_auditable_id",                null: false
    t.integer  "step_no",                         null: false
    t.integer  "attempt_no",                      null: false
    t.string   "step_name",          limit: 100,  null: false
    t.string   "status_code",        limit: 25,   null: false
    t.string   "fault_code",         limit: 255
    t.string   "fault_reason",       limit: 1000
    t.string   "req_reference",      limit: 255
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
    t.string   "req_no",           limit: 255,                null: false
    t.integer  "attempt_no",                                  null: false
    t.string   "status_code",      limit: 25,                 null: false
    t.string   "req_version",      limit: 10,                 null: false
    t.datetime "req_timestamp",                               null: false
    t.string   "app_id",           limit: 50,                 null: false
    t.string   "customer_id",      limit: 50,                 null: false
    t.string   "req_ref_no",       limit: 50,                 null: false
    t.string   "cancel_reason",    limit: 50,                 null: false
    t.string   "rep_no",           limit: 255
    t.string   "rep_version",      limit: 10
    t.datetime "rep_timestamp"
    t.string   "imt_ref_no",       limit: 255
    t.string   "bank_ref_no",      limit: 255
    t.string   "fault_code",       limit: 50
    t.string   "fault_reason",     limit: 1000
    t.string   "fault_subcode",    limit: 50
    t.string   "pending_approval", limit: 1,    default: "Y"
  end

  add_index "imt_cancel_transfers", ["bank_ref_no"], name: "index_imt_cancel_transfers_on_bank_ref_no", unique: true
  add_index "imt_cancel_transfers", ["req_no", "app_id", "attempt_no"], name: "uk_imt_cancel_trans", unique: true

  create_table "imt_customers", force: :cascade do |t|
    t.string   "customer_code",    limit: 255,               null: false
    t.string   "customer_name",    limit: 255,               null: false
    t.string   "contact_person",   limit: 255,               null: false
    t.string   "email_id",         limit: 255,               null: false
    t.string   "is_enabled",       limit: 1,                 null: false
    t.string   "mobile_no",        limit: 255,               null: false
    t.string   "account_no",       limit: 255,               null: false
    t.integer  "expiry_period",                              null: false
    t.string   "txn_mode",         limit: 4,                 null: false
    t.string   "address_line1",    limit: 255
    t.string   "address_line2",    limit: 255
    t.string   "address_line3"
    t.string   "country"
    t.integer  "lock_version",                               null: false
    t.string   "approval_status",  limit: 1,   default: "U", null: false
    t.string   "last_action",      limit: 1
    t.integer  "approved_version"
    t.integer  "approved_id"
    t.string   "created_by",       limit: 20
    t.string   "updated_by",       limit: 20
    t.datetime "created_at",                                 null: false
    t.datetime "updated_at",                                 null: false
    t.string   "app_id",           limit: 50,                null: false
    t.string   "identity_user_id", limit: 20,                null: false
  end

  add_index "imt_customers", ["account_no"], name: "index_imt_customers_on_account_no"
  add_index "imt_customers", ["app_id", "approval_status"], name: "uk1_imt_customers", unique: true
  add_index "imt_customers", ["customer_code"], name: "index_imt_customers_on_customer_code"
  add_index "imt_customers", ["customer_name"], name: "index_imt_customers_on_customer_name"

  create_table "imt_del_beneficiaries", force: :cascade do |t|
    t.string   "req_no",         limit: 255,  null: false
    t.integer  "attempt_no",                  null: false
    t.string   "status_code",    limit: 25,   null: false
    t.string   "req_version",    limit: 10,   null: false
    t.datetime "req_timestamp",               null: false
    t.string   "app_id",         limit: 50,   null: false
    t.string   "customer_id",    limit: 50,   null: false
    t.string   "bene_mobile_no", limit: 50,   null: false
    t.string   "rep_no",         limit: 255
    t.string   "rep_version",    limit: 10
    t.datetime "rep_timestamp"
    t.string   "fault_code",     limit: 50
    t.string   "fault_reason",   limit: 1000
    t.string   "fault_subcode",  limit: 50
  end

  add_index "imt_del_beneficiaries", ["req_no", "app_id", "attempt_no"], name: "uk_imt_del_bene", unique: true

  create_table "imt_initiate_transfers", force: :cascade do |t|
    t.string   "req_no",            limit: 255,                null: false
    t.integer  "attempt_no",                                   null: false
    t.string   "status_code",       limit: 25,                 null: false
    t.string   "req_version",       limit: 10,                 null: false
    t.datetime "req_timestamp",                                null: false
    t.string   "app_id",            limit: 50,                 null: false
    t.string   "customer_id",       limit: 50,                 null: false
    t.string   "bene_mobile_no",    limit: 50,                 null: false
    t.string   "pass_code",         limit: 5,                  null: false
    t.string   "rmtr_to_bene_note", limit: 255,                null: false
    t.date     "expiry_date"
    t.string   "rep_no",            limit: 255
    t.string   "rep_version",       limit: 10
    t.datetime "rep_timestamp"
    t.string   "imt_ref_no",        limit: 255
    t.string   "bank_ref_no",       limit: 255
    t.string   "fault_code",        limit: 50
    t.string   "fault_reason",      limit: 1000
    t.string   "fault_subcode",     limit: 50
    t.string   "pending_approval",  limit: 1,    default: "Y"
    t.decimal  "transfer_amount",                              null: false
  end

  add_index "imt_initiate_transfers", ["bank_ref_no"], name: "index_imt_initiate_transfers_on_bank_ref_no", unique: true
  add_index "imt_initiate_transfers", ["req_no", "app_id", "attempt_no"], name: "uk_imt_tranfers", unique: true

  create_table "imt_pending_steps", force: :cascade do |t|
    t.string   "broker_uuid",       limit: 255,             null: false
    t.datetime "created_at",                                null: false
    t.integer  "imt_audit_step_id",             default: 1, null: false
  end

  create_table "imt_transfers", force: :cascade do |t|
    t.string   "imt_ref_no",            limit: 35
    t.string   "status_code",           limit: 25,  null: false
    t.string   "customer_id",           limit: 50,  null: false
    t.string   "bene_mobile_no",        limit: 50,  null: false
    t.string   "rmtr_to_bene_note",     limit: 255, null: false
    t.date     "expiry_date"
    t.datetime "initiated_at"
    t.string   "initiation_ref_no",     limit: 64,  null: false
    t.datetime "completed_at"
    t.string   "acquiring_bank",        limit: 255
    t.datetime "cancelled_at"
    t.string   "cancellation_ref_no",   limit: 64
    t.datetime "expired_at"
    t.string   "cancel_reason",         limit: 255
    t.string   "initiation_bank_ref",               null: false
    t.string   "cancellation_bank_ref"
    t.decimal  "transfer_amount",                   null: false
  end

  add_index "imt_transfers", ["cancellation_ref_no"], name: "uk_imt_transfers_3", unique: true
  add_index "imt_transfers", ["imt_ref_no"], name: "uk_imt_transfers_1", unique: true
  add_index "imt_transfers", ["initiation_ref_no"], name: "uk_imt_transfers_2", unique: true

  create_table "imt_unapproved_records", force: :cascade do |t|
    t.integer  "imt_approvable_id"
    t.string   "imt_approvable_type"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
  end

  create_table "incoming_file_records", force: :cascade do |t|
    t.integer  "incoming_file_id"
    t.integer  "record_no"
    t.text     "record_txt"
    t.string   "status",              limit: 20
    t.string   "fault_code",          limit: 50
    t.string   "fault_reason",        limit: 500
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.string   "fault_subcode",       limit: 50
    t.text     "fault_bitstream"
    t.string   "rep_status",          limit: 50
    t.string   "rep_fault_subcode",   limit: 50
    t.string   "rep_fault_reason",    limit: 500
    t.text     "rep_fault_bitstream"
    t.string   "overrides",           limit: 50
    t.integer  "attempt_no"
    t.string   "rep_fault_code",      limit: 50
  end

  add_index "incoming_file_records", ["incoming_file_id", "record_no"], name: "uk_inc_file_records", unique: true

  create_table "incoming_file_types", force: :cascade do |t|
    t.integer "sc_service_id",                                 null: false
    t.string  "code",                limit: 50,                null: false
    t.string  "name",                limit: 50,                null: false
    t.string  "msg_domain",          limit: 255
    t.string  "msg_model",           limit: 255
    t.string  "validate_all",        limit: 1,   default: "N"
    t.string  "auto_upload",         limit: 1,   default: "N"
    t.string  "skip_first",          limit: 1,   default: "N"
    t.string  "build_response_file", limit: 1
    t.string  "correlation_field"
    t.string  "db_unit_name"
    t.string  "records_table"
    t.string  "can_override",        limit: 1,   default: "N", null: false
    t.string  "can_skip",            limit: 1,   default: "N", null: false
    t.string  "can_retry",           limit: 1,   default: "N", null: false
    t.string  "build_nack_file",     limit: 1,   default: "N", null: false
    t.string  "skip_last",           limit: 1,   default: "N", null: false
  end

  add_index "incoming_file_types", ["sc_service_id", "code"], name: "UK_IN_FILE_TYPES_1", unique: true

  create_table "incoming_files", force: :cascade do |t|
    t.string   "service_name",               limit: 10
    t.string   "file_type",                  limit: 10
    t.string   "file"
    t.string   "file_name",                  limit: 50
    t.integer  "size_in_bytes"
    t.integer  "line_count"
    t.string   "status",                     limit: 1
    t.date     "started_at"
    t.date     "ended_at"
    t.string   "created_by",                 limit: 20
    t.string   "updated_by",                 limit: 20
    t.datetime "created_at",                                            null: false
    t.datetime "updated_at"
    t.string   "fault_code",                 limit: 50
    t.string   "fault_reason",               limit: 1000
    t.string   "approval_status",            limit: 1,    default: "U", null: false
    t.string   "last_action",                limit: 1,    default: "C"
    t.integer  "approved_version"
    t.integer  "approved_id"
    t.integer  "lock_version"
    t.string   "broker_uuid",                limit: 255
    t.integer  "failed_record_count"
    t.string   "fault_subcode",              limit: 50
    t.string   "rep_file_name"
    t.string   "rep_file_path"
    t.string   "rep_file_status",            limit: 1
    t.string   "pending_approval",           limit: 1
    t.string   "file_path"
    t.string   "last_process_step",          limit: 1
    t.integer  "record_count"
    t.integer  "skipped_record_count"
    t.integer  "completed_record_count"
    t.integer  "timedout_record_count"
    t.integer  "alert_count"
    t.datetime "last_alert_at"
    t.integer  "bad_record_count"
    t.text     "fault_bitstream"
    t.integer  "pending_retry_record_count"
    t.integer  "overriden_record_count"
    t.string   "nack_file_name"
    t.string   "nack_file_path"
    t.string   "nack_file_status",           limit: 1
  end

  add_index "incoming_files", ["file_name", "approval_status"], name: "index_incoming_files_on_file_name_and_approval_status", unique: true
  add_index "incoming_files", ["service_name", "status", "pending_approval"], name: "in_incoming_files_2"

  create_table "inw_audit_logs", force: :cascade do |t|
    t.integer "inward_remittance_id"
    t.text    "request_bitstream"
    t.text    "reply_bitstream"
  end

  create_table "inw_audit_steps", force: :cascade do |t|
    t.string   "inw_auditable_type",              null: false
    t.integer  "inw_auditable_id",                null: false
    t.integer  "step_no",                         null: false
    t.integer  "attempt_no",                      null: false
    t.string   "step_name",          limit: 100,  null: false
    t.string   "status_code",        limit: 25,   null: false
    t.string   "fault_code",         limit: 255
    t.string   "fault_subcode",      limit: 50
    t.string   "fault_reason",       limit: 1000
    t.string   "req_reference",      limit: 255
    t.datetime "req_timestamp"
    t.string   "rep_reference"
    t.datetime "rep_timestamp"
    t.text     "req_bitstream"
    t.text     "rep_bitstream"
    t.text     "fault_bitstream"
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

  create_table "inw_identities", force: :cascade do |t|
    t.string  "id_for",                  limit: 20, null: false
    t.string  "id_type",                 limit: 30
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
    t.decimal  "transfer_amount"
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
    t.decimal  "bal_available"
    t.string   "service_id"
    t.date     "reconciled_at"
    t.string   "cbs_req_ref_no"
    t.datetime "processed_at"
  end

  add_index "inward_remittances", ["bank_ref"], name: "index_inward_remittances_on_bank_ref"
  add_index "inward_remittances", ["bene_account_no"], name: "index_inward_remittances_on_bene_account_no"
  add_index "inward_remittances", ["req_no", "partner_code", "attempt_no"], name: "remittance_unique_index", unique: true
  add_index "inward_remittances", ["req_transfer_type"], name: "index_inward_remittances_on_req_transfer_type"
  add_index "inward_remittances", ["status_code"], name: "index_inward_remittances_on_status_code"
  add_index "inward_remittances", ["transfer_type"], name: "index_inward_remittances_on_transfer_type"

  create_table "inward_remittances_locks", id: false, force: :cascade do |t|
    t.integer "inward_remittance_id"
    t.string  "created_at"
  end

  create_table "outgoing_file_types", force: :cascade do |t|
    t.integer  "sc_service_id",             null: false
    t.string   "code",          limit: 50,  null: false
    t.string   "name",          limit: 50,  null: false
    t.string   "db_unit_name",  limit: 255
    t.string   "msg_domain",    limit: 255
    t.string   "msg_model",     limit: 255
    t.string   "row_name",      limit: 255
    t.string   "file_name",     limit: 255
    t.integer  "run_at_hour"
    t.string   "run_at_day",    limit: 1
    t.datetime "last_run_at"
    t.datetime "next_run_at"
    t.integer  "batch_size"
    t.string   "write_header",  limit: 1
    t.string   "email_to"
    t.string   "email_cc"
    t.string   "email_subject"
  end

  add_index "outgoing_file_types", ["code", "sc_service_id"], name: "index_outgoing_file_types_on_code_and_sc_service_id", unique: true

  create_table "outgoing_files", force: :cascade do |t|
    t.string   "service_code",            null: false
    t.string   "file_type",               null: false
    t.string   "file_name",    limit: 50, null: false
    t.string   "file_path",    limit: 50, null: false
    t.integer  "line_count",   limit: 38, null: false
    t.datetime "started_at",              null: false
    t.datetime "ended_at"
    t.string   "email_ref"
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
    t.decimal  "low_balance_alert_at"
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

  create_table "pc2_apps", force: :cascade do |t|
    t.string   "app_id",           limit: 50,               null: false
    t.string   "customer_id",      limit: 50,               null: false
    t.string   "identity_user_id", limit: 20,               null: false
    t.string   "is_enabled",       limit: 1,                null: false
    t.string   "created_by",       limit: 20
    t.string   "updated_by",       limit: 20
    t.datetime "created_at",                                null: false
    t.datetime "updated_at",                                null: false
    t.integer  "lock_version",                default: 0,   null: false
    t.string   "approval_status",  limit: 1,  default: "U", null: false
    t.string   "last_action",      limit: 1,  default: "C", null: false
    t.integer  "approved_version"
    t.integer  "approved_id"
  end

  add_index "pc2_apps", ["app_id", "approval_status"], name: "index_pc2_apps_on_app_id_and_approval_status", unique: true

  create_table "pc2_audit_logs", force: :cascade do |t|
    t.string   "req_no",             limit: 32,   null: false
    t.string   "app_id",             limit: 32,   null: false
    t.integer  "attempt_no",                      null: false
    t.string   "status_code",        limit: 25,   null: false
    t.string   "pc2_auditable_type", limit: 255,  null: false
    t.integer  "pc2_auditable_id",                null: false
    t.string   "fault_code",         limit: 255
    t.string   "fault_subcode",      limit: 50
    t.string   "fault_reason",       limit: 1000
    t.datetime "req_timestamp"
    t.datetime "rep_timestamp"
    t.text     "req_bitstream",                   null: false
    t.text     "rep_bitstream"
    t.text     "fault_bitstream"
  end

  add_index "pc2_audit_logs", ["app_id", "req_no", "attempt_no"], name: "uk_pc2_audit_logs_1", unique: true
  add_index "pc2_audit_logs", ["pc2_auditable_type", "pc2_auditable_id"], name: "uk_pc2_audit_logs_2", unique: true

  create_table "pc2_audit_steps", force: :cascade do |t|
    t.string   "pc2_auditable_type",              null: false
    t.integer  "pc2_auditable_id",                null: false
    t.integer  "step_no",                         null: false
    t.integer  "attempt_no",                      null: false
    t.string   "step_name",          limit: 100,  null: false
    t.string   "status_code",        limit: 25,   null: false
    t.string   "fault_code",         limit: 255
    t.string   "fault_subcode",      limit: 50
    t.string   "fault_reason",       limit: 1000
    t.string   "req_reference",      limit: 255
    t.datetime "req_timestamp"
    t.string   "rep_reference"
    t.datetime "rep_timestamp"
    t.text     "req_bitstream"
    t.text     "rep_bitstream"
    t.text     "fault_bitstream"
    t.datetime "reconciled_at"
  end

  add_index "pc2_audit_steps", ["pc2_auditable_type", "pc2_auditable_id", "step_no", "attempt_no"], name: "uk_pc2_audit_steps", unique: true

  create_table "pc2_load_cards", force: :cascade do |t|
    t.string   "req_no",        limit: 255,  null: false
    t.integer  "attempt_no",                 null: false
    t.string   "status_code",   limit: 25,   null: false
    t.string   "req_version",   limit: 10,   null: false
    t.datetime "req_timestamp",              null: false
    t.string   "app_id",        limit: 50,   null: false
    t.string   "customer_id",   limit: 50,   null: false
    t.string   "debit_acct_no", limit: 50,   null: false
    t.string   "proxy_card_no", limit: 50,   null: false
    t.string   "load_ccy",      limit: 50,   null: false
    t.decimal  "load_amount",                null: false
    t.string   "product_type",  limit: 50,   null: false
    t.decimal  "exch_rate",                  null: false
    t.string   "rep_no",        limit: 255
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
    t.string   "broker_uuid",       limit: 255,             null: false
    t.datetime "created_at",                                null: false
    t.integer  "pc2_audit_step_id",             default: 1, null: false
  end

  create_table "pc2_unapproved_records", force: :cascade do |t|
    t.integer  "pc2_approvable_id"
    t.string   "pc2_approvable_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "pc2_unload_cards", force: :cascade do |t|
    t.string   "req_no",         limit: 255,  null: false
    t.integer  "attempt_no",                  null: false
    t.string   "status_code",    limit: 25,   null: false
    t.string   "req_version",    limit: 10,   null: false
    t.datetime "req_timestamp",               null: false
    t.string   "app_id",         limit: 50,   null: false
    t.string   "customer_id",    limit: 50,   null: false
    t.string   "credit_acct_no", limit: 50,   null: false
    t.string   "proxy_card_no",  limit: 50,   null: false
    t.string   "unload_ccy",     limit: 50,   null: false
    t.decimal  "unload_amount",               null: false
    t.string   "product_type",   limit: 50,   null: false
    t.decimal  "exch_rate",                   null: false
    t.string   "rep_no",         limit: 255
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
    t.string   "app_id",           limit: 50,               null: false
    t.string   "is_enabled",       limit: 1,                null: false
    t.integer  "lock_version",                              null: false
    t.string   "approval_status",  limit: 1,  default: "U", null: false
    t.string   "last_action",      limit: 1
    t.integer  "approved_version"
    t.integer  "approved_id"
    t.string   "created_by",       limit: 20
    t.string   "updated_by",       limit: 20
    t.datetime "created_at",                                null: false
    t.datetime "updated_at",                                null: false
    t.string   "needs_pin",        limit: 1,  default: "N", null: false
    t.string   "identity_user_id", limit: 20,               null: false
    t.string   "program_code",     limit: 15,               null: false
  end

  add_index "pc_apps", ["app_id", "approval_status"], name: "index_pc_apps_on_app_id_and_approval_status", unique: true

  create_table "pc_audit_logs", force: :cascade do |t|
    t.string   "req_no",            limit: 32,   null: false
    t.string   "app_id",            limit: 32,   null: false
    t.integer  "attempt_no",                     null: false
    t.string   "status_code",       limit: 25,   null: false
    t.string   "pc_auditable_type", limit: 255,  null: false
    t.integer  "pc_auditable_id",                null: false
    t.string   "fault_code",        limit: 255
    t.string   "fault_reason",      limit: 1000
    t.datetime "req_timestamp"
    t.datetime "rep_timestamp"
    t.text     "req_bitstream",                  null: false
    t.text     "rep_bitstream"
    t.text     "fault_bitstream"
    t.string   "fault_subcode",     limit: 50
  end

  add_index "pc_audit_logs", ["app_id", "req_no", "attempt_no"], name: "uk_pc_audit_logs_1", unique: true
  add_index "pc_audit_logs", ["pc_auditable_type", "pc_auditable_id"], name: "uk_pc_audit_logs_2", unique: true

  create_table "pc_audit_steps", force: :cascade do |t|
    t.string   "pc_auditable_type",              null: false
    t.integer  "pc_auditable_id",                null: false
    t.integer  "step_no",                        null: false
    t.integer  "attempt_no",                     null: false
    t.string   "step_name",         limit: 100,  null: false
    t.string   "status_code",       limit: 25,   null: false
    t.string   "fault_code",        limit: 255
    t.string   "fault_reason",      limit: 1000
    t.string   "req_reference",     limit: 255
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
    t.string   "req_no",        limit: 32,   null: false
    t.string   "app_id",        limit: 32,   null: false
    t.integer  "attempt_no",                 null: false
    t.string   "status_code",   limit: 25,   null: false
    t.string   "req_version",   limit: 5,    null: false
    t.datetime "req_timestamp"
    t.string   "mobile_no",     limit: 255
    t.string   "email_id",      limit: 255
    t.string   "cust_uid",      limit: 255
    t.string   "password",      limit: 255
    t.string   "rep_no",        limit: 32
    t.string   "rep_version",   limit: 5
    t.datetime "rep_timestamp"
    t.string   "fault_code",    limit: 255
    t.string   "fault_reason",  limit: 1000
    t.string   "fault_subcode", limit: 50
  end

  add_index "pc_block_cards", ["req_no", "app_id", "attempt_no"], name: "uk_pc_block_cards_1", unique: true

  create_table "pc_card_registrations", force: :cascade do |t|
    t.string   "req_no",                limit: 32,   null: false
    t.string   "app_id",                limit: 32,   null: false
    t.integer  "attempt_no",                         null: false
    t.string   "status_code",           limit: 25,   null: false
    t.string   "req_version",           limit: 5,    null: false
    t.datetime "req_timestamp"
    t.string   "title",                 limit: 15
    t.string   "first_name",            limit: 255
    t.string   "last_name",             limit: 255
    t.string   "pref_name",             limit: 255
    t.string   "email_id",              limit: 255
    t.date     "birth_date"
    t.string   "nationality",           limit: 255
    t.integer  "country_code"
    t.string   "mobile_no",             limit: 255
    t.string   "gender",                limit: 255
    t.string   "doc_type",              limit: 255
    t.string   "doc_no",                limit: 255
    t.string   "country_of_issue",      limit: 255
    t.string   "address_line1",         limit: 255
    t.string   "address_line2",         limit: 255
    t.string   "city",                  limit: 255
    t.string   "state",                 limit: 255
    t.string   "country",               limit: 255
    t.string   "postal_code",           limit: 15
    t.string   "proxy_card_no",         limit: 255
    t.integer  "pc_customer_id"
    t.string   "rep_no",                limit: 32
    t.string   "rep_version",           limit: 5
    t.datetime "rep_timestamp"
    t.string   "fault_code",            limit: 255
    t.string   "fault_reason",          limit: 1000
    t.string   "fault_subcode",         limit: 50
    t.string   "cust_uid",              limit: 255
    t.string   "card_uid",              limit: 255
    t.string   "card_no",               limit: 255
    t.datetime "card_issue_date"
    t.integer  "card_expiry_year"
    t.integer  "card_expiry_month"
    t.string   "card_holder_name",      limit: 255
    t.string   "card_type",             limit: 255
    t.string   "card_name",             limit: 255
    t.string   "card_desc",             limit: 255
    t.string   "card_image_small_uri",  limit: 255
    t.string   "card_image_medium_uri", limit: 255
    t.string   "card_image_large_uri",  limit: 255
    t.string   "program_code",          limit: 15
    t.string   "product_code",          limit: 15
  end

  add_index "pc_card_registrations", ["req_no", "app_id", "attempt_no"], name: "uk_pc_card_regs", unique: true

  create_table "pc_customer_credentials", force: :cascade do |t|
    t.string "username", null: false
    t.string "password", null: false
  end

  create_table "pc_customers", force: :cascade do |t|
    t.string   "mobile_no",          limit: 255, null: false
    t.string   "title",              limit: 15
    t.string   "first_name",         limit: 255
    t.string   "last_name",          limit: 255
    t.string   "pref_name",          limit: 255
    t.string   "email_id",           limit: 255
    t.string   "password",           limit: 255
    t.string   "cust_status",        limit: 255
    t.string   "cust_uid",           limit: 255
    t.date     "birth_date"
    t.string   "nationality",        limit: 255
    t.integer  "country_code"
    t.date     "reg_date"
    t.string   "gender",             limit: 255
    t.string   "doc_type",           limit: 255
    t.string   "doc_no",             limit: 255
    t.string   "country_of_issue",   limit: 255
    t.string   "address_line1",      limit: 255
    t.string   "address_line2",      limit: 255
    t.string   "city",               limit: 255
    t.string   "state",              limit: 255
    t.string   "country",            limit: 255
    t.string   "postal_code",        limit: 15
    t.string   "proxy_card_no",      limit: 255
    t.string   "card_uid",           limit: 255
    t.string   "card_no",            limit: 255
    t.string   "card_type",          limit: 255
    t.string   "card_name",          limit: 255
    t.string   "card_desc",          limit: 255
    t.string   "card_status",        limit: 255
    t.date     "card_issue_date"
    t.integer  "card_expiry_year"
    t.integer  "card_expiry_month"
    t.string   "card_currency_code", limit: 255
    t.string   "app_id",             limit: 50
    t.string   "activation_code",    limit: 255
    t.datetime "activated_at"
    t.string   "program_code",       limit: 15,  null: false
    t.string   "product_code",       limit: 15,  null: false
  end

  add_index "pc_customers", ["email_id", "program_code"], name: "pc_customers_02", unique: true
  add_index "pc_customers", ["mobile_no", "program_code"], name: "pc_customers_01", unique: true

  create_table "pc_fee_rules", force: :cascade do |t|
    t.string   "txn_kind",         limit: 50,               null: false
    t.integer  "no_of_tiers",                               null: false
    t.string   "tier1_method",     limit: 3,                null: false
    t.string   "tier2_method",     limit: 3
    t.string   "tier3_method",     limit: 3
    t.integer  "lock_version",                              null: false
    t.string   "approval_status",  limit: 1,  default: "U", null: false
    t.string   "last_action",      limit: 1
    t.integer  "approved_version"
    t.integer  "approved_id"
    t.string   "created_by",       limit: 20
    t.string   "updated_by",       limit: 20
    t.datetime "created_at",                                null: false
    t.datetime "updated_at",                                null: false
    t.decimal  "tier3_max_sc_amt"
    t.decimal  "tier3_min_sc_amt"
    t.decimal  "tier3_pct_value"
    t.decimal  "tier3_fixed_amt"
    t.decimal  "tier2_max_sc_amt"
    t.decimal  "tier2_min_sc_amt"
    t.decimal  "tier2_pct_value"
    t.decimal  "tier2_fixed_amt"
    t.decimal  "tier2_to_amt"
    t.decimal  "tier1_max_sc_amt",                          null: false
    t.decimal  "tier1_min_sc_amt",                          null: false
    t.decimal  "tier1_pct_value",                           null: false
    t.decimal  "tier1_fixed_amt",                           null: false
    t.decimal  "tier1_to_amt",                              null: false
    t.string   "product_code",     limit: 15,               null: false
  end

  add_index "pc_fee_rules", ["product_code", "txn_kind", "approval_status"], name: "pc_fee_rules_01", unique: true
  add_index "pc_fee_rules", ["txn_kind", "approval_status"], name: "uk_pc_fee_rules", unique: true

  create_table "pc_load_cards", force: :cascade do |t|
    t.string   "req_no",           limit: 32,   null: false
    t.string   "app_id",           limit: 32,   null: false
    t.integer  "attempt_no",                    null: false
    t.string   "status_code",      limit: 25,   null: false
    t.string   "req_version",      limit: 5,    null: false
    t.datetime "req_timestamp"
    t.string   "customer_id",      limit: 15
    t.string   "mobile_no",        limit: 255
    t.string   "debit_acct_no",    limit: 255
    t.string   "email_id",         limit: 255
    t.string   "password",         limit: 255
    t.string   "rep_no",           limit: 32
    t.string   "rep_version",      limit: 5
    t.datetime "rep_timestamp"
    t.string   "fault_code",       limit: 255
    t.string   "fault_reason",     limit: 1000
    t.string   "cust_uid",         limit: 255
    t.decimal  "load_amount"
    t.string   "fault_subcode",    limit: 50
    t.decimal  "service_charge"
    t.string   "debit_fee_status", limit: 50
    t.string   "debit_fee_result", limit: 1000
  end

  add_index "pc_load_cards", ["req_no", "app_id", "attempt_no"], name: "uk_pc_load_cards", unique: true

  create_table "pc_mm_cd_incoming_files", force: :cascade do |t|
    t.string "file_name", limit: 50
  end

  add_index "pc_mm_cd_incoming_files", ["file_name"], name: "pc_incoming_files_01", unique: true

  create_table "pc_mm_cd_incoming_records", force: :cascade do |t|
    t.integer "incoming_file_record_id"
    t.string  "file_name",               limit: 50
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
    t.string   "code",                limit: 15,                null: false
    t.string   "mm_host",             limit: 255,               null: false
    t.string   "mm_consumer_key",     limit: 255,               null: false
    t.string   "mm_consumer_secret",  limit: 255,               null: false
    t.string   "mm_card_type",        limit: 255,               null: false
    t.string   "mm_email_domain",     limit: 255,               null: false
    t.string   "mm_admin_host",       limit: 255,               null: false
    t.string   "mm_admin_user",       limit: 255,               null: false
    t.string   "mm_admin_password",   limit: 255,               null: false
    t.string   "is_enabled",          limit: 1,                 null: false
    t.datetime "created_at",                                    null: false
    t.datetime "updated_at",                                    null: false
    t.string   "created_by",          limit: 20
    t.string   "updated_by",          limit: 20
    t.integer  "lock_version",                    default: 0,   null: false
    t.string   "approval_status",     limit: 1,   default: "U", null: false
    t.string   "last_action",         limit: 1,   default: "C", null: false
    t.integer  "approved_version"
    t.integer  "approved_id"
    t.string   "card_acct",           limit: 20,                null: false
    t.string   "sc_gl_income",        limit: 15,                null: false
    t.string   "card_cust_id",                                  null: false
    t.string   "display_name"
    t.string   "cust_care_no",        limit: 16,                null: false
    t.string   "rkb_user",            limit: 30,                null: false
    t.string   "rkb_password",        limit: 40,                null: false
    t.string   "rkb_bcagent",         limit: 50,                null: false
    t.string   "rkb_channel_partner", limit: 3,                 null: false
    t.string   "program_code",        limit: 15,                null: false
  end

  add_index "pc_products", ["code", "approval_status"], name: "pc_programs_01", unique: true

  create_table "pc_programs", force: :cascade do |t|
    t.string   "code",             limit: 15,               null: false
    t.string   "is_enabled",       limit: 1,                null: false
    t.datetime "created_at",                                null: false
    t.datetime "updated_at",                                null: false
    t.string   "created_by",       limit: 20
    t.string   "updated_by",       limit: 20
    t.integer  "lock_version",                default: 0,   null: false
    t.string   "approval_status",  limit: 1,  default: "U", null: false
    t.string   "last_action",      limit: 1,  default: "C", null: false
    t.integer  "approved_version"
    t.integer  "approved_id"
  end

  add_index "pc_programs", ["code", "approval_status"], name: "pc_programs_02", unique: true

  create_table "pc_unapproved_records", force: :cascade do |t|
    t.integer  "pc_approvable_id"
    t.string   "pc_approvable_type"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

  create_table "pcs_add_beneficiaries", force: :cascade do |t|
    t.string   "req_no",         limit: 32,   null: false
    t.string   "app_id",         limit: 32,   null: false
    t.integer  "attempt_no",                  null: false
    t.string   "status_code",    limit: 25,   null: false
    t.string   "req_version",    limit: 5,    null: false
    t.datetime "req_timestamp"
    t.string   "mobile_no",      limit: 255
    t.string   "bene_name",      limit: 255
    t.string   "bene_acct_no",   limit: 255
    t.string   "bene_acct_ifsc", limit: 255
    t.string   "rep_no",         limit: 32
    t.string   "rep_version",    limit: 5
    t.string   "bene_id",        limit: 255
    t.datetime "rep_timestamp"
    t.string   "fault_code",     limit: 255
    t.string   "fault_reason",   limit: 1000
  end

  add_index "pcs_add_beneficiaries", ["req_no", "app_id", "attempt_no"], name: "uk_pcs_add_beneficiaries", unique: true

  create_table "pcs_audit_logs", force: :cascade do |t|
    t.string   "req_no",             limit: 32,   null: false
    t.string   "app_id",             limit: 32,   null: false
    t.integer  "attempt_no",                      null: false
    t.string   "status_code",        limit: 25,   null: false
    t.string   "pcs_auditable_type", limit: 255,  null: false
    t.integer  "pcs_auditable_id",                null: false
    t.string   "fault_code",         limit: 255
    t.string   "fault_reason",       limit: 1000
    t.datetime "req_timestamp"
    t.datetime "rep_timestamp"
    t.text     "req_bitstream",                   null: false
    t.text     "rep_bitstream"
    t.text     "fault_bitstream"
    t.string   "fault_subcode",      limit: 50
  end

  add_index "pcs_audit_logs", ["app_id", "req_no", "attempt_no"], name: "uk_pcs_audit_logs_1", unique: true
  add_index "pcs_audit_logs", ["pcs_auditable_type", "pcs_auditable_id"], name: "uk_pcs_audit_logs_2", unique: true

  create_table "pcs_audit_steps", force: :cascade do |t|
    t.string   "pcs_auditable_type",              null: false
    t.integer  "pcs_auditable_id",                null: false
    t.integer  "step_no",                         null: false
    t.integer  "attempt_no",                      null: false
    t.string   "step_name",          limit: 100,  null: false
    t.string   "status_code",        limit: 25,   null: false
    t.string   "fault_code",         limit: 255
    t.string   "fault_reason",       limit: 1000
    t.string   "req_reference",      limit: 255
    t.datetime "req_timestamp"
    t.string   "rep_reference"
    t.datetime "rep_timestamp"
    t.text     "req_bitstream"
    t.text     "rep_bitstream"
    t.text     "fault_bitstream"
    t.string   "fault_subcode",      limit: 50
    t.datetime "reconciled_at"
    t.datetime "last_requery_at"
    t.integer  "requery_attempt_no"
    t.integer  "requery_for"
    t.string   "requery_result"
  end

  add_index "pcs_audit_steps", ["pcs_auditable_type", "pcs_auditable_id", "step_no", "attempt_no"], name: "uk_pcs_audit_steps", unique: true

  create_table "pcs_pay_to_accounts", force: :cascade do |t|
    t.string   "req_no",            limit: 32,   null: false
    t.string   "app_id",            limit: 32,   null: false
    t.integer  "attempt_no",                     null: false
    t.string   "status_code",       limit: 50,   null: false
    t.string   "req_version",       limit: 5,    null: false
    t.datetime "req_timestamp"
    t.string   "mobile_no",         limit: 255
    t.string   "encrypted_pin",     limit: 255
    t.string   "transfer_type",     limit: 255
    t.string   "bene_acct_no",      limit: 255
    t.string   "bene_acct_ifsc",    limit: 255
    t.string   "transfer_amount",   limit: 255
    t.string   "rmtr_to_bene_note", limit: 255
    t.string   "rep_no",            limit: 32
    t.string   "rep_version",       limit: 5
    t.string   "req_ref_no",        limit: 50
    t.string   "rep_ref_no",        limit: 50
    t.string   "rep_transfer_type", limit: 50
    t.datetime "rep_timestamp"
    t.string   "fault_code",        limit: 255
    t.string   "fault_reason",      limit: 1000
    t.string   "debit_fee_status",  limit: 50
    t.string   "debit_fee_result",  limit: 1000
    t.string   "bene_name",         limit: 255,  null: false
    t.decimal  "service_charge"
  end

  add_index "pcs_pay_to_accounts", ["req_no", "app_id", "attempt_no"], name: "uk_pcs_pay_to_accounts", unique: true

  create_table "pcs_pay_to_contacts", force: :cascade do |t|
    t.string   "req_no",            limit: 32,   null: false
    t.string   "app_id",            limit: 32,   null: false
    t.integer  "attempt_no",                     null: false
    t.string   "status_code",       limit: 25,   null: false
    t.string   "req_version",       limit: 5,    null: false
    t.datetime "req_timestamp"
    t.string   "mobile_no",         limit: 255
    t.string   "contact_name",      limit: 255
    t.string   "contact_mobile_no", limit: 255
    t.string   "encrypted_pin",     limit: 255
    t.string   "transfer_amount",   limit: 255
    t.string   "rep_no",            limit: 32
    t.string   "rep_version",       limit: 5
    t.string   "req_ref_no",        limit: 50
    t.string   "rep_ref_no",        limit: 50
    t.datetime "rep_timestamp"
    t.string   "fault_code",        limit: 255
    t.string   "fault_reason",      limit: 1000
    t.string   "debit_fee_status",  limit: 50
    t.string   "debit_fee_result",  limit: 1000
    t.decimal  "service_charge"
  end

  add_index "pcs_pay_to_contacts", ["req_no", "app_id", "attempt_no"], name: "uk_pcs_pay_to_contacts", unique: true

  create_table "pcs_pending_steps", force: :cascade do |t|
    t.string   "broker_uuid",       limit: 255, null: false
    t.datetime "created_at",                    null: false
    t.integer  "pcs_audit_step_id"
  end

  create_table "pcs_top_ups", force: :cascade do |t|
    t.string   "req_no",           limit: 255,  null: false
    t.integer  "attempt_no",                    null: false
    t.string   "status_code",      limit: 25,   null: false
    t.string   "req_version",      limit: 10,   null: false
    t.datetime "req_timestamp",                 null: false
    t.string   "app_id",           limit: 50,   null: false
    t.string   "mobile_no",        limit: 50
    t.string   "encrypted_pin",    limit: 50
    t.string   "biller_id",        limit: 50
    t.string   "subscriber_id",    limit: 50
    t.string   "rep_no",           limit: 255
    t.string   "rep_version",      limit: 10
    t.datetime "rep_timestamp"
    t.string   "debit_ref_no",     limit: 255
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
    t.integer  "incoming_file_id"
    t.datetime "created_at"
  end

  create_table "pending_inward_remittances", force: :cascade do |t|
    t.integer  "inward_remittance_id", limit: 30,  null: false
    t.string   "broker_uuid",          limit: 255, null: false
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
  end

  add_index "pending_inward_remittances", ["inward_remittance_id"], name: "index_pending_inward_remittances_on_inward_remittance_id", unique: true

  create_table "pending_response_files", force: :cascade do |t|
    t.string   "broker_uuid",      limit: 500
    t.integer  "incoming_file_id"
    t.datetime "created_at"
  end

  add_index "pending_response_files", ["incoming_file_id"], name: "incoming_file_id_1", unique: true

  create_table "pending_sm_payments", force: :cascade do |t|
    t.string   "broker_uuid",   limit: 255, null: false
    t.integer  "sm_payment_id",             null: false
    t.datetime "created_at",                null: false
  end

  create_table "purpose_codes", force: :cascade do |t|
    t.string   "code",                  limit: 4
    t.string   "description",           limit: 255
    t.string   "is_enabled",            limit: 1
    t.string   "created_by",            limit: 20
    t.string   "updated_by",            limit: 20
    t.integer  "lock_version",                       default: 0,   null: false
    t.decimal  "txn_limit"
    t.integer  "daily_txn_limit"
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
    t.string   "approval_status",       limit: 1,    default: "U", null: false
    t.string   "last_action",           limit: 1,    default: "C"
    t.integer  "approved_version"
    t.integer  "approved_id"
    t.string   "pattern_allowed_benes", limit: 4000
  end

  create_table "rc_audit_steps", force: :cascade do |t|
    t.string   "rc_auditable_type",              null: false
    t.integer  "rc_auditable_id",                null: false
    t.integer  "step_no",                        null: false
    t.integer  "attempt_no",                     null: false
    t.string   "step_name",         limit: 100,  null: false
    t.string   "status_code",       limit: 25,   null: false
    t.string   "fault_code",        limit: 255
    t.string   "fault_subcode",     limit: 50
    t.string   "fault_reason",      limit: 1000
    t.string   "req_reference",     limit: 255
    t.datetime "req_timestamp"
    t.string   "rep_reference"
    t.datetime "rep_timestamp"
    t.text     "req_bitstream"
    t.text     "rep_bitstream"
    t.text     "fault_bitstream"
  end

  add_index "rc_audit_steps", ["rc_auditable_type", "rc_auditable_id", "step_no", "attempt_no"], name: "rc_audit_steps_01", unique: true

  create_table "rc_pending_notifications", force: :cascade do |t|
    t.string   "broker_uuid",       limit: 255, null: false
    t.string   "rc_auditable_type",             null: false
    t.integer  "rc_auditable_id",               null: false
    t.datetime "created_at",                    null: false
  end

  create_table "rc_pending_transfers", force: :cascade do |t|
    t.string   "broker_uuid",       limit: 255, null: false
    t.string   "rc_auditable_type",             null: false
    t.integer  "rc_auditable_id",               null: false
    t.datetime "created_at",                    null: false
  end

  create_table "rc_transfer_schedule", force: :cascade do |t|
    t.string   "code",             limit: 50
    t.string   "debit_account_no", limit: 20
    t.string   "bene_account_no",  limit: 20
    t.datetime "next_run_at"
    t.datetime "last_run_at"
    t.string   "app_code",         limit: 50
    t.string   "is_enabled",       limit: 1
    t.integer  "last_batch_no"
    t.datetime "created_at",                                null: false
    t.datetime "updated_at",                                null: false
    t.string   "created_by",       limit: 20
    t.string   "updated_by",       limit: 20
    t.integer  "lock_version",                default: 0,   null: false
    t.string   "approval_status",  limit: 1,  default: "U", null: false
    t.string   "last_action",      limit: 1,  default: "C", null: false
    t.integer  "approved_version"
    t.integer  "approved_id"
    t.string   "notify_mobile_no", limit: 10
  end

  add_index "rc_transfer_schedule", ["code", "approval_status"], name: "rc_transfer_schedules_01", unique: true

  create_table "rc_transfer_unapproved_records", force: :cascade do |t|
    t.integer  "rc_transfer_approvable_id"
    t.string   "rc_transfer_approvable_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "rc_transfers", force: :cascade do |t|
    t.string   "rc_transfer_code",  limit: 50,                 null: false
    t.string   "app_code",          limit: 50
    t.integer  "batch_no",                                     null: false
    t.string   "status_code",       limit: 50,                 null: false
    t.datetime "started_at",                                   null: false
    t.string   "debit_account_no",  limit: 20,                 null: false
    t.string   "bene_account_no",   limit: 20,                 null: false
    t.decimal  "transfer_amount"
    t.string   "transfer_req_ref",  limit: 50
    t.string   "transfer_rep_ref",  limit: 50
    t.datetime "transferred_at"
    t.string   "notify_status",     limit: 50
    t.integer  "notify_attempt_no"
    t.datetime "notify_attempt_at"
    t.datetime "notified_at"
    t.string   "notify_result",     limit: 100
    t.string   "fault_code",        limit: 50
    t.string   "fault_subcode",     limit: 50
    t.string   "fault_reason",      limit: 1000
    t.string   "customer_name",     limit: 100
    t.string   "customer_id",       limit: 50
    t.string   "mobile_no",         limit: 10
<<<<<<< HEAD
    t.string   "broker_uuid",                                   null: false
=======
    t.string   "broker_uuid",       limit: 255,                null: false
    t.string   "pending_approval",  limit: 1,    default: "Y", null: false
>>>>>>> 9556896aea59111e5755a8b5c758c8a6c7d5d9bb
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
  add_index "reconciled_returns", ["bank_ref_no"], name: "index_reconciled_returns_on_bank_ref_no"

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

<<<<<<< HEAD
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

  add_index "sb_audit_logs", ["app_id", "req_no", "attempt_no"], name: "uk_sb_audit_logs2", unique: true
  add_index "sb_audit_logs", ["sb_auditable_type", "sb_auditable_id"], name: "uk_sb_audit_logs1", unique: true

  create_table "sb_checkbook_orders", force: :cascade do |t|
    t.string   "req_no",                                          null: false
    t.integer  "attempt_no",                       precision: 38, null: false
    t.string   "status_code",         limit: 25,                  null: false
    t.string   "req_version",         limit: 10,                  null: false
    t.datetime "req_timestamp",                                   null: false
    t.string   "app_id",              limit: 50,                  null: false
    t.string   "req_customer_id",     limit: 50
    t.string   "cust_identity_type",  limit: 50
    t.string   "cust_identity_value", limit: 50
    t.string   "device_id",           limit: 50
    t.string   "req_account_no",      limit: 50
    t.string   "registered_account",  limit: 4
    t.string   "rep_no"
    t.string   "rep_version",         limit: 10
    t.string   "customer_id",         limit: 50
    t.string   "account_no",          limit: 50
    t.datetime "rep_timestamp"
    t.string   "fault_code",          limit: 50
    t.string   "fault_reason",        limit: 1000
  end

  add_index "sb_checkbook_orders", ["app_id", "req_no", "attempt_no"], name: "uk_sb_checkbook_orders", unique: true

  create_table "sb_cust_daily_stats", force: :cascade do |t|
    t.string   "customer_id", limit: 100, null: false
    t.datetime "dat_log",                 null: false
    t.integer  "ft_cnt",      limit: nil, null: false
    t.decimal  "ft_total",                null: false
  end

  add_index "sb_cust_daily_stats", ["dat_log", "customer_id"], name: "uk_sb_cust_daily_stats", unique: true

  create_table "sb_customers", id: false, force: :cascade do |t|
    t.integer "id",             limit: nil,                null: false
    t.string  "identity_type",  limit: 100,                null: false
    t.string  "identity_value", limit: 100,                null: false
    t.string  "customer_id",    limit: 100,                null: false
    t.string  "sa_account_no",  limit: 100
    t.integer "num_devices",                precision: 38, null: false
    t.string  "device1_id",     limit: 100
    t.string  "device2_id",     limit: 100
    t.string  "device3_id",     limit: 100
    t.string  "device4_id",     limit: 100
    t.string  "device5_id",     limit: 100
    t.string  "device6_id",     limit: 100
    t.string  "device7_id",     limit: 100
    t.string  "device8_id",     limit: 100
    t.string  "device9_id",     limit: 100
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
    t.string   "otp_value",           limit: 50
    t.string   "rep_no"
    t.string   "rep_version",         limit: 10
    t.datetime "rep_timestamp"
    t.string   "fault_code",          limit: 50
    t.string   "fault_reason",        limit: 1000
  end

  add_index "sb_deregistrations", ["app_id", "req_no", "attempt_no"], name: "uk_sb_deregistrations", unique: true

  create_table "sb_fund_transfers", force: :cascade do |t|
    t.string   "req_no",                                          null: false
    t.integer  "attempt_no",                       precision: 38, null: false
    t.string   "service_id",          limit: 50
    t.string   "status_code",         limit: 25,                  null: false
    t.string   "req_version",         limit: 10,                  null: false
    t.datetime "req_timestamp",                                   null: false
    t.string   "app_id",              limit: 50,                  null: false
    t.string   "req_customer_id",     limit: 50
    t.string   "cust_identity_type",  limit: 50
    t.string   "cust_identity_value", limit: 50
    t.string   "device_id",           limit: 50
    t.string   "req_account_no",      limit: 50
    t.string   "registered_account",  limit: 4
    t.string   "bene_id",             limit: 50
    t.string   "req_transfer_type",   limit: 4,                   null: false
    t.string   "transfer_ccy",        limit: 5,                   null: false
    t.decimal  "transfer_amount",                                 null: false
    t.string   "rmtr_to_bene_note"
    t.string   "cbs_req_ref_no",      limit: 50
    t.string   "rep_no"
    t.string   "rep_version",         limit: 10
    t.string   "customer_id",         limit: 50
    t.string   "account_no",          limit: 50
    t.string   "limit_status"
    t.string   "limit_result"
    t.datetime "rep_timestamp"
    t.string   "transfer_type",       limit: 4
    t.string   "bank_ref_no",         limit: 50
    t.string   "bene_full_name"
    t.string   "bene_account_no"
    t.string   "bene_account_ifsc"
    t.string   "fault_code",          limit: 50
    t.string   "fault_reason",        limit: 1000
  end

  add_index "sb_fund_transfers", ["app_id", "req_no", "attempt_no"], name: "uk_sb_fund_transfers", unique: true

  create_table "sb_pending_fund_transfers", force: :cascade do |t|
    t.string   "broker_uuid",                     null: false
    t.integer  "sb_fund_transfer_id", limit: nil, null: false
    t.datetime "created_at",                      null: false
  end

  add_index "sb_pending_fund_transfers", ["sb_fund_transfer_id"], name: "uk_pending_sb_fund_transfers", unique: true

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
    t.string   "otp_value",           limit: 50
    t.string   "rep_no"
    t.string   "rep_version",         limit: 10
    t.datetime "rep_timestamp"
    t.string   "fault_code",          limit: 50
    t.string   "fault_reason",        limit: 1000
  end

  add_index "sb_registrations", ["app_id", "req_no", "attempt_no"], name: "uk_sb_registrations", unique: true

  create_table "sb_statement_orders", force: :cascade do |t|
    t.string   "req_no",                                          null: false
    t.integer  "attempt_no",                       precision: 38, null: false
    t.string   "status_code",         limit: 25,                  null: false
    t.string   "req_version",         limit: 10,                  null: false
    t.datetime "req_timestamp",                                   null: false
    t.string   "app_id",              limit: 50,                  null: false
    t.string   "req_customer_id",     limit: 50
    t.string   "cust_identity_type",  limit: 50
    t.string   "cust_identity_value", limit: 50
    t.string   "device_id",           limit: 50
    t.string   "req_account_no",      limit: 50
    t.string   "registered_account",  limit: 4
    t.string   "rep_no"
    t.string   "rep_version",         limit: 10
    t.string   "customer_id",         limit: 50
    t.string   "account_no",          limit: 50
    t.datetime "rep_timestamp"
    t.string   "fault_code",          limit: 50
    t.string   "fault_reason",        limit: 1000
  end

  add_index "sb_statement_orders", ["app_id", "req_no", "attempt_no"], name: "uk_sb_statement_orders", unique: true

  create_table "sb_stop_checks", force: :cascade do |t|
    t.string   "req_no",                                          null: false
    t.integer  "attempt_no",                       precision: 38, null: false
    t.string   "status_code",         limit: 25,                  null: false
    t.string   "req_version",         limit: 10,                  null: false
    t.datetime "req_timestamp",                                   null: false
    t.string   "app_id",              limit: 50,                  null: false
    t.string   "req_customer_id",     limit: 50
    t.string   "cust_identity_type",  limit: 50
    t.string   "cust_identity_value", limit: 50
    t.string   "device_id",           limit: 50
    t.string   "req_account_no",      limit: 50
    t.string   "registered_account",  limit: 4
    t.string   "order_type",          limit: 1
    t.string   "from_check_no",       limit: 100
    t.string   "to_check_no",         limit: 100
    t.string   "rep_no"
    t.string   "customer_id",         limit: 50
    t.string   "account_no",          limit: 50
    t.string   "rep_version",         limit: 10
    t.datetime "rep_timestamp"
    t.string   "fault_code",          limit: 50
    t.string   "fault_reason",        limit: 1000
  end

  add_index "sb_stop_checks", ["app_id", "req_no", "attempt_no"], name: "uk_sb_stop_checks", unique: true

  create_table "sb_stopcheck_orders", force: :cascade do |t|
    t.string   "req_no",                           null: false
    t.string   "req_version",         limit: 10,   null: false
    t.datetime "req_timestamp",                    null: false
    t.string   "app_id",              limit: 50,   null: false
    t.string   "customer_id",         limit: 50
    t.string   "cust_identity_type",  limit: 50
    t.string   "cust_identity_value", limit: 50
    t.string   "device_id",           limit: 50
    t.string   "account_no",          limit: 50
    t.string   "account_last_n",      limit: 50
    t.string   "default_account",     limit: 1
    t.string   "registered_account",  limit: 1
    t.string   "order_type",          limit: 1
    t.string   "from_check_no",       limit: 100
    t.string   "to_check_no",         limit: 100
    t.string   "rep_no"
    t.string   "rep_version",         limit: 10
    t.datetime "rep_timestamp"
    t.string   "status_code",         limit: 25
    t.string   "fault_code",          limit: 50
    t.string   "fault_reason",        limit: 1000
  end

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
  end

  add_index "sc_backends", ["code"], name: "sc_backends_01", unique: true

=======
>>>>>>> 9556896aea59111e5755a8b5c758c8a6c7d5d9bb
  create_table "sc_services", force: :cascade do |t|
    t.string "code", limit: 50, null: false
    t.string "name", limit: 50, null: false
  end

  add_index "sc_services", ["code"], name: "index_sc_services_on_code", unique: true
  add_index "sc_services", ["name"], name: "index_sc_services_on_name", unique: true

  create_table "sm_audit_logs", force: :cascade do |t|
    t.string   "req_no",            limit: 32,   null: false
    t.string   "partner_code",      limit: 32,   null: false
    t.integer  "attempt_no",                     null: false
    t.string   "status_code",       limit: 25,   null: false
    t.string   "sm_auditable_type", limit: 255,  null: false
    t.integer  "sm_auditable_id",                null: false
    t.string   "fault_code",        limit: 255
    t.string   "fault_subcode",     limit: 50
    t.string   "fault_reason",      limit: 1000
    t.datetime "req_timestamp"
    t.datetime "rep_timestamp"
    t.text     "req_bitstream",                  null: false
    t.text     "rep_bitstream"
    t.text     "fault_bitstream"
  end

  add_index "sm_audit_logs", ["partner_code", "req_no", "attempt_no"], name: "uk_sm_audit_logs_1", unique: true
  add_index "sm_audit_logs", ["sm_auditable_type", "sm_auditable_id"], name: "uk_sm_audit_logs_2", unique: true

  create_table "sm_audit_steps", force: :cascade do |t|
    t.string   "sm_auditable_type",              null: false
    t.integer  "sm_auditable_id",                null: false
    t.integer  "step_no",                        null: false
    t.integer  "attempt_no",                     null: false
    t.string   "step_name",         limit: 100,  null: false
    t.string   "status_code",       limit: 25,   null: false
    t.string   "fault_code",        limit: 255
    t.string   "fault_subcode",     limit: 50
    t.string   "fault_reason",      limit: 1000
    t.string   "req_reference",     limit: 255
    t.datetime "req_timestamp"
    t.string   "rep_reference"
    t.datetime "rep_timestamp"
    t.text     "req_bitstream"
    t.text     "rep_bitstream"
    t.text     "fault_bitstream"
  end

  add_index "sm_audit_steps", ["sm_auditable_type", "sm_auditable_id", "step_no", "attempt_no"], name: "uk_sm_audit_steps", unique: true

  create_table "sm_bank_accounts", force: :cascade do |t|
    t.string   "sm_code",          limit: 20,               null: false
    t.string   "customer_id",      limit: 15,               null: false
    t.string   "account_no",       limit: 20,               null: false
    t.string   "mmid",             limit: 7
    t.string   "mobile_no",        limit: 10
    t.string   "created_by",       limit: 20
    t.string   "updated_by",       limit: 20
    t.datetime "created_at",                                null: false
    t.datetime "updated_at",                                null: false
    t.integer  "lock_version",                default: 0,   null: false
    t.string   "approval_status",  limit: 1,  default: "U", null: false
    t.string   "last_action",      limit: 1,  default: "C", null: false
    t.integer  "approved_version"
    t.integer  "approved_id"
    t.string   "is_enabled",       limit: 1,  default: "Y", null: false
  end

  add_index "sm_bank_accounts", ["account_no", "approval_status"], name: "sm_bank_accounts_02", unique: true
  add_index "sm_bank_accounts", ["sm_code", "customer_id", "account_no", "approval_status"], name: "sm_bank_accounts_01", unique: true

  create_table "sm_banks", force: :cascade do |t|
    t.string   "code",                 limit: 20,                null: false
    t.string   "name",                 limit: 100,               null: false
    t.string   "bank_code",            limit: 20,                null: false
    t.decimal  "low_balance_alert_at",             default: 0.0, null: false
    t.string   "identity_user_id",     limit: 20,                null: false
    t.string   "neft_allowed",         limit: 1,                 null: false
    t.string   "imps_allowed",         limit: 1,                 null: false
    t.string   "created_by",           limit: 20
    t.string   "updated_by",           limit: 20
    t.datetime "created_at",                                     null: false
    t.datetime "updated_at",                                     null: false
    t.integer  "lock_version",                     default: 0,   null: false
    t.string   "approval_status",      limit: 1,   default: "U", null: false
    t.string   "last_action",          limit: 1,   default: "C", null: false
    t.integer  "approved_version"
    t.integer  "approved_id"
    t.string   "is_enabled",           limit: 1,   default: "Y", null: false
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
    t.string   "rmtr_to_bene_note", limit: 255
    t.string   "rep_version",       limit: 20
    t.string   "rep_no",            limit: 50
    t.integer  "attempt_no"
    t.string   "transfer_type",     limit: 4
    t.string   "status_code",       limit: 50
    t.string   "bank_ref_no",       limit: 50
    t.string   "fault_code",        limit: 50
    t.string   "fault_subcode",     limit: 50
    t.string   "fault_reason",      limit: 1000
    t.datetime "rep_timestamp"
    t.string   "cbs_req_ref_no",    limit: 100
    t.datetime "reconciled_at"
  end

  add_index "sm_payments", ["partner_code", "req_no", "attempt_no"], name: "sm_payments_01", unique: true

  create_table "sm_unapproved_records", force: :cascade do |t|
    t.integer  "sm_approvable_id"
    t.string   "sm_approvable_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

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
    t.integer  "lock_version",                      default: 0
    t.string   "approval_status",       limit: 1,   default: "U"
    t.string   "last_action",           limit: 1,   default: "C"
    t.integer  "approved_version"
    t.integer  "approved_id"
    t.decimal  "max_distance_for_name"
    t.string   "customer_name",         limit: 100
    t.string   "ops_email",             limit: 100
    t.string   "rm_email",              limit: 100
  end

  add_index "su_customers", ["customer_id", "account_no", "approval_status"], name: "uk_su_customers_1", unique: true

  create_table "su_incoming_files", force: :cascade do |t|
    t.string   "file_name",             limit: 50
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
    t.integer "incoming_file_record_id"
    t.string  "file_name",               limit: 50
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
    t.integer  "su_approvable_id"
    t.string   "su_approvable_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "t1", id: false, force: :cascade do |t|
    t.decimal "a"
    t.decimal "b"
  end

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
    t.string   "id_type",                limit: 30
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

  add_synonym "pk_qg_send_email", "smtpq.pk_qg_send_email", force: true

end
