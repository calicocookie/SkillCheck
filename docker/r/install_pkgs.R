dir=Sys.getenv('R_LIBS_USER')
dir.create(dir, recursive=TRUE)
pkgs = c(
  'e1071',
  'elasticnet',
  'gbm',
  'keras',
  'kernlab',
  'LiblineaR',
  'randomForest',
  'ranger',
  'readr',
  'xgboost',
  'topicmodels'
)
install.packages(pkgs, lib=dir, clean=TRUE)

# install.packagesでのパッケージインストール失敗はwarningになるだけなので、
# ちゃんとパッケージインストールできていなければエラー終了するようにする
installed_pkgs = rownames(installed.packages(lib.loc=dir))
if (!all(pkgs %in% installed_pkgs)) {
  stop("failed installing packages")
}
