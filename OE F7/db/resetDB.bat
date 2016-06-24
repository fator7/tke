@echo off
cls

if exist dbsF7.db (
  echo y | prodel dbsF7
)

prodb dbsF7 empty

proutil dbsF7 -C truncate bi

