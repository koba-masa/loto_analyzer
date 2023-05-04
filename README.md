# loto_analyzer
[![CI](https://github.com/koba-masa/loto_analyzer/actions/workflows/ci.yml/badge.svg)](https://github.com/koba-masa/loto_analyzer/actions/workflows/ci.yml)
[![Deploy](https://github.com/koba-masa/loto_analyzer/actions/workflows/deploy.yml/badge.svg)](https://github.com/koba-masa/loto_analyzer/actions/workflows/deploy.yml)

## ジョブの手動実行
### Loto6
```sh
bundle exec rails runner "::Loto6::LatestRegistrationJob.perform_now(<URL>)"
```
