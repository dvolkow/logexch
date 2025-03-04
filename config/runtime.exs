import Config
import Dotenvy

env_dir_prefix = System.get_env("RELEASE_ROOT") || Path.expand("./envs/")

source!([
  Path.absname("envs/.env"),
  Path.absname(".env", env_dir_prefix),
  Path.absname(".#{config_env()}.env", env_dir_prefix),
  System.get_env()
])

config :logexch,
  ch_user: env!("ch_user", :string),
  ch_password: env!("ch_password", :string)
