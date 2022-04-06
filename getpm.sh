#!/bin/bash

declare -A osInfo

osInfo["/etc/debian_version"]=apt
osInfo["/etc/centos-release"]=yum
osInfo["/etc/SuSE-release"]=zypp
osInfo["/etc/fedora-release"]=dnf
osInfo["/etc/arch-release"]=pacman
