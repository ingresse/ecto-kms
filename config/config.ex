use Mix.Config

#########################
# AWS
#########################
config :ex_aws, :kms,
  scheme: "http://",
  host: "local_kms",
  port: 8080,
  region: "us-east-1",
  json_codec: Poison,
  access_key_id: [
    "",
    :instance_role
  ],
  secret_access_key: [
    "",
    :instance_role
  ]

import_config "#{Mix.env()}.exs"
