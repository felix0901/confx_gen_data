#!/bin/bash

for x in 1 2 3 4 5 6 7 8 9 10
do
  python main.py --model mobilenet_v2 --df dla --mul 0.5 --filename $x &
  python main.py --model mobilenet_v2 --df dla --mul 0.3 --filename $x &
  python main.py --model mobilenet_v2 --df dla --mul 0.1 --filename $x &



  python main.py --model mobilenet_v2 --df shi --mul 0.5  --filename $x &
  python main.py --model mobilenet_v2 --df shi --mul 0.3  --filename $x &
  python main.py --model mobilenet_v2 --df shi --mul 0.1  --filename $x &



  python main.py --model resnet50 --df dla --mul 0.5 --filename $x &
  python main.py --model resnet50 --df dla --mul 0.3 --filename $x &
  python main.py --model resnet50 --df dla --mul 0.1 --filename $x &
done
