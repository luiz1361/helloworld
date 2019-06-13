FROM nginx:alpine

COPY nginx/default.conf /etc/nginx/conf.d/default.conf
COPY nginx/index.html /usr/share/nginx/html/index.html
COPY test_scripts/smoketests.sh /

CMD ["nginx", "-g", "daemon off;"]
