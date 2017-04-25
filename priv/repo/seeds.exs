# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     DocsUsers.Repo.insert!(%DocsUsers.SomeModel{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
DocsUsers.Repo.insert!(%DocsUsers.V1.User{email: "tester@appuio.ch", password: "abcd", active: true})
