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

ActiveRecord::Schema[8.0].define(version: 2026_02_28_093000) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "omni_account_accounts", force: :cascade do |t|
    t.string "holder_type"
    t.bigint "holder_id"
    t.string "name"
    t.integer "normal_balance"
    t.decimal "balance", precision: 12, scale: 2, default: "0.0", null: false
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.string "code"
    t.text "description"
    t.bigint "parent_id"
    t.index ["holder_id", "holder_type", "name"], name: "index_omni_account_accounts_on_holder_and_name", unique: true
    t.index ["normal_balance"], name: "index_omni_account_accounts_on_normal_balance"
    t.index ["parent_id"], name: "index_omni_account_accounts_on_parent_id"
  end

  create_table "omni_account_entries", force: :cascade do |t|
    t.string "origin_type"
    t.bigint "origin_id"
    t.string "uid"
    t.text "description"
    t.datetime "created_at", precision: nil, null: false
    t.index ["origin_type", "origin_id"], name: "index_omni_account_entries_on_origin_type_and_origin_id"
    t.index ["uid"], name: "index_omni_account_entries_on_uid", unique: true
  end

  create_table "omni_account_postings", force: :cascade do |t|
    t.bigint "account_id"
    t.bigint "entry_id"
    t.bigint "previous_id"
    t.decimal "amount", precision: 12, scale: 2, null: false
    t.decimal "balance", precision: 12, scale: 2, null: false
    t.text "description"
    t.datetime "created_at", precision: nil, null: false
    t.index ["account_id"], name: "index_omni_account_postings_on_account_id"
    t.index ["entry_id"], name: "index_omni_account_postings_on_entry_id"
    t.index ["previous_id", "account_id"], name: "index_omni_account_postings_on_previous_and_account", unique: true
  end

  create_table "omni_article_articles", force: :cascade do |t|
    t.string "owner_type"
    t.bigint "owner_id"
    t.string "title"
    t.text "content"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.string "uid"
    t.text "summary"
    t.index ["owner_type", "owner_id"], name: "index_omni_article_articles_on_woner"
    t.index ["uid"], name: "index_omni_article_articles_on_uid", unique: true
  end

  create_table "omni_comment_comments", force: :cascade do |t|
    t.string "commentable_type"
    t.bigint "commentable_id"
    t.string "commenter_type"
    t.bigint "commenter_id"
    t.text "content"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["commentable_type", "commentable_id"], name: "index_omni_comment_comments_on_commentable"
    t.index ["commenter_type", "commenter_id"], name: "index_omni_comment_comments_on_commenter"
  end

  create_table "omni_pay_payment_methods", force: :cascade do |t|
    t.string "owner_type"
    t.bigint "owner_id"
    t.integer "channel_type"
    t.boolean "active"
    t.integer "position"
    t.jsonb "settings"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["owner_type", "owner_id"], name: "index_omni_pay_payment_methods_on_owner"
  end

  create_table "omni_region_divisions", force: :cascade do |t|
    t.string "type"
    t.bigint "parent_id"
    t.string "code"
    t.string "name"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["code"], name: "index_omni_region_divisions_on_code", unique: true
    t.index ["parent_id"], name: "index_omni_region_divisions_on_parent_id"
  end

  create_table "omni_role_permissions", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
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
    t.string "name", null: false
    t.string "resource_type"
    t.bigint "resource_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["resource_type", "resource_id", "name"], name: "index_omni_role_roles_on_resource_and_name", unique: true
    t.index ["resource_type", "resource_id"], name: "index_omni_role_roles_on_resource"
  end

  create_table "omni_role_user_role_maps", force: :cascade do |t|
    t.string "user_type"
    t.bigint "user_id"
    t.bigint "role_id"
    t.index ["role_id"], name: "index_omni_role_user_role_maps_on_role_id"
    t.index ["user_type", "user_id"], name: "index_omni_role_user_role_maps_on_user"
  end

  create_table "org_content_entries", force: :cascade do |t|
    t.bigint "organization_id"
    t.integer "entry_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "title"
    t.text "content"
    t.integer "position"
    t.index ["organization_id", "entry_name"], name: "index_org_content_entry_on_org_and_name"
    t.index ["organization_id"], name: "index_org_content_entries_on_organization_id"
  end

  create_table "org_departments", force: :cascade do |t|
    t.bigint "organization_id"
    t.string "name"
    t.integer "parent_id"
    t.integer "lft", null: false
    t.integer "rgt", null: false
    t.integer "depth", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["lft"], name: "index_org_departments_on_lft"
    t.index ["organization_id", "name"], name: "index_org_departments_on_organization_id_and_name", unique: true
    t.index ["organization_id"], name: "index_org_departments_on_organization_id"
    t.index ["parent_id"], name: "index_org_departments_on_parent_id"
    t.index ["rgt"], name: "index_org_departments_on_rgt"
  end

  create_table "org_organization_wechat_official_account_mappings", force: :cascade do |t|
    t.bigint "organization_id", null: false
    t.bigint "wechat_official_account_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["organization_id"], name: "index_org_organization_wechat_oa_mappings_on_org", unique: true
    t.index ["wechat_official_account_id"], name: "index_org_organization_wechat_oa_mappings_on_wechat_oa"
  end

  create_table "org_organization_wechat_sp_vendor_mappings", force: :cascade do |t|
    t.bigint "organization_id", null: false
    t.bigint "wechat_sp_vendor_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["organization_id"], name: "index_org_organization_wechat_sp_vendor_mappings_on_org", unique: true
    t.index ["wechat_sp_vendor_id"], name: "index_org_organization_wechat_sp_vendor_mappings_on_vendor"
  end

  create_table "org_organizations", force: :cascade do |t|
    t.string "name", null: false
    t.jsonb "custom_settings", default: {}
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "uid"
    t.index ["name"], name: "index_org_organizations_on_name", unique: true
    t.index ["uid"], name: "index_org_organizations_on_uid", unique: true
  end

  create_table "org_phones", force: :cascade do |t|
    t.bigint "user_id"
    t.string "number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["number"], name: "index_org_phones_on_number", unique: true
    t.index ["user_id"], name: "index_org_phones_on_user_id", unique: true
  end

  create_table "org_profiles", force: :cascade do |t|
    t.bigint "user_id"
    t.string "nickname"
    t.string "locale"
    t.string "time_zone"
    t.datetime "last_sign_in_at"
    t.jsonb "custom_settings"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "otp_key"
    t.index ["user_id"], name: "index_org_profiles_on_user_id", unique: true
  end

  create_table "org_user_credentials", force: :cascade do |t|
    t.bigint "user_id"
    t.string "user_agent"
    t.string "code"
    t.string "token"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["code"], name: "index_org_user_credentials_on_code", unique: true
    t.index ["token"], name: "index_org_user_credentials_on_token", unique: true
    t.index ["user_id"], name: "index_org_user_credentials_on_user_id"
  end

  create_table "org_users", force: :cascade do |t|
    t.bigint "organization_id", null: false
    t.bigint "department_id"
    t.string "name"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["department_id"], name: "index_org_users_on_department_id"
    t.index ["name"], name: "index_org_users_on_name", unique: true
    t.index ["organization_id"], name: "index_org_users_on_organization_id"
  end

  create_table "owx_message_handlers", force: :cascade do |t|
    t.bigint "official_account_id"
    t.string "name", null: false
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["official_account_id"], name: "index_owx_message_handlers_on_official_account_id", unique: true
  end

  create_table "owx_official_accounts", force: :cascade do |t|
    t.bigint "third_party_platform_id"
    t.string "refresh_token"
    t.string "app_id"
    t.string "original_id"
    t.string "nick_name"
    t.string "head_img"
    t.string "qrcode_url"
    t.string "principal_name"
    t.jsonb "service_type_info"
    t.jsonb "verify_type_info"
    t.jsonb "business_info"
    t.string "alias"
    t.string "signature"
    t.jsonb "mini_program_info"
    t.jsonb "func_info"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.bigint "open_account_id"
    t.index ["open_account_id"], name: "index_owx_official_accounts_on_open_account_id"
    t.index ["third_party_platform_id", "app_id"], name: "index_owx_official_accounts_on_platform_and_app_id", unique: true
    t.index ["third_party_platform_id", "original_id"], name: "index_owx_official_accounts_on_platform_and_original_id", unique: true
    t.index ["third_party_platform_id"], name: "index_owx_official_accounts_on_third_party_platform_id"
  end

  create_table "owx_open_accounts", force: :cascade do |t|
    t.bigint "third_party_platform_id"
    t.string "app_id"
    t.string "principal_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["app_id"], name: "index_owx_open_accounts_on_app_id", unique: true
    t.index ["principal_name"], name: "index_owx_open_accounts_on_principal_name", unique: true
    t.index ["third_party_platform_id"], name: "index_owx_open_accounts_on_third_party_platform_id"
  end

  create_table "owx_third_party_platforms", force: :cascade do |t|
    t.string "uid"
    t.string "name"
    t.string "app_id"
    t.string "app_secret"
    t.string "messages_checking_token"
    t.string "message_encryption_key"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["app_id"], name: "index_owx_third_party_platforms_on_app_id", unique: true
    t.index ["uid"], name: "index_owx_third_party_platforms_on_uid", unique: true
  end

  create_table "owx_verify_files", force: :cascade do |t|
    t.string "name"
    t.text "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_owx_verify_files_on_name", unique: true
  end

  create_table "owx_website_apps", force: :cascade do |t|
    t.string "name"
    t.string "app_id"
    t.string "app_secret"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["app_id"], name: "index_owx_website_apps_on_app_id", unique: true
  end

  create_table "short_url_links", force: :cascade do |t|
    t.text "original_url"
    t.datetime "created_at", precision: nil, null: false
    t.index ["original_url"], name: "index_short_url_links_on_original_url", unique: true
  end

  create_table "taggings", force: :cascade do |t|
    t.bigint "tag_id"
    t.string "taggable_type"
    t.bigint "taggable_id"
    t.string "tagger_type"
    t.bigint "tagger_id"
    t.string "context", limit: 128
    t.datetime "created_at", precision: nil
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
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "taggings_count", default: 0
    t.index ["name"], name: "index_tags_on_name", unique: true
  end

  create_table "tnt_domains", force: :cascade do |t|
    t.bigint "tenant_id"
    t.string "name"
    t.string "wechat_app_id"
    t.string "wechat_app_secret"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["tenant_id"], name: "index_tnt_domains_on_tenant_id", unique: true
  end

  create_table "tnt_fund_transfers", force: :cascade do |t|
    t.bigint "tenant_id"
    t.bigint "transfer_out_account_id"
    t.bigint "transfer_in_account_id"
    t.string "uid", null: false
    t.decimal "amount", precision: 2, scale: 2
    t.integer "state"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["tenant_id"], name: "index_tnt_fund_transfers_on_tenant_id"
    t.index ["transfer_in_account_id"], name: "index_tnt_fund_transfers_on_transfer_in_account_id"
    t.index ["transfer_out_account_id"], name: "index_tnt_fund_transfers_on_transfer_out_account_id"
    t.index ["uid"], name: "index_tnt_fund_transfers_on_uid", unique: true
  end

  create_table "tnt_phones", force: :cascade do |t|
    t.bigint "user_id"
    t.string "number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["number"], name: "index_tnt_phones_on_number", unique: true
    t.index ["user_id"], name: "index_tnt_phones_on_user_id", unique: true
  end

  create_table "tnt_profiles", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "nickname"
    t.string "locale"
    t.string "time_zone"
    t.datetime "last_sign_in_at"
    t.jsonb "custom_settings", default: {}
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_tnt_profiles_on_user_id", unique: true
  end

  create_table "tnt_recharges", force: :cascade do |t|
    t.bigint "tenant_id", null: false
    t.string "uid"
    t.decimal "amount", precision: 12, scale: 2
    t.integer "state"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.jsonb "properties"
    t.index ["tenant_id"], name: "index_tnt_recharges_on_tenant_id"
    t.index ["uid"], name: "index_tnt_recharges_on_uid", unique: true
  end

  create_table "tnt_tenant_ext_infos", force: :cascade do |t|
    t.bigint "tenant_id"
    t.datetime "expires_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "wechat_oauth_scope"
    t.string "permissions", default: [], array: true
    t.integer "implicit_auth_mode"
    t.index ["tenant_id"], name: "index_tnt_tenant_ext_infos_on_tenant_id", unique: true
  end

  create_table "tnt_tenant_wechat_official_account_mappings", force: :cascade do |t|
    t.bigint "tenant_id", null: false
    t.bigint "wechat_official_account_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["tenant_id"], name: "index_tnt_tenant_wechat_oa_mapping_on_tennat", unique: true
    t.index ["wechat_official_account_id"], name: "index_tnt_tenant_wechat_oa_mapping_on_wechat_oa"
  end

  create_table "tnt_tenant_wechat_work_corporation_mappings", force: :cascade do |t|
    t.bigint "tenant_id", null: false
    t.bigint "wechat_work_corporation_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["tenant_id"], name: "index_tnt_tenant_wecom_corp_mapping_on_tennat", unique: true
    t.index ["wechat_work_corporation_id"], name: "index_tnt_tenant_wecom_corp_mapping_on_corp"
  end

  create_table "tnt_tenants", force: :cascade do |t|
    t.bigint "agency_id"
    t.bigint "organization_id", null: false
    t.string "uid"
    t.string "name"
    t.integer "state"
    t.jsonb "custom_settings", default: {}
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["agency_id"], name: "index_tnt_tenants_on_agency_id"
    t.index ["name"], name: "index_tnt_tenants_on_name", unique: true
    t.index ["organization_id"], name: "index_tnt_tenants_on_organization_id"
    t.index ["uid"], name: "index_tnt_tenants_on_uid", unique: true
  end

  create_table "tnt_user_credentials", force: :cascade do |t|
    t.bigint "user_id"
    t.string "user_agent"
    t.string "code"
    t.string "token"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["code"], name: "index_tnt_user_credentials_on_code", unique: true
    t.index ["token"], name: "index_tnt_user_credentials_on_token", unique: true
    t.index ["user_id"], name: "index_tnt_user_credentials_on_user_id"
  end

  create_table "tnt_users", force: :cascade do |t|
    t.bigint "tenant_id", null: false
    t.string "name"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "root"
    t.index ["name"], name: "index_tnt_users_on_name", unique: true, where: "(root = true)"
    t.index ["tenant_id", "name"], name: "index_tnt_users_on_tenant_id_and_name", unique: true
    t.index ["tenant_id"], name: "index_tnt_users_on_tenant_id"
  end

  create_table "tnt_withdraw_settings", force: :cascade do |t|
    t.bigint "tenant_id"
    t.integer "payment_method"
    t.string "real_name"
    t.jsonb "custom_settings", default: {}
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["tenant_id"], name: "index_tnt_withdraw_settings_on_tenant_id", unique: true
  end

  create_table "tnt_withdrawals", force: :cascade do |t|
    t.bigint "tenant_id", null: false
    t.bigint "account_id", null: false
    t.string "uid"
    t.decimal "amount", precision: 12, scale: 2
    t.integer "state"
    t.text "description"
    t.datetime "created_at", null: false
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

  create_table "usr_locations", force: :cascade do |t|
    t.bigint "user_id"
    t.string "coordinate_type"
    t.float "latitude"
    t.float "longitude"
    t.float "speed"
    t.float "accuracy"
    t.string "division_code"
    t.string "province"
    t.string "city"
    t.string "district"
    t.string "street"
    t.string "address"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_usr_locations_on_user_id"
  end

  create_table "usr_phones", force: :cascade do |t|
    t.string "number", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["number"], name: "index_usr_phones_on_number", unique: true
  end

  create_table "usr_profiles", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "nickname"
    t.string "locale"
    t.string "time_zone"
    t.integer "gender"
    t.date "birthday"
    t.datetime "last_sign_in_at"
    t.jsonb "custom_settings"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_usr_profiles_on_user_id", unique: true
  end

  create_table "usr_shipping_addresses", force: :cascade do |t|
    t.bigint "user_id"
    t.string "consignee_name"
    t.string "consignee_tel"
    t.string "province_code"
    t.string "city_code"
    t.string "district_code"
    t.string "postal_code"
    t.string "detail_info"
    t.boolean "default", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_usr_shipping_addresses_on_user_id"
  end

  create_table "usr_user_credentials", force: :cascade do |t|
    t.bigint "user_id"
    t.string "user_agent"
    t.string "code"
    t.string "token"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["code"], name: "index_usr_user_credentials_on_code", unique: true
    t.index ["token"], name: "index_usr_user_credentials_on_token", unique: true
    t.index ["user_id"], name: "index_usr_user_credentials_on_user_id"
  end

  create_table "usr_user_origins", force: :cascade do |t|
    t.bigint "user_id"
    t.string "origin_type"
    t.bigint "origin_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["origin_type", "origin_id"], name: "index_usr_user_origins_on_origin"
    t.index ["user_id", "origin_id", "origin_type"], name: "index_usr_user_origins_on_user_and_origin", unique: true
    t.index ["user_id"], name: "index_usr_user_origins_on_user_id"
  end

  create_table "usr_users", force: :cascade do |t|
    t.string "uid", null: false
    t.string "name"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_usr_users_on_name", unique: true
    t.index ["uid"], name: "index_usr_users_on_uid", unique: true
  end

  create_table "usr_wechat_users", force: :cascade do |t|
    t.string "open_id", null: false
    t.string "union_id"
    t.string "app_id"
    t.string "nickname"
    t.string "avatar_url"
    t.boolean "subscribe"
    t.datetime "subscribed_at", precision: nil
    t.string "subscribe_scene"
    t.string "refresh_token"
    t.string "auth_scope"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["app_id"], name: "index_usr_wechat_users_on_app_id"
    t.index ["open_id"], name: "index_usr_wechat_users_on_open_id", unique: true
    t.index ["union_id"], name: "index_usr_wechat_users_on_union_id"
  end

  create_table "usr_withdrawals", force: :cascade do |t|
    t.bigint "account_id"
    t.string "uid"
    t.decimal "amount", precision: 12, scale: 2
    t.integer "state"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_usr_withdrawals_on_account_id"
    t.index ["uid"], name: "index_usr_withdrawals_on_uid", unique: true
  end

  create_table "wxpay_api_client_certificates", force: :cascade do |t|
    t.bigint "vendor_id"
    t.datetime "effective_at"
    t.datetime "expire_at"
    t.string "serial_no"
    t.text "key"
    t.text "cert"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["vendor_id"], name: "index_wxpay_api_client_certificates_on_vendor_id"
  end

  create_table "wxpay_busifavor_coupons", force: :cascade do |t|
    t.string "origin_type"
    t.bigint "origin_id"
    t.string "stock_id"
    t.string "send_request_no"
    t.string "use_request_no"
    t.string "return_request_no"
    t.string "deactivate_request_no"
    t.string "deactivate_reason"
    t.string "code"
    t.string "stock_name"
    t.string "comment"
    t.string "goods_name"
    t.integer "stock_type"
    t.integer "state"
    t.jsonb "coupon_use_rule"
    t.datetime "available_start_time"
    t.datetime "expire_time"
    t.datetime "receive_time"
    t.datetime "use_time"
    t.datetime "return_time"
    t.datetime "deactivate_time"
    t.string "app_id"
    t.string "open_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["code"], name: "index_wxpay_busifavor_coupons_on_code", unique: true
    t.index ["origin_type", "origin_id"], name: "index_wxpay_busifavor_coupons_on_origin", unique: true
    t.index ["send_request_no"], name: "index_wxpay_busifavor_coupons_on_send_request_no", unique: true
    t.index ["stock_id"], name: "index_wxpay_busifavor_coupons_on_stock_id"
    t.index ["use_request_no"], name: "index_wxpay_busifavor_coupons_on_use_request_no", unique: true
  end

  create_table "wxpay_busifavor_stocks", force: :cascade do |t|
    t.string "origin_type"
    t.bigint "origin_id"
    t.string "stock_id"
    t.string "out_request_no"
    t.string "belong_merchant"
    t.string "stock_name"
    t.string "comment"
    t.string "goods_name"
    t.integer "stock_type"
    t.integer "state"
    t.integer "coupon_code_mode"
    t.jsonb "coupon_use_rule"
    t.jsonb "stock_send_rule"
    t.jsonb "custom_entrance"
    t.jsonb "display_pattern_info"
    t.jsonb "notify_config"
    t.jsonb "send_count_information"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["belong_merchant"], name: "index_wxpay_busifavor_stocks_on_belong_merchant"
    t.index ["origin_type", "origin_id"], name: "index_wxpay_busifavor_stocks_on_origin", unique: true
    t.index ["out_request_no"], name: "index_wxpay_busifavor_stocks_on_out_request_no", unique: true
    t.index ["stock_id"], name: "index_wxpay_busifavor_stocks_on_stock_id", unique: true
  end

  create_table "wxpay_capital_bank_branches", force: :cascade do |t|
    t.string "bank_alias_code"
    t.string "bank_branch_name"
    t.string "bank_branch_id"
    t.string "province_name"
    t.string "province_code"
    t.string "city_name"
    t.string "city_code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["bank_alias_code"], name: "index_wxpay_capital_bank_branches_on_bank_alias_code"
  end

  create_table "wxpay_capital_corporate_banks", force: :cascade do |t|
    t.string "account_bank"
    t.integer "account_bank_code"
    t.string "bank_alias"
    t.string "bank_alias_code"
    t.boolean "need_bank_branch"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "wxpay_capital_personal_banks", force: :cascade do |t|
    t.string "account_bank"
    t.integer "account_bank_code"
    t.string "bank_alias"
    t.string "bank_alias_code"
    t.boolean "need_bank_branch"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "wxpay_ecommerce_applyments", force: :cascade do |t|
    t.string "owner_type"
    t.bigint "owner_id"
    t.integer "state"
    t.string "out_request_no"
    t.string "merchant_shortname"
    t.integer "organization_type"
    t.jsonb "business_license_info"
    t.jsonb "id_card_info"
    t.boolean "need_account_info"
    t.jsonb "account_info"
    t.jsonb "contact_info"
    t.jsonb "sales_scene_info"
    t.jsonb "qualifications"
    t.jsonb "business_addition_pics"
    t.text "business_addition_desc"
    t.string "applyment_id"
    t.text "state_desc"
    t.string "sign_state"
    t.string "sign_url"
    t.jsonb "account_validation"
    t.jsonb "audit_detail"
    t.string "legal_validation_url"
    t.string "sub_mch_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["out_request_no"], name: "index_wxpay_ecommerce_applyments_on_out_request_no", unique: true
    t.index ["owner_type", "owner_id"], name: "index_wxpay_ecommerce_applyments_on_owner"
  end

  create_table "wxpay_partner_applyments", force: :cascade do |t|
    t.string "owner_type"
    t.bigint "owner_id"
    t.string "business_code"
    t.jsonb "contact_info"
    t.jsonb "subject_info"
    t.jsonb "business_info"
    t.jsonb "settlement_info"
    t.jsonb "bank_account_info"
    t.jsonb "addition_info"
    t.string "applyment_id"
    t.string "sign_url"
    t.string "sub_mch_id"
    t.integer "state"
    t.text "state_message"
    t.jsonb "audit_detail"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["business_code"], name: "index_wxpay_partner_applyments_on_business_code", unique: true
    t.index ["owner_type", "owner_id"], name: "index_wxpay_sub_applyments_on_owner"
  end

  create_table "wxpay_platform_certificates", force: :cascade do |t|
    t.bigint "vendor_id"
    t.datetime "effective_at"
    t.datetime "expire_at"
    t.string "serial_no"
    t.text "cert"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["vendor_id"], name: "index_wxpay_platform_certificates_on_vendor_id"
  end

  create_table "wxpay_profit_sharing_receivers", force: :cascade do |t|
    t.bigint "vendor_id"
    t.string "app_id"
    t.integer "account_type"
    t.string "account"
    t.string "name"
    t.integer "relation_type"
    t.string "custom_relation"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account", "vendor_id", "app_id"], name: "index_wxpay_profit_sharing_receivers_on_vendor_app_account", unique: true
    t.index ["vendor_id"], name: "index_wxpay_profit_sharing_receivers_on_vendor_id"
  end

  create_table "wxpay_settlement_accounts", force: :cascade do |t|
    t.string "sub_mch_id"
    t.string "account_type"
    t.string "account_bank"
    t.string "bank_address_code"
    t.string "bank_name"
    t.string "bank_branch_id"
    t.string "account_number"
    t.string "verify_result"
    t.text "verify_fail_reason"
    t.integer "state"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["sub_mch_id"], name: "index_wxpay_settlement_accounts_on_sub_mch_id"
  end

  create_table "wxpay_vendors", force: :cascade do |t|
    t.string "mch_id"
    t.integer "type"
    t.string "v2_key"
    t.text "comment"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.string "v3_key"
    t.string "sp_mch_id"
    t.decimal "fee_rate", precision: 4, scale: 4
    t.index ["mch_id"], name: "index_wxpay_vendors_on_mch_id", unique: true
    t.index ["sp_mch_id"], name: "index_wxpay_vendors_on_sp_mch_id"
  end

  create_table "wxpay_verify_files", force: :cascade do |t|
    t.string "name"
    t.text "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_wxpay_verify_files_on_name", unique: true
  end

  add_foreign_key "org_users", "org_organizations", column: "organization_id"
  add_foreign_key "taggings", "tags"
end
