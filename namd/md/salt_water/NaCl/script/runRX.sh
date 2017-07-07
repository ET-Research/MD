#!/bin/sh

num=$1
namd2 +p$num +replicas $num namd/rex_1.namd
