class CleanForeignKeyConstraints < ActiveRecord::Migration[7.0]
  def change
    remove_foreign_key :active_storage_attachments, to_table: :active_storage_blobs, column: :blob_id
    remove_foreign_key :active_storage_variant_records, to_table: :active_storage_blobs, column: :blob_id

    remove_foreign_key :omni_account_account_histories, to_table: :omni_account_accounts, column: :account_id
    remove_foreign_key :omni_account_account_histories, to_table: :omni_account_entries, column: :entry_id
    remove_foreign_key :omni_region_divisions, to_table: :omni_region_divisions, column: :parent_id
    remove_foreign_key :wxpay_api_client_certificates, to_table: :wxpay_vendors, column: :vendor_id
    remove_foreign_key :wxpay_platform_certificates, to_table: :wxpay_vendors, column: :vendor_id
    remove_foreign_key :owx_message_handlers, to_table: :owx_official_accounts, column: :official_account_id
    remove_foreign_key :owx_official_accounts, to_table: :owx_third_party_platforms, column: :third_party_platform_id
    remove_foreign_key :owx_open_accounts, to_table: :owx_third_party_platforms, column: :third_party_platform_id
    remove_foreign_key :usr_profiles, to_table: :usr_users, column: :user_id
    remove_foreign_key :tnt_users, to_table: :tnt_tenants, column: :tenant_id
  end
end
