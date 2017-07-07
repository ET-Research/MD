#!/bin/sh

num=2
namd2 +p$num +replicas $num namd/rex.namd
