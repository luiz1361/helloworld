#!/bin/sh

if curl -s http://helloworld:80 | grep -q 'Nginx running'; then
  echo "Tests passed!"
  exit 0
else
  echo "Tests failed!"
  exit 1
fi
