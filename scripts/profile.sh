#!/usr/bin/env bash

# 쉬고 있는 profile 찾기 : real1이 사용 중이면 real2가 쉬고 있고, 반대면 real1이 쉬고 있음.

function find_idle_profile()
{
  RESPONSE_CODE=$(curl -s -o /dev/null -w "%{http_code}" http://localhost/profile)
  echo "<<<<>>>>>RESPONSE_CODE = $RESPONSE_CODE"

  if [ ${RESPONSE_CODE} -ge 400 ]
  then
    CURRENT_PROFILE=real2
    echo "<<<<>>>>>CURRENT_PROFILE111 = $CURRENT_PROFILE"
  else
    CURRENT_PROFILE=$(curl -s http://localhost/profile)
    echo "<<<<>>>>>CURRENT_PROFILE222 = $CURRENT_PROFILE"
  fi

  if [ ${CURRENT_PROFILE} == real1 ]
  then
    IDLE_PROFILE=real2
  else
    IDLE_PROFILE=real1
  fi

  echo "${IDLE_PROFILE}"
}

# 쉬고 있는 profile의 port 찾기
function find_idle_port()
{
  IDLE_PROFILE=$(find_idle_profile)

  if [ ${IDLE_PROFILE} == real1 ]
  then
    echo "8082"
  else
    echo "8083"
  fi
}