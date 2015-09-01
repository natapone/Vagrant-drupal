apt-get update --force-yes
apt-get -f install
apt-get install -y curl

locale-gen en_US.UTF-8 th_TH.UTF-8 # add Thai language
dpkg-reconfigure locales

# fix perl local
echo -e 'LANGUAGE=en_US.UTF-8
LANG=en_US.UTF-8
LC_ALL=en_US.UTF-8
LC_CTYPE=en_US.UTF-8' > /etc/default/locale
