#!/bin/bash
for i in {1..200}; 
do
   curl 172.16.132.34:8080
   sleep 1
done
