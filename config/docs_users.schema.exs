@moduledoc """
A schema is a keyword list which represents how to map, transform, and validate
configuration values parsed from the .conf file. The following is an explanation of
each key in the schema definition in order of appearance, and how to use them.

## Import

A list of application names (as atoms), which represent apps to load modules from
which you can then reference in your schema definition. This is how you import your
own custom Validator/Transform modules, or general utility modules for use in
validator/transform functions in the schema. For example, if you have an application
`:foo` which contains a custom Transform module, you would add it to your schema like so:

`[ import: [:foo], ..., transforms: ["myapp.some.setting": MyApp.SomeTransform]]`

## Extends

A list of application names (as atoms), which contain schemas that you want to extend
with this schema. By extending a schema, you effectively re-use definitions in the
extended schema. You may also override definitions from the extended schema by redefining them
in the extending schema. You use `:extends` like so:

`[ extends: [:foo], ... ]`

## Mappings

Mappings define how to interpret settings in the .conf when they are translated to
runtime configuration. They also define how the .conf will be generated, things like
documention, @see references, example values, etc.

See the moduledoc for `Conform.Schema.Mapping` for more details.

## Transforms

Transforms are custom functions which are executed to build the value which will be
stored at the path defined by the key. Transforms have access to the current config
state via the `Conform.Conf` module, and can use that to build complex configuration
from a combination of other config values.

See the moduledoc for `Conform.Schema.Transform` for more details and examples.

## Validators

Validators are simple functions which take two arguments, the value to be validated,
and arguments provided to the validator (used only by custom validators). A validator
checks the value, and returns `:ok` if it is valid, `{:warn, message}` if it is valid,
but should be brought to the users attention, or `{:error, message}` if it is invalid.

See the moduledoc for `Conform.Schema.Validator` for more details and examples.
"""
[
  extends: [],
  import: [],
  mappings: [
    "guardian.Elixir.Guardian.secret_key": [
      commented: false,
      datatype: :binary,
      default: "<REPLACE_SECRET_KEY>",
      # default: "l1jp*8SggVjlWpGI5QkFG3UUB&ob@lY@s4v^h83&Rv7YjI4yD8FqENTr^6ju40Cz",
      doc: "The secret key for JWT generation",
      hidden: false,
      to: "guardian.Elixir.Guardian.secret_key",
      env_var: "SECRET_KEY"
    ],
    "docs_users.Elixir.DocsUsers.Endpoint.url.host": [
      commented: false,
      datatype: :binary,
      default: "localhost",
      doc: "Provide documentation for docs_users.Elixir.DocsUsers.Endpoint.url.host here.",
      hidden: false,
      to: "docs_users.Elixir.DocsUsers.Endpoint.url.host",
      env_var: "HOST"
    ],
    "docs_users.Elixir.DocsUsers.Endpoint.secret_key_base": [
      commented: false,
      datatype: :binary,
      default: "<REPLACE_SECRET_KEY>",
      # default: "unz4/TtUrgBerGdtGWgQMmv4tKPzrSd/agahUaHsWTMEP48ZiTx0PNuq4m+Xftmu",
      doc: "The secret key base for the elixir endpoint",
      hidden: false,
      to: "docs_users.Elixir.DocsUsers.Endpoint.secret_key_base",
      env_var: "SECRET_KEY"
    ],
    "docs_users.Elixir.DocsUsers.Endpoint.http.port": [
      commented: false,
      datatype: :integer,
      default: 4000,
      doc: "The port where the elixir application will listen on",
      hidden: false,
      to: "docs_users.Elixir.DocsUsers.Endpoint.http.port",
      env_var: "PORT"
    ],
    "docs_users.Elixir.DocsUsers.Repo.username": [
      commented: false,
      datatype: :binary,
      default: "users",
      doc: "The username for connecting to the database",
      hidden: false,
      to: "docs_users.Elixir.DocsUsers.Repo.username",
      env_var: "DB_USERNAME"
    ],
    "docs_users.Elixir.DocsUsers.Repo.password": [
      commented: false,
      datatype: :binary,
      default: "secret",
      doc: "The password for connecting to the database",
      hidden: false,
      to: "docs_users.Elixir.DocsUsers.Repo.password",
      env_var: "DB_PASSWORD"
    ],
    "docs_users.Elixir.DocsUsers.Repo.database": [
      commented: false,
      datatype: :binary,
      default: "users",
      doc: "The name of the database to connect to",
      hidden: false,
      to: "docs_users.Elixir.DocsUsers.Repo.database",
      env_var: "DB_DATABASE"
    ],
    "docs_users.Elixir.DocsUsers.Repo.hostname": [
      commented: false,
      datatype: :binary,
      default: "users-db",
      doc: "The hostname of the database to connect to",
      hidden: false,
      to: "docs_users.Elixir.DocsUsers.Repo.hostname",
      env_var: "DB_HOSTNAME"
    ]
  ],
  transforms: [],
  validators: []
]
