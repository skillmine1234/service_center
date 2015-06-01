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

ActiveRecord::Schema.define(version: 20150601055351) do

  create_table "active_admin_comments", force: :cascade do |t|
    t.string   "resource_id",   limit: 255, null: false
    t.string   "resource_type", limit: 255, null: false
    t.integer  "author_id"
    t.string   "author_type",   limit: 255
    t.text     "body"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.string   "namespace",     limit: 255
  end

  add_index "active_admin_comments", ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id"
  add_index "active_admin_comments", ["namespace"], name: "index_active_admin_comments_on_namespace"
  add_index "active_admin_comments", ["resource_type", "resource_id"], name: "index_admin_notes_on_resource_type_and_resource_id"

  create_table "admin_roles", force: :cascade do |t|
    t.string   "name",          limit: 255
    t.integer  "resource_id"
    t.string   "resource_type", limit: 255
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  add_index "admin_roles", ["name", "resource_type", "resource_id"], name: "index_admin_roles_on_name_and_resource_type_and_resource_id"
  add_index "admin_roles", ["name"], name: "index_admin_roles_on_name"

  create_table "admin_users", force: :cascade do |t|
    t.string   "email",                  limit: 255, default: "",    null: false
    t.string   "encrypted_password",     limit: 255, default: "",    null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                      default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.datetime "created_at",                                         null: false
    t.datetime "updated_at",                                         null: false
    t.string   "username",               limit: 255
    t.string   "unique_session_id",      limit: 20
    t.boolean  "inactive",                           default: false
    t.integer  "failed_attempts",                    default: 0
    t.string   "unlock_token",           limit: 255
    t.datetime "locked_at"
  end

  add_index "admin_users", ["email"], name: "index_admin_users_on_email", unique: true
  add_index "admin_users", ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true

  create_table "admin_users_admin_roles", id: false, force: :cascade do |t|
    t.integer "admin_user_id"
    t.integer "admin_role_id"
  end

  add_index "admin_users_admin_roles", ["admin_user_id", "admin_role_id"], name: "index_admin_users_admin_roles_on_admin_user_id_and_admin_role_id"

  create_table "attachments", force: :cascade do |t|
    t.string   "note",            limit: 255
    t.string   "file",            limit: 255
    t.integer  "attachable_id"
    t.string   "attachable_type", limit: 255
    t.string   "user_id",         limit: 255
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  add_index "attachments", ["attachable_id"], name: "index_attachments_on_attachable_id"

  create_table "audits", force: :cascade do |t|
    t.integer  "auditable_id"
    t.string   "auditable_type",  limit: 255
    t.integer  "associated_id"
    t.string   "associated_type", limit: 255
    t.integer  "user_id"
    t.string   "user_type",       limit: 255
    t.string   "username",        limit: 255
    t.string   "action",          limit: 255
    t.text     "audited_changes"
    t.integer  "version",                     default: 0
    t.string   "comment",         limit: 255
    t.string   "remote_address",  limit: 255
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
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.string   "created_by"
    t.string   "updated_by"
    t.integer  "lock_version", default: 0, null: false
  end

  create_table "delayed_jobs", force: :cascade do |t|
    t.integer  "priority",               default: 0, null: false
    t.integer  "attempts",               default: 0, null: false
    t.text     "handler",                            null: false
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by",  limit: 255
    t.string   "queue",      limit: 255
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
  end

  add_index "delayed_jobs", ["priority", "run_at"], name: "delayed_jobs_priority"

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
    t.string  "id_for",                  limit: 20,  null: false
    t.string  "id_type",                 limit: 20
    t.string  "id_number",               limit: 50
    t.string  "id_country",              limit: 255
    t.date    "id_issue_date"
    t.date    "id_expiry_date"
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
    t.integer  "lock_version",                       default: 0, null: false
    t.string   "pattern_salutations",   limit: 2000
    t.string   "pattern_remitters",     limit: 4000
  end

  create_table "inward_remittances", force: :cascade do |t|
    t.string   "req_no",                 limit: 255,  null: false
    t.string   "req_version",            limit: 10,   null: false
    t.datetime "req_timestamp",                       null: false
    t.string   "partner_code",           limit: 20,   null: false
    t.string   "rmtr_full_name",         limit: 255
    t.string   "rmtr_address1",          limit: 255
    t.string   "rmtr_address2",          limit: 255
    t.string   "rmtr_address3",          limit: 255
    t.string   "rmtr_postal_code",       limit: 255
    t.string   "rmtr_city",              limit: 255
    t.string   "rmtr_state",             limit: 255
    t.string   "rmtr_country",           limit: 255
    t.string   "rmtr_email_id",          limit: 255
    t.string   "rmtr_mobile_no",         limit: 255
    t.integer  "rmtr_identity_count",                 null: false
    t.string   "bene_full_name",         limit: 255
    t.string   "bene_address1",          limit: 255
    t.string   "bene_address2",          limit: 255
    t.string   "bene_address3",          limit: 255
    t.string   "bene_postal_code",       limit: 255
    t.string   "bene_city",              limit: 255
    t.string   "bene_state",             limit: 255
    t.string   "bene_country",           limit: 255
    t.string   "bene_email_id",          limit: 255
    t.string   "bene_mobile_no",         limit: 255
    t.integer  "bene_identity_count",                 null: false
    t.string   "bene_account_no",        limit: 255
    t.string   "bene_account_ifsc",      limit: 255
    t.string   "transfer_type",          limit: 4
    t.string   "transfer_ccy",           limit: 5
    t.float    "transfer_amount"
    t.string   "rmtr_to_bene_note",      limit: 255
    t.string   "purpose_code",           limit: 5
    t.string   "status_code",            limit: 25
    t.string   "bank_ref",               limit: 30
    t.string   "rep_no",                 limit: 255
    t.string   "rep_version",            limit: 10
    t.datetime "rep_timestamp"
    t.integer  "attempt_no",                          null: false
    t.string   "beneficiary_type",       limit: 1
    t.string   "remitter_type",          limit: 1
    t.string   "fault_code",             limit: 50
    t.string   "fault_reason",           limit: 1000
    t.string   "is_self_transfer",       limit: 1
    t.string   "is_same_party_transfer", limit: 1
    t.string   "req_transfer_type",      limit: 4
  end

  add_index "inward_remittances", ["req_no", "partner_code", "attempt_no"], name: "remittance_unique_index", unique: true

  create_table "inward_remittances_locks", id: false, force: :cascade do |t|
    t.string  "partner_code",         limit: 255
    t.integer "inward_remittance_id"
    t.string  "created_at"
  end

  create_table "partners", force: :cascade do |t|
    t.string   "code",                      limit: 20,              null: false
    t.string   "name",                      limit: 20,              null: false
    t.string   "tech_email_id",             limit: 255
    t.string   "ops_email_id",              limit: 255
    t.string   "account_no",                limit: 20,              null: false
    t.string   "account_ifsc",              limit: 20,              null: false
    t.integer  "txn_hold_period_days",                  default: 7, null: false
    t.string   "identity_user_id",          limit: 20
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
    t.datetime "created_at",                                        null: false
    t.datetime "updated_at",                                        null: false
    t.integer  "lock_version",                          default: 0, null: false
    t.string   "enabled",                   limit: 1
    t.string   "customer_id"
    t.string   "mmid"
    t.string   "mobile_no"
    t.string   "country"
    t.string   "address_line1"
    t.string   "address_line2"
    t.string   "address_line3"
  end

  create_table "purpose_codes", force: :cascade do |t|
    t.string   "code",                  limit: 5
    t.string   "description",           limit: 200
    t.string   "is_enabled",            limit: 1
    t.string   "created_by",            limit: 20
    t.string   "updated_by",            limit: 20
    t.integer  "lock_version",                       default: 0, null: false
    t.float    "txn_limit",             limit: 8
    t.integer  "daily_txn_limit"
    t.string   "disallowed_rem_types",  limit: 30
    t.string   "disallowed_bene_types", limit: 30
    t.datetime "created_at",                                     null: false
    t.datetime "updated_at",                                     null: false
    t.float    "mtd_txn_cnt_self",      limit: 8
    t.float    "mtd_txn_limit_self"
    t.float    "mtd_txn_cnt_sp",        limit: 8
    t.float    "mtd_txn_limit_sp"
    t.string   "rbi_code",              limit: 5
    t.string   "pattern_beneficiaries", limit: 4000
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
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
  end

  create_table "roles", force: :cascade do |t|
    t.string   "name",          limit: 255
    t.integer  "resource_id"
    t.string   "resource_type", limit: 255
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  add_index "roles", ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id"
  add_index "roles", ["name"], name: "index_roles_on_name"

  create_table "users", force: :cascade do |t|
    t.string   "email",                  limit: 255, default: "",    null: false
    t.string   "encrypted_password",     limit: 255, default: "",    null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                      default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.datetime "created_at",                                         null: false
    t.datetime "updated_at",                                         null: false
    t.string   "username",               limit: 255
    t.boolean  "inactive",                           default: false
    t.string   "first_name",             limit: 255
    t.string   "last_name",              limit: 255
    t.string   "unique_session_id",      limit: 20
    t.string   "mobile_no",              limit: 255
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true

  create_table "users_roles", id: false, force: :cascade do |t|
    t.integer "user_id"
    t.integer "role_id"
  end

  add_index "users_roles", ["user_id", "role_id"], name: "index_users_roles_on_user_id_and_role_id"

  create_table "whitelisted_identities", force: :cascade do |t|
    t.integer  "partner_id",                         null: false
    t.string   "full_name",              limit: 50
    t.string   "first_name",             limit: 50
    t.string   "last_name",              limit: 50
    t.string   "id_type",                limit: 20
    t.string   "id_number",              limit: 50
    t.string   "id_country",             limit: 255
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
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
  end

  add_index "whitelisted_identities", ["last_used_with_txn_id"], name: "index_whitelisted_identities_on_last_used_with_txn_id"

end
