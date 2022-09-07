#! /bin/sh

mkdir /home/ubuntu/heliactyl
cd /home/ubuntu/heliactyl || exit 1;

if [[ -f "/home/ubuntu/heliactyl/index.js" ]]; then
  node index.js
else
  echo "Continue installing Heliactyl? (Y/N)";
  read proceed;

  case "$proceed" in
    "Y"|"y")
        echo "Installing Heliactyl...";

        git clone https://gitlab.com/heliactyl/panel.git /home/ubuntu/heliactyl
		mv /home/ubuntu/heliactyl/panel/** /home/ubuntu/heliactyl
        npm install

        echo "Heliactyl is now installed, to configure it and do the nginx config please refer to: https://gitlab.com/heliactyl/panel";
        exit 0;
        ;;
    "N"|"n")
        exit 0;
        ;;
    *)
        exit 1;
        ;;
    esac
fi
