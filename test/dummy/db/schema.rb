# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.1].define(version: 2026_08_21_100000) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.string "name", null: false
    t.bigint "record_id", null: false
    t.string "record_type", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.string "content_type"
    t.datetime "created_at", null: false
    t.string "filename", null: false
    t.string "key", null: false
    t.text "metadata"
    t.string "service_name", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "omni_account_accounts", force: :cascade do |t|
    t.boolean "allow_contra_balance"
    t.decimal "balance", precision: 12, scale: 2, default: "0.0", null: false
    t.string "code"
    t.datetime "created_at", precision: nil, null: false
    t.text "description"
    t.bigint "holder_id"
    t.string "holder_type"
    t.string "name"
    t.integer "normal_balance"
    t.bigint "parent_id"
    t.datetime "updated_at", precision: nil, null: false
    t.index ["holder_id", "holder_type", "name"], name: "index_omni_account_accounts_on_holder_and_name", unique: true
    t.index ["normal_balance"], name: "index_omni_account_accounts_on_normal_balance"
    t.index ["parent_id"], name: "index_omni_account_accounts_on_parent_id"
  end

  create_table "omni_account_entries", force: :cascade do |t|
    t.datetime "created_at", precision: nil, null: false
    t.text "description"
    t.bigint "origin_id"
    t.string "origin_type"
    t.string "uid"
    t.index ["origin_type", "origin_id"], name: "index_omni_account_entries_on_origin_type_and_origin_id"
    t.index ["uid"], name: "index_omni_account_entries_on_uid", unique: true
  end

  create_table "omni_account_postings", force: :cascade do |t|
    t.bigint "account_id"
    t.decimal "amount", precision: 12, scale: 2, null: false
    t.decimal "balance", precision: 12, scale: 2, null: false
    t.datetime "created_at", precision: nil, null: false
    t.text "description"
    t.bigint "entry_id"
    t.bigint "previous_id"
    t.index ["account_id"], name: "index_omni_account_postings_on_account_id"
    t.index ["entry_id"], name: "index_omni_account_postings_on_entry_id"
    t.index ["previous_id", "account_id"], name: "index_omni_account_postings_on_previous_and_account", unique: true
  end

  create_table "omni_article_articles", force: :cascade do |t|
    t.text "content"
    t.datetime "created_at", precision: nil, null: false
    t.jsonb "custom_settings"
    t.bigint "owner_id"
    t.string "owner_type"
    t.text "summary"
    t.string "title"
    t.string "uid"
    t.datetime "updated_at", precision: nil, null: false
    t.index ["owner_type", "owner_id"], name: "index_omni_article_articles_on_woner"
    t.index ["uid"], name: "index_omni_article_articles_on_uid", unique: true
  end

  create_table "omni_comment_comments", force: :cascade do |t|
    t.bigint "commentable_id"
    t.string "commentable_type"
    t.bigint "commenter_id"
    t.string "commenter_type"
    t.text "content"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["commentable_type", "commentable_id"], name: "index_omni_comment_comments_on_commentable"
    t.index ["commenter_type", "commenter_id"], name: "index_omni_comment_comments_on_commenter"
  end

  create_table "omni_pay_notification_recipients", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.bigint "owner_id"
    t.string "owner_type"
    t.text "remark"
    t.jsonb "settings"
    t.integer "state"
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.index ["owner_type", "owner_id", "user_id"], name: "index_omni_pay_notification_recipients_on_owner_and_user", unique: true
    t.index ["owner_type", "owner_id"], name: "index_omni_pay_notification_recipients_on_owner"
    t.index ["user_id"], name: "index_omni_pay_notification_recipients_on_user"
  end

  create_table "omni_pay_payment_methods", force: :cascade do |t|
    t.boolean "active"
    t.integer "channel_type"
    t.datetime "created_at", null: false
    t.string "label"
    t.bigint "owner_id"
    t.string "owner_type"
    t.integer "position"
    t.jsonb "settings"
    t.datetime "updated_at", null: false
    t.index ["owner_type", "owner_id"], name: "index_omni_pay_payment_methods_on_owner"
  end

  create_table "omni_pay_payment_requests", force: :cascade do |t|
    t.decimal "amount", precision: 12, scale: 2
    t.datetime "created_at", null: false
    t.bigint "created_by_id"
    t.string "created_by_type"
    t.jsonb "display_data"
    t.datetime "expires_at", precision: nil
    t.bigint "owner_id"
    t.string "owner_type"
    t.datetime "paid_at", precision: nil
    t.jsonb "settings"
    t.bigint "source_id"
    t.string "source_type"
    t.integer "state"
    t.string "title"
    t.string "uid"
    t.datetime "updated_at", null: false
    t.index ["created_by_type", "created_by_id"], name: "index_omni_pay_payment_requests_on_created_by"
    t.index ["owner_type", "owner_id"], name: "index_omni_pay_payment_requests_on_owner"
    t.index ["source_type", "source_id"], name: "index_omni_pay_payment_requests_on_source"
    t.index ["uid"], name: "index_omni_pay_payment_requests_on_uid", unique: true
  end

  create_table "omni_pay_payments", force: :cascade do |t|
    t.decimal "amount", precision: 12, scale: 2
    t.datetime "closed_at", precision: nil
    t.datetime "created_at", null: false
    t.datetime "paid_at", precision: nil
    t.string "pay_scene"
    t.bigint "payer_id"
    t.string "payer_type"
    t.bigint "payment_method_id"
    t.bigint "payment_request_id"
    t.jsonb "properties"
    t.integer "state"
    t.string "uid"
    t.datetime "updated_at", null: false
    t.index ["payer_type", "payer_id"], name: "index_omni_pay_payments_on_payer"
    t.index ["payment_method_id"], name: "index_omni_pay_payments_on_payment_method_id"
    t.index ["payment_request_id"], name: "index_omni_pay_payments_on_payment_request_id"
    t.index ["uid"], name: "index_omni_pay_payments_on_uid", unique: true
  end

  create_table "omni_pay_refunds", force: :cascade do |t|
    t.decimal "amount", precision: 12, scale: 2
    t.datetime "created_at", null: false
    t.text "description"
    t.bigint "payment_id"
    t.jsonb "properties"
    t.bigint "requested_by_id"
    t.string "requested_by_type"
    t.integer "state"
    t.datetime "success_at", precision: nil
    t.string "uid"
    t.datetime "updated_at", null: false
    t.index ["payment_id"], name: "index_omni_pay_refunds_on_payment_id"
    t.index ["requested_by_type", "requested_by_id"], name: "index_omni_pay_refunds_on_requested_by"
    t.index ["uid"], name: "index_omni_pay_refunds_on_uid", unique: true
  end

  create_table "omni_region_divisions", force: :cascade do |t|
    t.string "code"
    t.datetime "created_at", precision: nil, null: false
    t.string "name"
    t.bigint "parent_id"
    t.string "type"
    t.datetime "updated_at", precision: nil, null: false
    t.index ["code"], name: "index_omni_region_divisions_on_code", unique: true
    t.index ["parent_id"], name: "index_omni_region_divisions_on_parent_id"
  end

  create_table "omni_role_permissions", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "name", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_omni_role_permissions_on_name", unique: true
  end

  create_table "omni_role_permissions_roles", force: :cascade do |t|
    t.bigint "permission_id"
    t.bigint "role_id"
    t.index ["permission_id"], name: "index_omni_role_permissions_roles_on_permission_id"
    t.index ["role_id"], name: "index_omni_role_permissions_roles_on_role_id"
  end

  create_table "omni_role_roles", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "name", null: false
    t.bigint "resource_id"
    t.string "resource_type"
    t.datetime "updated_at", null: false
    t.index ["resource_type", "resource_id", "name"], name: "index_omni_role_roles_on_resource_and_name", unique: true
    t.index ["resource_type", "resource_id"], name: "index_omni_role_roles_on_resource"
  end

  create_table "omni_role_user_role_maps", force: :cascade do |t|
    t.bigint "role_id"
    t.bigint "user_id"
    t.string "user_type"
    t.index ["role_id"], name: "index_omni_role_user_role_maps_on_role_id"
    t.index ["user_type", "user_id"], name: "index_omni_role_user_role_maps_on_user"
  end

  create_table "org_content_entries", force: :cascade do |t|
    t.text "content"
    t.datetime "created_at", null: false
    t.integer "entry_name"
    t.bigint "organization_id"
    t.integer "position"
    t.string "title"
    t.datetime "updated_at", null: false
    t.index ["organization_id", "entry_name"], name: "index_org_content_entry_on_org_and_name"
    t.index ["organization_id"], name: "index_org_content_entries_on_organization_id"
  end

  create_table "org_departments", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.integer "depth", default: 0, null: false
    t.integer "lft", null: false
    t.string "name"
    t.bigint "organization_id"
    t.integer "parent_id"
    t.integer "rgt", null: false
    t.datetime "updated_at", null: false
    t.index ["lft"], name: "index_org_departments_on_lft"
    t.index ["organization_id", "name"], name: "index_org_departments_on_organization_id_and_name", unique: true
    t.index ["organization_id"], name: "index_org_departments_on_organization_id"
    t.index ["parent_id"], name: "index_org_departments_on_parent_id"
    t.index ["rgt"], name: "index_org_departments_on_rgt"
  end

  create_table "org_organization_wechat_official_account_mappings", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.bigint "organization_id", null: false
    t.datetime "updated_at", null: false
    t.bigint "wechat_official_account_id", null: false
    t.index ["organization_id"], name: "index_org_organization_wechat_oa_mappings_on_org", unique: true
    t.index ["wechat_official_account_id"], name: "index_org_organization_wechat_oa_mappings_on_wechat_oa"
  end

  create_table "org_organization_wechat_sp_vendor_mappings", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.bigint "organization_id", null: false
    t.datetime "updated_at", null: false
    t.bigint "wechat_sp_vendor_id", null: false
    t.index ["organization_id"], name: "index_org_organization_wechat_sp_vendor_mappings_on_org", unique: true
    t.index ["wechat_sp_vendor_id"], name: "index_org_organization_wechat_sp_vendor_mappings_on_vendor"
  end

  create_table "org_organizations", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.jsonb "custom_settings", default: {}
    t.string "name", null: false
    t.string "uid"
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_org_organizations_on_name", unique: true
    t.index ["uid"], name: "index_org_organizations_on_uid", unique: true
  end

  create_table "org_phones", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "number"
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.index ["number"], name: "index_org_phones_on_number", unique: true
    t.index ["user_id"], name: "index_org_phones_on_user_id", unique: true
  end

  create_table "org_profiles", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.jsonb "custom_settings"
    t.datetime "last_sign_in_at"
    t.string "locale"
    t.string "nickname"
    t.string "otp_key"
    t.string "time_zone"
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.index ["user_id"], name: "index_org_profiles_on_user_id", unique: true
  end

  create_table "org_user_credentials", force: :cascade do |t|
    t.string "code"
    t.datetime "created_at", null: false
    t.string "token"
    t.datetime "updated_at", null: false
    t.string "user_agent"
    t.bigint "user_id"
    t.index ["code"], name: "index_org_user_credentials_on_code", unique: true
    t.index ["token"], name: "index_org_user_credentials_on_token", unique: true
    t.index ["user_id"], name: "index_org_user_credentials_on_user_id"
  end

  create_table "org_users", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.bigint "department_id"
    t.string "name"
    t.bigint "organization_id", null: false
    t.string "password_digest"
    t.boolean "root"
    t.datetime "updated_at", null: false
    t.index ["department_id"], name: "index_org_users_on_department_id"
    t.index ["name"], name: "index_org_users_on_name", unique: true, where: "(root = true)"
    t.index ["organization_id", "name"], name: "index_org_users_on_organization_id_and_name", unique: true
    t.index ["organization_id"], name: "index_org_users_on_organization_id"
    t.index ["organization_id"], name: "index_org_users_on_organization_id_where_root", unique: true, where: "(root = true)"
  end

  create_table "owx_message_handlers", force: :cascade do |t|
    t.datetime "created_at", precision: nil, null: false
    t.string "name", null: false
    t.bigint "official_account_id"
    t.datetime "updated_at", precision: nil, null: false
    t.index ["official_account_id"], name: "index_owx_message_handlers_on_official_account_id", unique: true
  end

  create_table "owx_official_accounts", force: :cascade do |t|
    t.string "alias"
    t.string "app_id"
    t.jsonb "business_info"
    t.datetime "created_at", precision: nil, null: false
    t.jsonb "func_info"
    t.string "head_img"
    t.jsonb "mini_program_info"
    t.string "nick_name"
    t.bigint "open_account_id"
    t.string "original_id"
    t.string "principal_name"
    t.string "qrcode_url"
    t.string "refresh_token"
    t.jsonb "service_type_info"
    t.string "signature"
    t.bigint "third_party_platform_id"
    t.datetime "updated_at", precision: nil, null: false
    t.jsonb "verify_type_info"
    t.index ["open_account_id"], name: "index_owx_official_accounts_on_open_account_id"
    t.index ["third_party_platform_id", "app_id"], name: "index_owx_official_accounts_on_platform_and_app_id", unique: true
    t.index ["third_party_platform_id", "original_id"], name: "index_owx_official_accounts_on_platform_and_original_id", unique: true
    t.index ["third_party_platform_id"], name: "index_owx_official_accounts_on_third_party_platform_id"
  end

  create_table "owx_open_accounts", force: :cascade do |t|
    t.string "app_id"
    t.datetime "created_at", null: false
    t.string "principal_name"
    t.bigint "third_party_platform_id"
    t.datetime "updated_at", null: false
    t.index ["app_id"], name: "index_owx_open_accounts_on_app_id", unique: true
    t.index ["principal_name"], name: "index_owx_open_accounts_on_principal_name", unique: true
    t.index ["third_party_platform_id"], name: "index_owx_open_accounts_on_third_party_platform_id"
  end

  create_table "owx_third_party_platforms", force: :cascade do |t|
    t.string "app_id"
    t.string "app_secret"
    t.datetime "created_at", precision: nil, null: false
    t.string "message_encryption_key"
    t.string "messages_checking_token"
    t.string "name"
    t.string "uid"
    t.datetime "updated_at", precision: nil, null: false
    t.index ["app_id"], name: "index_owx_third_party_platforms_on_app_id", unique: true
    t.index ["uid"], name: "index_owx_third_party_platforms_on_uid", unique: true
  end

  create_table "owx_verify_files", force: :cascade do |t|
    t.text "content"
    t.datetime "created_at", null: false
    t.string "name"
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_owx_verify_files_on_name", unique: true
  end

  create_table "owx_website_apps", force: :cascade do |t|
    t.string "app_id"
    t.string "app_secret"
    t.datetime "created_at", null: false
    t.string "name"
    t.datetime "updated_at", null: false
    t.index ["app_id"], name: "index_owx_website_apps_on_app_id", unique: true
  end

  create_table "short_url_links", force: :cascade do |t|
    t.datetime "created_at", precision: nil, null: false
    t.text "original_url"
    t.index ["original_url"], name: "index_short_url_links_on_original_url", unique: true
  end

  create_table "taggings", force: :cascade do |t|
    t.string "context", limit: 128
    t.datetime "created_at", precision: nil
    t.bigint "tag_id"
    t.bigint "taggable_id"
    t.string "taggable_type"
    t.bigint "tagger_id"
    t.string "tagger_type"
    t.index ["context"], name: "index_taggings_on_context"
    t.index ["tag_id", "taggable_id", "taggable_type", "context", "tagger_id", "tagger_type"], name: "taggings_idx", unique: true
    t.index ["tag_id"], name: "index_taggings_on_tag_id"
    t.index ["taggable_id", "taggable_type", "context"], name: "taggings_taggable_context_idx"
    t.index ["taggable_id", "taggable_type", "tagger_id", "context"], name: "taggings_idy"
    t.index ["taggable_id"], name: "index_taggings_on_taggable_id"
    t.index ["taggable_type", "taggable_id"], name: "index_taggings_on_taggable_type_and_taggable_id"
    t.index ["taggable_type"], name: "index_taggings_on_taggable_type"
    t.index ["tagger_id", "tagger_type"], name: "index_taggings_on_tagger_id_and_tagger_type"
    t.index ["tagger_id"], name: "index_taggings_on_tagger_id"
    t.index ["tagger_type", "tagger_id"], name: "index_taggings_on_tagger_type_and_tagger_id"
  end

  create_table "tags", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "name"
    t.integer "taggings_count", default: 0
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_tags_on_name", unique: true
  end

  create_table "tnt_domains", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "name"
    t.bigint "tenant_id"
    t.datetime "updated_at", null: false
    t.string "wechat_app_id"
    t.string "wechat_app_secret"
    t.index ["tenant_id"], name: "index_tnt_domains_on_tenant_id", unique: true
  end

  create_table "tnt_fund_transfers", force: :cascade do |t|
    t.decimal "amount", precision: 2, scale: 2
    t.datetime "created_at", null: false
    t.text "description"
    t.integer "state"
    t.bigint "tenant_id"
    t.bigint "transfer_in_account_id"
    t.bigint "transfer_out_account_id"
    t.string "uid", null: false
    t.datetime "updated_at", null: false
    t.index ["tenant_id"], name: "index_tnt_fund_transfers_on_tenant_id"
    t.index ["transfer_in_account_id"], name: "index_tnt_fund_transfers_on_transfer_in_account_id"
    t.index ["transfer_out_account_id"], name: "index_tnt_fund_transfers_on_transfer_out_account_id"
    t.index ["uid"], name: "index_tnt_fund_transfers_on_uid", unique: true
  end

  create_table "tnt_impersonations", force: :cascade do |t|
    t.bigint "actor_id"
    t.string "actor_type"
    t.datetime "created_at", null: false
    t.datetime "ended_at"
    t.string "ended_ip"
    t.datetime "expires_at"
    t.integer "lock_version", default: 0
    t.datetime "started_at"
    t.string "started_ip"
    t.bigint "target_user_id"
    t.bigint "tenant_id"
    t.datetime "updated_at", null: false
    t.text "user_agent"
    t.index ["actor_type", "actor_id", "ended_at"], name: "idx_on_actor_type_actor_id_ended_at_da7d110a23"
    t.index ["target_user_id", "ended_at"], name: "index_tnt_impersonations_on_target_user_id_and_ended_at"
  end

  create_table "tnt_phones", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "number"
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.index ["number"], name: "index_tnt_phones_on_number", unique: true
    t.index ["user_id"], name: "index_tnt_phones_on_user_id", unique: true
  end

  create_table "tnt_profiles", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.jsonb "custom_settings", default: {}
    t.datetime "last_sign_in_at"
    t.string "locale"
    t.string "nickname"
    t.string "time_zone"
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.index ["user_id"], name: "index_tnt_profiles_on_user_id", unique: true
  end

  create_table "tnt_recharges", force: :cascade do |t|
    t.decimal "amount", precision: 12, scale: 2
    t.datetime "created_at", null: false
    t.jsonb "properties"
    t.integer "state"
    t.bigint "tenant_id", null: false
    t.string "uid"
    t.datetime "updated_at", null: false
    t.index ["tenant_id"], name: "index_tnt_recharges_on_tenant_id"
    t.index ["uid"], name: "index_tnt_recharges_on_uid", unique: true
  end

  create_table "tnt_tenant_ext_infos", force: :cascade do |t|
    t.string "content_quick_tags", default: [], array: true
    t.datetime "created_at", null: false
    t.datetime "expires_at"
    t.integer "implicit_auth_mode"
    t.string "permissions", default: [], array: true
    t.bigint "tenant_id"
    t.datetime "updated_at", null: false
    t.integer "wechat_oauth_scope"
    t.index ["tenant_id"], name: "index_tnt_tenant_ext_infos_on_tenant_id", unique: true
  end

  create_table "tnt_tenant_wechat_official_account_mappings", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.bigint "tenant_id", null: false
    t.datetime "updated_at", null: false
    t.bigint "wechat_official_account_id", null: false
    t.index ["tenant_id"], name: "index_tnt_tenant_wechat_oa_mapping_on_tennat", unique: true
    t.index ["wechat_official_account_id"], name: "index_tnt_tenant_wechat_oa_mapping_on_wechat_oa"
  end

  create_table "tnt_tenant_wechat_work_corporation_mappings", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.bigint "tenant_id", null: false
    t.datetime "updated_at", null: false
    t.bigint "wechat_work_corporation_id", null: false
    t.index ["tenant_id"], name: "index_tnt_tenant_wecom_corp_mapping_on_tennat", unique: true
    t.index ["wechat_work_corporation_id"], name: "index_tnt_tenant_wecom_corp_mapping_on_corp"
  end

  create_table "tnt_tenants", force: :cascade do |t|
    t.bigint "agency_id"
    t.datetime "created_at", null: false
    t.jsonb "custom_settings", default: {}
    t.string "name"
    t.bigint "organization_id", null: false
    t.integer "state"
    t.string "uid"
    t.datetime "updated_at", null: false
    t.index ["agency_id"], name: "index_tnt_tenants_on_agency_id"
    t.index ["name"], name: "index_tnt_tenants_on_name", unique: true
    t.index ["organization_id"], name: "index_tnt_tenants_on_organization_id"
    t.index ["uid"], name: "index_tnt_tenants_on_uid", unique: true
  end

  create_table "tnt_user_credentials", force: :cascade do |t|
    t.string "code"
    t.datetime "created_at", null: false
    t.string "token"
    t.datetime "updated_at", null: false
    t.string "user_agent"
    t.bigint "user_id"
    t.index ["code"], name: "index_tnt_user_credentials_on_code", unique: true
    t.index ["token"], name: "index_tnt_user_credentials_on_token", unique: true
    t.index ["user_id"], name: "index_tnt_user_credentials_on_user_id"
  end

  create_table "tnt_user_wechat_work_user_mappings", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.bigint "wechat_work_user_id"
    t.index ["user_id"], name: "index_tnt_user_wechat_work_user_mappings_on_user_id", unique: true
    t.index ["wechat_work_user_id"], name: "idx_on_wechat_work_user_id_3760b0abb6", unique: true
  end

  create_table "tnt_users", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "name"
    t.string "password_digest"
    t.boolean "root"
    t.integer "state"
    t.bigint "tenant_id", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_tnt_users_on_name", unique: true, where: "(root = true)"
    t.index ["tenant_id", "name"], name: "index_tnt_users_on_tenant_id_and_name", unique: true
    t.index ["tenant_id", "state"], name: "index_tnt_users_on_tenant_id_and_state"
    t.index ["tenant_id"], name: "index_tnt_users_on_tenant_id"
  end

  create_table "tnt_withdraw_settings", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.jsonb "custom_settings", default: {}
    t.integer "payment_method"
    t.string "real_name"
    t.bigint "tenant_id"
    t.datetime "updated_at", null: false
    t.index ["tenant_id"], name: "index_tnt_withdraw_settings_on_tenant_id", unique: true
  end

  create_table "tnt_withdrawals", force: :cascade do |t|
    t.bigint "account_id", null: false
    t.decimal "amount", precision: 12, scale: 2
    t.datetime "created_at", null: false
    t.text "description"
    t.integer "state"
    t.bigint "tenant_id", null: false
    t.string "uid"
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_tnt_withdrawals_on_account_id"
    t.index ["tenant_id"], name: "index_tnt_withdrawals_on_tenant_id"
    t.index ["uid"], name: "index_tnt_withdrawals_on_uid", unique: true
  end

  create_table "usr_emails", force: :cascade do |t|
    t.string "address", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["address"], name: "index_usr_emails_on_address", unique: true
  end

  create_table "usr_identity_cards", force: :cascade do |t|
    t.string "code"
    t.datetime "created_at", null: false
    t.jsonb "custom_settings"
    t.integer "state"
    t.string "uid"
    t.datetime "updated_at", null: false
    t.index ["code"], name: "index_usr_identity_cards_on_code", unique: true
    t.index ["uid"], name: "index_usr_identity_cards_on_uid", unique: true
  end

  create_table "usr_locations", force: :cascade do |t|
    t.float "accuracy"
    t.string "address"
    t.string "city"
    t.string "coordinate_type"
    t.datetime "created_at", null: false
    t.string "district"
    t.string "division_code"
    t.float "latitude"
    t.float "longitude"
    t.string "province"
    t.float "speed"
    t.string "street"
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.index ["user_id"], name: "index_usr_locations_on_user_id"
  end

  create_table "usr_phones", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "number", null: false
    t.datetime "updated_at", null: false
    t.index ["number"], name: "index_usr_phones_on_number", unique: true
  end

  create_table "usr_profiles", force: :cascade do |t|
    t.date "birthday"
    t.datetime "created_at", null: false
    t.jsonb "custom_settings"
    t.integer "gender"
    t.datetime "last_sign_in_at"
    t.string "locale"
    t.string "nickname"
    t.string "time_zone"
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.index ["user_id"], name: "index_usr_profiles_on_user_id", unique: true
  end

  create_table "usr_shipping_addresses", force: :cascade do |t|
    t.string "city_code"
    t.string "consignee_name"
    t.string "consignee_tel"
    t.datetime "created_at", null: false
    t.boolean "default", default: false, null: false
    t.string "detail_info"
    t.string "district_code"
    t.string "postal_code"
    t.string "province_code"
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.index ["user_id"], name: "index_usr_shipping_addresses_on_user_id"
  end

  create_table "usr_user_credentials", force: :cascade do |t|
    t.string "code"
    t.datetime "created_at", null: false
    t.string "token"
    t.datetime "updated_at", null: false
    t.string "user_agent"
    t.bigint "user_id"
    t.index ["code"], name: "index_usr_user_credentials_on_code", unique: true
    t.index ["token"], name: "index_usr_user_credentials_on_token", unique: true
    t.index ["user_id"], name: "index_usr_user_credentials_on_user_id"
  end

  create_table "usr_user_delegations", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.jsonb "custom_settings"
    t.bigint "principal_user_id"
    t.bigint "target_user_id"
    t.datetime "updated_at", null: false
    t.index ["principal_user_id", "target_user_id"], name: "index_usr_user_delegations_on_principal_and_target", unique: true
    t.index ["principal_user_id"], name: "index_usr_user_delegations_on_principal_user_id"
    t.index ["target_user_id"], name: "index_usr_user_delegations_on_target_user_id"
  end

  create_table "usr_user_origins", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.bigint "origin_id"
    t.string "origin_type"
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.index ["origin_type", "origin_id"], name: "index_usr_user_origins_on_origin"
    t.index ["user_id", "origin_id", "origin_type"], name: "index_usr_user_origins_on_user_and_origin", unique: true
    t.index ["user_id"], name: "index_usr_user_origins_on_user_id"
  end

  create_table "usr_users", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "name"
    t.string "password_digest"
    t.string "uid", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_usr_users_on_name", unique: true
    t.index ["uid"], name: "index_usr_users_on_uid", unique: true
  end

  create_table "usr_wechat_users", force: :cascade do |t|
    t.string "app_id"
    t.string "auth_scope"
    t.string "avatar_url"
    t.datetime "created_at", null: false
    t.string "nickname"
    t.string "open_id", null: false
    t.string "refresh_token"
    t.boolean "subscribe"
    t.string "subscribe_scene"
    t.datetime "subscribed_at", precision: nil
    t.string "union_id"
    t.datetime "updated_at", null: false
    t.index ["app_id"], name: "index_usr_wechat_users_on_app_id"
    t.index ["open_id"], name: "index_usr_wechat_users_on_open_id", unique: true
    t.index ["union_id"], name: "index_usr_wechat_users_on_union_id"
  end

  create_table "usr_withdrawals", force: :cascade do |t|
    t.bigint "account_id"
    t.decimal "amount", precision: 12, scale: 2
    t.datetime "created_at", null: false
    t.text "description"
    t.integer "state"
    t.string "uid"
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_usr_withdrawals_on_account_id"
    t.index ["uid"], name: "index_usr_withdrawals_on_uid", unique: true
  end

  create_table "wxpay_api_client_certificates", force: :cascade do |t|
    t.text "cert"
    t.datetime "created_at", null: false
    t.datetime "effective_at"
    t.datetime "expire_at"
    t.text "key"
    t.string "serial_no"
    t.datetime "updated_at", null: false
    t.bigint "vendor_id"
    t.index ["vendor_id"], name: "index_wxpay_api_client_certificates_on_vendor_id"
  end

  create_table "wxpay_busifavor_coupons", force: :cascade do |t|
    t.string "app_id"
    t.datetime "available_start_time"
    t.string "code"
    t.string "comment"
    t.jsonb "coupon_use_rule"
    t.datetime "created_at", null: false
    t.string "deactivate_reason"
    t.string "deactivate_request_no"
    t.datetime "deactivate_time"
    t.datetime "expire_time"
    t.string "goods_name"
    t.string "open_id"
    t.bigint "origin_id"
    t.string "origin_type"
    t.datetime "receive_time"
    t.string "return_request_no"
    t.datetime "return_time"
    t.string "send_request_no"
    t.integer "state"
    t.string "stock_id"
    t.string "stock_name"
    t.integer "stock_type"
    t.datetime "updated_at", null: false
    t.string "use_request_no"
    t.datetime "use_time"
    t.index ["code"], name: "index_wxpay_busifavor_coupons_on_code", unique: true
    t.index ["origin_type", "origin_id"], name: "index_wxpay_busifavor_coupons_on_origin", unique: true
    t.index ["send_request_no"], name: "index_wxpay_busifavor_coupons_on_send_request_no", unique: true
    t.index ["stock_id"], name: "index_wxpay_busifavor_coupons_on_stock_id"
    t.index ["use_request_no"], name: "index_wxpay_busifavor_coupons_on_use_request_no", unique: true
  end

  create_table "wxpay_busifavor_stocks", force: :cascade do |t|
    t.string "belong_merchant"
    t.string "comment"
    t.integer "coupon_code_mode"
    t.jsonb "coupon_use_rule"
    t.datetime "created_at", null: false
    t.jsonb "custom_entrance"
    t.jsonb "display_pattern_info"
    t.string "goods_name"
    t.jsonb "notify_config"
    t.bigint "origin_id"
    t.string "origin_type"
    t.string "out_request_no"
    t.jsonb "send_count_information"
    t.integer "state"
    t.string "stock_id"
    t.string "stock_name"
    t.jsonb "stock_send_rule"
    t.integer "stock_type"
    t.datetime "updated_at", null: false
    t.index ["belong_merchant"], name: "index_wxpay_busifavor_stocks_on_belong_merchant"
    t.index ["origin_type", "origin_id"], name: "index_wxpay_busifavor_stocks_on_origin", unique: true
    t.index ["out_request_no"], name: "index_wxpay_busifavor_stocks_on_out_request_no", unique: true
    t.index ["stock_id"], name: "index_wxpay_busifavor_stocks_on_stock_id", unique: true
  end

  create_table "wxpay_capital_bank_branches", force: :cascade do |t|
    t.string "bank_alias_code"
    t.string "bank_branch_id"
    t.string "bank_branch_name"
    t.string "city_code"
    t.string "city_name"
    t.datetime "created_at", null: false
    t.string "province_code"
    t.string "province_name"
    t.datetime "updated_at", null: false
    t.index ["bank_alias_code"], name: "index_wxpay_capital_bank_branches_on_bank_alias_code"
  end

  create_table "wxpay_capital_corporate_banks", force: :cascade do |t|
    t.string "account_bank"
    t.integer "account_bank_code"
    t.string "bank_alias"
    t.string "bank_alias_code"
    t.datetime "created_at", null: false
    t.boolean "need_bank_branch"
    t.datetime "updated_at", null: false
  end

  create_table "wxpay_capital_personal_banks", force: :cascade do |t|
    t.string "account_bank"
    t.integer "account_bank_code"
    t.string "bank_alias"
    t.string "bank_alias_code"
    t.datetime "created_at", null: false
    t.boolean "need_bank_branch"
    t.datetime "updated_at", null: false
  end

  create_table "wxpay_ecommerce_applyments", force: :cascade do |t|
    t.jsonb "account_info"
    t.jsonb "account_validation"
    t.string "applyment_id"
    t.jsonb "audit_detail"
    t.text "business_addition_desc"
    t.jsonb "business_addition_pics"
    t.jsonb "business_license_info"
    t.jsonb "contact_info"
    t.datetime "created_at", null: false
    t.jsonb "id_card_info"
    t.string "legal_validation_url"
    t.string "merchant_shortname"
    t.boolean "need_account_info"
    t.integer "organization_type"
    t.string "out_request_no"
    t.bigint "owner_id"
    t.string "owner_type"
    t.jsonb "qualifications"
    t.jsonb "sales_scene_info"
    t.string "sign_state"
    t.string "sign_url"
    t.integer "state"
    t.text "state_desc"
    t.string "sub_mch_id"
    t.datetime "updated_at", null: false
    t.index ["out_request_no"], name: "index_wxpay_ecommerce_applyments_on_out_request_no", unique: true
    t.index ["owner_type", "owner_id"], name: "index_wxpay_ecommerce_applyments_on_owner"
  end

  create_table "wxpay_partner_applyments", force: :cascade do |t|
    t.jsonb "addition_info"
    t.string "applyment_id"
    t.jsonb "audit_detail"
    t.jsonb "bank_account_info"
    t.string "business_code"
    t.jsonb "business_info"
    t.jsonb "contact_info"
    t.datetime "created_at", null: false
    t.bigint "owner_id"
    t.string "owner_type"
    t.jsonb "settlement_info"
    t.string "sign_url"
    t.integer "state"
    t.text "state_message"
    t.string "sub_mch_id"
    t.jsonb "subject_info"
    t.datetime "updated_at", null: false
    t.index ["business_code"], name: "index_wxpay_partner_applyments_on_business_code", unique: true
    t.index ["owner_type", "owner_id"], name: "index_wxpay_sub_applyments_on_owner"
  end

  create_table "wxpay_platform_certificates", force: :cascade do |t|
    t.text "cert"
    t.datetime "created_at", null: false
    t.datetime "effective_at"
    t.datetime "expire_at"
    t.string "serial_no"
    t.datetime "updated_at", null: false
    t.bigint "vendor_id"
    t.index ["vendor_id"], name: "index_wxpay_platform_certificates_on_vendor_id"
  end

  create_table "wxpay_profit_sharing_receivers", force: :cascade do |t|
    t.string "account"
    t.integer "account_type"
    t.string "app_id"
    t.datetime "created_at", null: false
    t.string "custom_relation"
    t.string "name"
    t.integer "relation_type"
    t.datetime "updated_at", null: false
    t.bigint "vendor_id"
    t.index ["account", "vendor_id", "app_id"], name: "index_wxpay_profit_sharing_receivers_on_vendor_app_account", unique: true
    t.index ["vendor_id"], name: "index_wxpay_profit_sharing_receivers_on_vendor_id"
  end

  create_table "wxpay_public_keys", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "key_id"
    t.text "pem"
    t.datetime "updated_at", null: false
    t.bigint "vendor_id"
    t.index ["vendor_id", "key_id"], name: "index_wxpay_public_keys_on_vendor_id_and_key_id", unique: true
    t.index ["vendor_id"], name: "index_wxpay_public_keys_on_vendor_id"
  end

  create_table "wxpay_settlement_accounts", force: :cascade do |t|
    t.string "account_bank"
    t.string "account_number"
    t.string "account_type"
    t.string "bank_address_code"
    t.string "bank_branch_id"
    t.string "bank_name"
    t.datetime "created_at", null: false
    t.integer "state"
    t.string "sub_mch_id"
    t.datetime "updated_at", null: false
    t.text "verify_fail_reason"
    t.string "verify_result"
    t.index ["sub_mch_id"], name: "index_wxpay_settlement_accounts_on_sub_mch_id"
  end

  create_table "wxpay_vendors", force: :cascade do |t|
    t.text "comment"
    t.datetime "created_at", precision: nil, null: false
    t.decimal "fee_rate", precision: 4, scale: 4
    t.string "mch_id"
    t.string "sp_mch_id"
    t.integer "type"
    t.datetime "updated_at", precision: nil, null: false
    t.string "v2_key"
    t.string "v3_key"
    t.index ["mch_id"], name: "index_wxpay_vendors_on_mch_id", unique: true
    t.index ["sp_mch_id"], name: "index_wxpay_vendors_on_sp_mch_id"
  end

  create_table "wxpay_verify_files", force: :cascade do |t|
    t.text "content"
    t.datetime "created_at", null: false
    t.string "name"
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_wxpay_verify_files_on_name", unique: true
  end
end
